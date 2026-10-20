#!/usr/bin/env node
import{readFileSync,writeFileSync,existsSync}from'node:fs';
import{createHash}from'node:crypto';
import{readPNG}from'./lib/png.mjs';
const failures=[],check=(ok,message)=>{if(!ok)failures.push(message)},hash=p=>createHash('sha256').update(readFileSync(p)).digest('hex'),pack=process.argv[2]||'art/review-whip-impact-r01',prefix=process.argv[3]||'evidence/whip-impact-r01';
const verdict=pack+'/review_verdict.md';check(existsSync(verdict)&&readFileSync(verdict,'utf8').trimEnd().endsWith('REVIEW: PASS'),'fresh independent review must pass');
let sourceFrames=0,samples=0;const visibility=[];
for(let frame=0;frame<6;frame++){
 const name='f'+String(frame).padStart(3,'0')+'.png',paths=['art/frames/vfx_whip_impact/'+name,'game/assets/vfx/vfx_whip_impact/'+name,pack+'/frames/vfx_whip_impact/'+name];
 if(!paths.every(existsSync)){check(false,'missing source/runtime/review frame '+frame);continue}
 check(paths.every(p=>hash(p)===hash(paths[0])),'exact approved bytes '+frame);const im=readPNG(paths[0]);check(im.width===192&&im.height===192,'native canvas '+frame);sourceFrames++;
}
for(const resolution of ['native','phone']){
 const dir=prefix+'-'+resolution,capture=JSON.parse(readFileSync(dir+'/capture.json')),seen=new Set();check(capture.physical_device===false&&capture.records.length===10,'ten isolated fixtures '+resolution);
 for(const r of capture.records){
  const label=resolution+':'+r.direction+':'+r.target_kind+':'+r.mode;seen.add(r.direction+':'+r.target_kind+':'+r.mode);
  if(r.target_kind==='boss')check(r.start_hp===8&&r.end_hp===7,'actual8HP hit '+label);
  if(r.target_kind==='swooper')check(r.start_hp===1&&r.end_hp===0,'actual circular lethal hit '+label);
  const phases=r.samples.filter(s=>s.file.startsWith('impact-')),frames=new Set(phases.map(s=>s.effect_frame));check(frames.size===6&&[...frames].every(f=>f>=0&&f<6),'six phases '+label);
  const point=phases[0]?.effect_position;let start=0;const ms=[40,40,40,50,50,60];
  for(let frame=0;frame<6;frame++){const s=phases.find(s=>s.effect_frame===frame);check(s&&s.effect_age>=start/1000-.00001&&s.effect_age<(start+ms[frame])/1000,'phase timing '+label+':'+frame);start+=ms[frame]}
  for(const s of r.samples){
   const path=dir+'/'+s.file;if(!existsSync(path)){check(false,'missing image '+path);continue}const im=readPNG(path),size=resolution==='native'?[1280,720]:[698,393];check(im.width===size[0]&&im.height===size[1],'actual image dimensions '+path);samples++;
   if(s.file.startsWith('before-'))check(s.burst_count===0,'no pre-contact effect '+path);
   else if(s.file.startsWith('expired-'))check(s.burst_count===0&&s.sequence_elapsed>=.28&&s.sequence_elapsed<.30,'280ms removal '+path);
   else check(s.burst_count===1&&JSON.stringify(s.effect_position)===JSON.stringify(point),'one stationary contact burst '+path);
   if(s.file.startsWith('paused-'))check(s.paused===true&&s.effect_age===phases.find(p=>p.effect_frame===3)?.effect_age,'paused phase held '+path);
   if(r.target_kind==='effigy'&&!s.file.startsWith('before-'))check(!s.effigy_alive,'actual effigy destroyed '+path);
  }
  const reduced=r.samples.find(s=>s.file.startsWith('reduced-'));
  if(r.target_kind==='boss'&&r.mode==='ground'){
   check(reduced?.reduced_effects===true&&reduced.effect_frame===2,'reduced peak captured '+label);
   if(reduced){const normal=phases.find(s=>s.effect_frame===2),a=readPNG(dir+'/'+normal.file),b=readPNG(dir+'/'+reduced.file),[cx,cy]=normal.effect_image_point,radius=Math.ceil(48*a.height/720)+2;let changed=0;
    for(let y=Math.max(0,Math.floor(cy-radius));y<Math.min(a.height,cy+radius);y++)for(let x=Math.max(0,Math.floor(cx-radius));x<Math.min(a.width,cx+radius);x++){const k=(y*a.width+x)*4;if([0,1,2].some(c=>Math.abs(a.data[k+c]-b.data[k+c])>10))changed++}
    check(changed>(resolution==='native'?20:4),'actual reduced paint differs locally '+label);visibility.push({fixture:label,changed_local_pixels:changed});
   }
  }
 }
 check(seen.size===10&&[1,-1].every(d=>['ground','crouch','air'].every(m=>seen.has(d+':boss:'+m))&&['swooper','effigy'].every(k=>seen.has(d+':'+k+':ground'))),'both facings and all contact fixtures '+resolution);
}
const result={mandatory_clip:'vfx_whip_impact',source_frames:sourceFrames,actual_capture_samples:samples,visibility,independent_review:verdict,physical_device:false,failures};writeFileSync(prefix+'-inventory.json',JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));if(failures.length)process.exit(1);
