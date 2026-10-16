#!/usr/bin/env node
// Complete actor delivery, scoped independent approval and engine frame coverage.
import{readFileSync,readdirSync,writeFileSync,existsSync}from'node:fs';
import assert from'node:assert/strict';
const contract=JSON.parse(readFileSync('contract/art_contract.json'));
const manifest=JSON.parse(readFileSync('art/frames/clips.json'));
const rows=[['perch_idle','idle'],['cruise','cruise'],['dive_telegraph','telegraph'],['dive','dive'],['recovery_climb','recovery'],['hurt','hurt'],['death_fall','death']];
const reports=[];
for(const[state,family]of rows){
 const id='swooper_'+state,spec=contract.clips[id],review=`art/review-swooper-${family}-${family==='death'?'r02':'r01'}/review_verdict.md`,verdict=readFileSync(review,'utf8');
 assert(verdict.trimEnd().endsWith('REVIEW: PASS')&&verdict.includes(id),'missing scoped acceptance '+id);
 assert.deepEqual(manifest[id].ms,spec.ms);assert.equal(manifest[id].loop,spec.loop);
 const names=readdirSync('art/frames/'+id).filter(n=>n.endsWith('.png')).sort();assert.equal(names.length,spec.ms.length);
 for(let frame=0;frame<names.length;frame++){
  assert.equal(names[frame],`f${String(frame).padStart(3,'0')}.png`);
  assert(readFileSync(`art/frames/${id}/${names[frame]}`).equals(readFileSync(`game/assets/swooper/${id}/${names[frame]}`)),'runtime source mismatch');
 }
 const captures=[];
 for(const viewport of['native','phone']){
  const path=`evidence/swooper-${family}-${viewport}/capture.json`,data=JSON.parse(readFileSync(path)),directions=new Map();
  assert.equal(data.physical_device,false);
  if(state==='hurt'){
   assert.equal(data.conditional_nonlethal_fixture,true);assert.equal(data.normal_production_hp,1);assert.equal(data.normal_lethal_state,'death_fall');
   for(const record of data.records){assert.equal(record.fixture_hp,2);assert.equal(record.hp_after_hit,1);}
  }
  if(state==='death_fall'){assert.equal(data.normal_production_hp,1);for(const record of data.records){assert.equal(record.production_hp,1);assert.equal(record.hp_after_hit,0);}}
  for(const record of data.records)for(const sample of record.samples)if(sample.state===state){
   assert(Number.isInteger(sample.frame)&&sample.frame>=0&&sample.frame<spec.ms.length);
   if(!directions.has(record.direction))directions.set(record.direction,new Set());directions.get(record.direction).add(sample.frame);
   assert(existsSync(path.slice(0,-'capture.json'.length)+sample.file),'missing captured PNG');
  }
  for(const direction of[1,-1])assert.equal(directions.get(direction)?.size,spec.ms.length,`${id} ${viewport} ${direction} missing frame`);
  captures.push(path);
 }
 reports.push({id,frames:names.length,ms:spec.ms,loop:spec.loop,normal_one_hp_path:state!=='hurt',conditional_note:state==='hurt'?'Test-only2HP nonlethal fixture; production1HP goes directly to death_fall.':undefined,review,captures,derivation:manifest[id].derivation});
}
assert.equal(Object.values(contract.clips).filter(s=>s.actor==='swooper').length,7);assert.equal(reports.reduce((n,r)=>n+r.frames,0),36);
writeFileSync('evidence/swooper-inventory.json',JSON.stringify({actor:'swooper',clips:7,frames:36,all_scoped_reviews_pass:true,all_frames_both_facings_native_and_phone:true,conditional_hurt_only:true,physical_device_tested:false,scripted_animation_quality_debt:true,reports},null,2)+'\n');
console.log('PASS swooper inventory:7clips/36frames, exact runtime files, scoped reviews, all frames both facings native/phone; conditional hurt explicit');
