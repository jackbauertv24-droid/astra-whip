#!/usr/bin/env node
// Full ranged body plus separately owned projectile delivery/acceptance/coverage.
import './check-ranged-inventory.mjs';
import{readFileSync,readdirSync,writeFileSync,existsSync}from'node:fs';
import assert from'node:assert/strict';
const id='projectile_grave_shot',contract=JSON.parse(readFileSync('contract/art_contract.json')),manifest=JSON.parse(readFileSync('art/frames/clips.json')),spec=contract.clips[id];
const review='art/review-projectile-grave-shot-r01/review_verdict.md',verdict=readFileSync(review,'utf8');assert(verdict.trimEnd().endsWith('REVIEW: PASS')&&verdict.includes(id),'missing projectile approval');
assert.deepEqual(manifest[id].ms,spec.ms);assert.equal(manifest[id].loop,spec.loop);
const files=readdirSync('art/frames/'+id).filter(f=>f.endsWith('.png')).sort();assert.equal(files.length,3);
for(let f=0;f<3;f++){const name=`f00${f}.png`;assert.equal(files[f],name);assert(readFileSync(`art/frames/${id}/${name}`).equals(readFileSync(`game/assets/vfx/${id}/${name}`)),'runtime mismatch');}
const captures=[];
for(const viewport of['native','phone']){
 const path=`evidence/projectile-grave-shot-${viewport}/capture.json`,data=JSON.parse(readFileSync(path));assert.equal(data.physical_device,false);
 for(const direction of[1,-1]){
  const record=data.records.find(r=>r.direction===direction);assert(record,'missing facing');const seen=new Set();
  for(const s of record.samples){assert(existsSync(path.slice(0,-'capture.json'.length)+s.file));seen.add(s.frame);assert(Math.abs(s.position[1]-record.birth[1])<.001);assert(Math.abs(s.position[0]-record.birth[0]-direction*280*s.age)<.1);}
  assert.deepEqual([...seen].sort(),[0,1,2]);assert.equal(record.samples[0].age,0);assert.equal(record.samples[0].frame,0);assert.equal(record.samples[3].frame,0);assert(record.samples.at(-1).distance>636);assert.equal(record.expired_at640u,true);
  const low=record.collision_fixtures.find(c=>c.crouched),standing=record.collision_fixtures.find(c=>!c.crouched);assert.equal(low.health,standing.health+1);assert.equal(low.remaining_shots,1);assert.equal(standing.remaining_shots,0);assert.equal(standing.state,'hurt_recoil');assert.equal(standing.non_displacing,true);
 }
 captures.push(path);
}
const body=JSON.parse(readFileSync('evidence/ranged-inventory.json'));assert.equal(body.frames,31);assert.equal(body.clips,6);
writeFileSync('evidence/ranged-complete-inventory.json',JSON.stringify({actor:'ranged',body_clips:6,body_frames:31,projectile_clips:1,projectile_frames:3,total_frames:34,all_scoped_reviews_pass:true,all_frames_both_facings_native_and_phone:true,physical_device_tested:false,scripted_body_quality_debt:true,directly_generated_projectile:true,body_report:'evidence/ranged-inventory.json',projectile:{id,ms:spec.ms,loop:spec.loop,canvas:spec.canvas,anchor:spec.anchor,review,captures,generation:manifest[id].generation}},null,2)+'\n');
console.log('PASS complete ranged inventory:6body clips/31frames +3projectile frames, exact runtime, scoped approval and bothfacings/native+phone; collision/flight/wrap verified');
