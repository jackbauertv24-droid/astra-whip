#!/usr/bin/env node
// Ranged body delivery and scoped native/phone frame coverage; projectile is separate.
import{readFileSync,readdirSync,writeFileSync,existsSync}from'node:fs';
import assert from'node:assert/strict';
const contract=JSON.parse(readFileSync('contract/art_contract.json')),manifest=JSON.parse(readFileSync('art/frames/clips.json'));
const rows=[['idle','r01'],['aim','r03'],['fire','r02'],['recover','r01'],['hurt','r01'],['death','r05']],reports=[];
for(const[state,revision]of rows){
 const id='ranged_'+state,spec=contract.clips[id],review=`art/review-ranged-${state}-${revision}/review_verdict.md`,verdict=readFileSync(review,'utf8');
 assert(verdict.trimEnd().endsWith('REVIEW: PASS')&&verdict.includes(id),'missing scoped approval '+id);
 assert.deepEqual(manifest[id].ms,spec.ms);assert.equal(manifest[id].loop,spec.loop);
 const names=readdirSync('art/frames/'+id).filter(n=>n.endsWith('.png')).sort();assert.equal(names.length,spec.ms.length);
 for(let frame=0;frame<names.length;frame++){
  assert.equal(names[frame],`f${String(frame).padStart(3,'0')}.png`);
  assert(readFileSync(`art/frames/${id}/${names[frame]}`).equals(readFileSync(`game/assets/ranged/${id}/${names[frame]}`)),'runtime source mismatch '+id);
 }
 const captures=[];
 for(const viewport of['native','phone']){
  const path=`evidence/ranged-${state}-${viewport}/capture.json`,data=JSON.parse(readFileSync(path)),directions=new Map();assert.equal(data.physical_device,false);
  for(const record of data.records){
   if(state==='hurt'){assert.equal(record.production_start_hp,2);assert.equal(record.first_whip_hp,1);assert.equal(record.second_whip_hp,0);assert.equal(record.second_whip_state,'death');}
   if(state==='death'){assert.equal(record.production_start_hp,2);assert.equal(record.first_actual_hit_hp,1);assert.equal(record.second_actual_hit_hp,0);assert.equal(record.dead_contact_damage,false);}
   for(const sample of record.samples)if(sample.state===state&&(state!=='death'||sample.file.startsWith('death-'))){
    assert(Number.isInteger(sample.frame)&&sample.frame>=0&&sample.frame<spec.ms.length);
    if(!directions.has(record.direction))directions.set(record.direction,new Set());directions.get(record.direction).add(sample.frame);
    assert(existsSync(path.slice(0,-'capture.json'.length)+sample.file),'missing capture');
   }
  }
  for(const direction of[1,-1])assert.equal(directions.get(direction)?.size,spec.ms.length,`${id} ${viewport} ${direction} missing frame`);
  captures.push(path);
 }
 reports.push({id,frames:names.length,ms:spec.ms,loop:spec.loop,review,captures,derivation:manifest[id].derivation});
}
assert.equal(Object.values(contract.clips).filter(s=>s.actor==='ranged').length,6);assert.equal(reports.reduce((n,r)=>n+r.frames,0),31);
writeFileSync('evidence/ranged-inventory.json',JSON.stringify({actor:'ranged',scope:'All six body clips; projectile_grave_shot is a separate vfx actor and receives no approval here',clips:6,frames:31,all_scoped_reviews_pass:true,all_frames_both_facings_native_and_phone:true,actual_two_hit_production_hp_sequence:true,physical_device_tested:false,scripted_animation_quality_debt:true,reports},null,2)+'\n');
console.log('PASS ranged body inventory:6clips/31frames, exact runtime bytes, scoped reviews, bothfacings/native+phone; projectile separate');
