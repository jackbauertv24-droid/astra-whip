#!/usr/bin/env node
// Actor-wide delivery, fresh acceptance and actual frame/face coverage inventory.
import{readFileSync,readdirSync,writeFileSync,existsSync}from'node:fs';
import assert from'node:assert/strict';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const m=JSON.parse(readFileSync('art/frames/clips.json'));
const rows=[
 ['idle','idle-r02','idle-r02','spawn ->900ms ->patrol'],
 ['patrol_walk','walk-r02','walk-r02','patrol60u/s ->visible same-level hunter within400u ->alert'],
 ['alert','alert-r01','alert-r01','300ms rear-up ->approach'],
 ['approach_walk','walk-r02','walk-r02','approach100u/s ->within120u ->windup; beyond400u ->patrol'],
 ['lunge_windup','lunge-r02','lunge-r02','350ms supported windup ->lunge'],
 ['lunge','lunge-r02','lunge-r02','260u/s for240ms ->recovery'],
 ['recovery','lunge-r02','lunge-r02','600ms stationary recovery ->approach'],
 ['hurt','hurt-r02','hurt-r02','conditional nonlethal take_hit ->180ms ->approach'],
 ['death','death-r01','death-r01','normal lethal take_hit ->480ms clip ->hold ->cleanup after1.2s']
];
const reports=[];
for(const[state,review,capture,transitions]of rows){
 const id='pursuer_'+state,spec=c.clips[id],verdict='art/review-pursuer-'+review+'/review_verdict.md';
 const result=readFileSync(verdict,'utf8');assert(result.trimEnd().endsWith('REVIEW: PASS')&&result.includes(id),'missing scoped acceptance '+id);
 assert.deepEqual(m[id].ms,spec.ms);assert.equal(m[id].loop,spec.loop);
 const names=readdirSync('art/frames/'+id).filter(n=>n.endsWith('.png')).sort();assert.equal(names.length,spec.ms.length);
 for(let i=0;i<names.length;i++){assert.equal(names[i],`f${String(i).padStart(3,'0')}.png`);assert(readFileSync('art/frames/'+id+'/'+names[i]).equals(readFileSync('game/assets/pursuer/'+id+'/'+names[i])));}
 const captures=[];
 for(const viewport of['engine','phone']){
  const [family,revision]=capture.split('-'),path=`evidence/pursuer-${family}-${viewport}-${revision}/capture.json`,data=JSON.parse(readFileSync(path));
  const directions=new Map();
  for(const record of Array.isArray(data)?data:data.records){
   const direction=record.direction??record.facing;
   for(const sample of record.samples)if((sample.state??record.state)===state){
    if(!directions.has(direction))directions.set(direction,new Set());directions.get(direction).add(sample.frame);
    const file=sample.file||`${state}-${direction>0?'right':'left'}-f${String(sample.frame).padStart(3,'0')}.png`;
    assert(existsSync(path.slice(0,-'capture.json'.length)+file),'missing captured PNG '+file);
   }
  }
  for(const direction of[1,-1])assert.equal(directions.get(direction)?.size,spec.ms.length,`${id} ${viewport} facing${direction} missing frame coverage`);
  captures.push(path);
 }
 reports.push({id,frames:names.length,ms:spec.ms,loop:spec.loop,normal_one_hp_path:state!=='hurt',conditional_note:state==='hurt'?'Nonlethal branch exercised with test-only2HP; normal production1HP routes to death.':undefined,transitions,review:verdict,captures,derivation:m[id].derivation});
}
assert.equal(Object.values(c.clips).filter(s=>s.actor==='pursuer').length,9);assert.equal(reports.reduce((n,r)=>n+r.frames,0),46);
writeFileSync('evidence/pursuer-inventory.json',JSON.stringify({actor:'pursuer',clips:9,frames:46,all_scoped_reviews_pass:true,all_frames_both_facings_native_and_phone:true,conditional_hurt_only:true,physical_device_tested:false,scripted_animation_quality_debt:true,reports},null,2)+'\n');
console.log('PASS pursuer inventory:9clips/46frames, exact runtime files, scoped fresh approvals, all frames bothfacings in native and phone captures; conditional hurt is explicit');
