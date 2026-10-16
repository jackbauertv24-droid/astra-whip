#!/usr/bin/env node
import assert from'node:assert/strict';
import{readFileSync,readdirSync,existsSync,writeFileSync}from'node:fs';
const id='boss_walk',spec=JSON.parse(readFileSync('contract/art_contract.json')).clips[id],manifest=JSON.parse(readFileSync('art/frames/clips.json'))[id];
const review='art/review-boss-walk-r01/review_verdict.md';assert(readFileSync(review,'utf8').trimEnd().endsWith('REVIEW: PASS'),'fresh scoped review required');
assert.deepEqual(manifest.ms,spec.ms);assert.equal(manifest.loop,spec.loop);assert.equal(readdirSync('art/frames/'+id).filter(n=>n.endsWith('.png')).length,8);
for(let f=0;f<8;f++){const n=`f${String(f).padStart(3,'0')}.png`;assert(readFileSync(`art/frames/${id}/${n}`).equals(readFileSync(`game/assets/boss/${id}/${n}`)),'runtime bytes');}
const captures=[];
for(const viewport of['native','phone']){const path=`evidence/boss-walk-${viewport}/capture.json`,d=JSON.parse(readFileSync(path));assert.equal(d.physical_device,false);assert.equal(d.records.length,2);for(const dir of[1,-1]){const r=d.records.find(r=>r.direction===dir);assert(r);assert.equal(r.production_hp,8);assert.equal(r.speed,70);assert.equal(r.cycle_ms,640);assert.equal(new Set(r.samples.filter(s=>s.state==='walk').map(s=>s.frame)).size,8);assert(r.samples.some(s=>s.wrap));for(const s of r.samples)assert(existsSync(`evidence/boss-walk-${viewport}/${s.file}`));}captures.push(path);}
writeFileSync('evidence/boss-walk-inventory.json',JSON.stringify({actor:'boss',clip:id,frames:8,review,captures,all_frames_both_facings_native_and_phone:true,physical_device_tested:false,scripted_animation_quality_debt:true,remaining_boss_clips_unapproved:10},null,2)+'\n');console.log('PASS boss_walk: eight exact runtime frames,scoped approval,bothfacings/native+phone,actual70u/s640ms loop; otherbossclips remain pending');
