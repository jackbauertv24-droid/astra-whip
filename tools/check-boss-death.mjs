#!/usr/bin/env node
import{readFileSync,existsSync,writeFileSync}from'node:fs';
import{createHash}from'node:crypto';
import{readPNG}from'./lib/png.mjs';
const pack=process.argv[2]||'art/review-boss-death-r04',prefix=process.argv[3]||'evidence/boss-death-r04';
const failures=[],check=(ok,msg)=>{if(!ok)failures.push(msg)},sha=p=>createHash('sha256').update(readFileSync(p)).digest('hex');
const verdict=pack+'/review_verdict.md';check(existsSync(verdict)&&readFileSync(verdict,'utf8').trimEnd().endsWith('REVIEW: PASS'),'fresh independent review must pass');
const contract=JSON.parse(readFileSync('contract/art_contract.json')),spec=contract.clips.boss_death;
check(spec.ms.length===12&&spec.ms.every(ms=>ms===90)&&!spec.loop,'authoritative twelve90ms nonlooping frames');
let sourceFrames=0,samples=0;
for(let frame=0;frame<12;frame++){
 const name='f'+String(frame).padStart(3,'0')+'.png',source='art/frames/boss_death/'+name,runtime='game/assets/boss/boss_death/'+name,review=pack+'/frames/boss_death/'+name;
 if(!existsSync(source)||!existsSync(runtime)||!existsSync(review)){check(false,'missing source/runtime/review frame '+frame);continue}
 check(sha(source)===sha(runtime)&&sha(source)===sha(review),'exact approved bytes '+frame);
 const image=readPNG(source);check(image.width===512&&image.height===576,'native canvas '+frame);sourceFrames++;
}
for(const resolution of ['native','phone']){
 const dir=prefix+'-'+resolution,file=dir+'/capture.json';if(!existsSync(file)){check(false,'missing capture '+resolution);continue}
 const capture=JSON.parse(readFileSync(file));check(capture.physical_device===false,'no physical-device claim');check(capture.records.length===4,'four entry/facing fixtures '+resolution);
 const seen=new Set();
 for(const record of capture.records){
  seen.add(record.direction+':'+record.entry_fixture);
  check(record.first_frame_preserves_entry===true&&record.death_entry_animation==='boss_'+record.entry_fixture&&record.death_entry_frame>=0,'exact lethal entry paint preserved '+resolution);
  check(record.production_start_hp===8&&JSON.stringify(record.actual_whip_hit_hp)==='[7,6,5,4,3,2,1,0]','eight actual whip hits '+resolution);
  const death=record.samples.filter(s=>s.file.startsWith('death-')),frames=new Set(death.map(s=>s.frame));
  check(frames.size===12&&[...frames].every(f=>f>=0&&f<12),'all twelve frames '+resolution);
  let origin;
  for(const sample of record.samples){
   const path=dir+'/'+sample.file;check(existsSync(path),'image exists '+path);if(!existsSync(path))continue;
   const image=readPNG(path),size=resolution==='native'?[1280,720]:[698,393];check(image.width===size[0]&&image.height===size[1],'actual engine image size '+path);samples++;
   origin??=sample.position;check(JSON.stringify(sample.position)===JSON.stringify(origin),'fixed root '+path);
   if(sample.file.startsWith('before-'))continue;
   check(sample.state==='death'&&sample.hp===0,'dead state/HP '+path);
   if(sample.elapsed<1.08)check(!sample.exit_unlocked&&sample.alpha===1&&sample.visible,'complete opaque sequence before unlock '+path);
   if(sample.elapsed>=1.08)check(sample.exit_unlocked,'exit unlock deadline '+path);
   if(sample.file.startsWith('cleanup-'))check(!sample.visible&&sample.elapsed>1.2,'cleanup after1200ms '+path);
   if(sample.file.startsWith('death-')){check(sample.animation==='boss_death','production death animation '+path);check(sample.elapsed>=sample.frame*.09-.009&&sample.elapsed<(sample.frame+1)*.09+.009,'frame timing '+path)}
  }
 }
 check(seen.size===4&&[1,-1].every(d=>['idle','strike_recover'].every(s=>seen.has(d+':'+s))),'both facings and standing/stooped entries '+resolution);
}
const result={mandatory_clip:'boss_death',source_frames:sourceFrames,engine_samples:samples,physical_device:false,independent_review:verdict,failures};writeFileSync(prefix+'-inventory.json',JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));if(failures.length)process.exit(1);
