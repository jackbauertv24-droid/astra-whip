#!/usr/bin/env node
import assert from'node:assert/strict';
import{readFileSync,readdirSync,writeFileSync}from'node:fs';
import{readPNG}from'./lib/png.mjs';
const contract=JSON.parse(readFileSync('contract/art_contract.json')),meta=JSON.parse(readFileSync('art/frames/clips.json')),review='art/review-boss-hazard-r02/review_verdict.md',verdict=readFileSync(review,'utf8');
assert(verdict.trimEnd().endsWith('REVIEW: PASS'),'fresh independent approval required');
const ids=['boss_hazard_windup','boss_hazard_execute','boss_hazard_recover','vfx_hazard_telegraph','vfx_hazard_eruption'];let frames=0;
for(const id of ids){assert(verdict.includes(id));const spec=contract.clips[id],actor=spec.actor==='vfx'?'vfx':'boss';assert.deepEqual(meta[id].ms,spec.ms);assert.equal(meta[id].loop,spec.loop);const names=readdirSync('art/frames/'+id).filter(f=>/^f\d{3}\.png$/.test(f)).sort();assert.equal(names.length,spec.ms.length);for(let i=0;i<names.length;i++){const name='f'+String(i).padStart(3,'0')+'.png';assert.equal(names[i],name);const bytes=readFileSync('art/frames/'+id+'/'+name);assert(bytes.equals(readFileSync('game/assets/'+actor+'/'+id+'/'+name)));assert(bytes.equals(readFileSync('art/review-boss-hazard-r02/frames/'+id+'/'+name)),'reviewed source unchanged');}frames+=names.length;}
assert.equal(frames,28);
const context='boss_hurt_hazard_late';assert(verdict.includes(context));for(let f=0;f<3;f++){const name='f00'+f+'.png',bytes=readFileSync('art/variants/'+context+'/'+name);assert(bytes.equals(readFileSync('game/assets/boss/'+context+'/'+name)));assert(bytes.equals(readFileSync('art/review-boss-hazard-r02/frames/'+context+'/'+name)));}
const captures=[];
for(const viewport of ['native','phone']){
 const root='evidence/boss-hazard-r02-'+viewport,data=JSON.parse(readFileSync(root+'/capture.json'));assert.equal(data.physical_device,false);assert.equal(data.records.length,8);let count=0;
 for(const direction of[1,-1]){
  const full=data.records.find(r=>r.direction===direction&&r.branch==='full_cycle');assert(full);assert.equal(full.natural_alternation_after_strike,true);assert.equal(full.production_start_hp,8);assert.equal(full.outgoing_state,'walk');
  for(const state of['hazard_windup','hazard_execute','hazard_recover']){const samples=full.samples.filter(s=>s.state===state);assert.equal(new Set(samples.map(s=>s.frame)).size,contract.clips['boss_'+state].ms.length);const transition=full.transitions.find(t=>t.from===state);assert(Math.abs(transition.duration_ms-contract.clips['boss_'+state].ms.reduce((a,b)=>a+b,0))<10);assert(samples.every(s=>s.hp===8&&s.hero_hp===5));}
  for(const [state,id]of[['hazard_windup','vfx_hazard_telegraph'],['hazard_execute','vfx_hazard_eruption']]){const samples=full.samples.filter(s=>s.state===state);assert(samples.every(s=>s.effect_id===id));assert.equal(new Set(samples.map(s=>s.effect_frame)).size,contract.clips[id].ms.length,'all synchronized effect frames captured');}
  for(const context of['stooped','rising','hazard_late']){const branch=data.records.find(r=>r.direction===direction&&r.branch==='punish_'+context);assert(branch);assert.equal(branch.natural_alternation_after_strike,true);assert.equal(branch.production_start_hp,8);assert.equal(branch.final_hp,7);assert.equal(branch.outgoing_state,'walk');assert.equal(new Set(branch.samples.filter(s=>s.animation==='boss_hurt_'+context).map(s=>s.frame)).size,3);assert(Math.abs(branch.recovery_ms-900)<10);assert.equal(branch.full_commitment_inside_window,context!=='hazard_late');}
 }
 for(const branch of data.records)for(const sample of branch.samples){const bytes=readFileSync(root+'/'+sample.file);assert.deepEqual([bytes.readUInt32BE(16),bytes.readUInt32BE(20)],sample.image_size);assert.equal(sample.hero_hp,5);assert.deepEqual(sample.position,data.records[0].samples[0].position);count++;}captures.push({path:root+'/capture.json',samples:count,image_sizes:[...new Set(data.records.flatMap(r=>r.samples.map(s=>s.image_size.join('x'))))]});
}
let maxHeight=0;for(let f=0;f<6;f++){const im=readPNG('art/frames/vfx_hazard_eruption/f00'+f+'.png');let top=im.height;for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++)if(im.data[(y*im.width+x)*4+3]>=40)top=Math.min(top,y);maxHeight=Math.max(maxHeight,(176-top)*.5)}assert(maxHeight<=46);
assert.equal(JSON.parse(readFileSync('evidence/boss-hazard-visibility.json')).pass,true);
const audit=JSON.parse(readFileSync('art/review-boss-hazard-r02/audit.json'));assert.equal(audit.defects,0);assert.equal(audit.flags,0);
writeFileSync('evidence/boss-hazard-inventory.json',JSON.stringify({mandatory_clips:5,mandatory_frames:28,supplemental_hurt_frames:3,review,captures,all_frames_both_facings_native_phone:true,natural_alternation_and_real_whip_punish:true,max_eruption_height_world:maxHeight,remaining_boss_mandatory_frames:12,physical_device_tested:false,scripted_body_motion_quality_debt:true,capture_wrapper_exit:143,capture_script_completed_and_all_images_validated:true},null,2)+'\n');
console.log('PASS boss hazard:28mandatory +3context exact reviewed/runtime frames; natural alternation,allFXframes,bothfacings/sizes,actualpunishes,900ms recovery,eruption'+maxHeight+'u; boss death remains');
