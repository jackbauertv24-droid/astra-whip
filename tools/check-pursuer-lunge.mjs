#!/usr/bin/env node
// Physical support registration across a moving-root lunge and stationary recovery.
import{readFileSync}from'node:fs';
import assert from'node:assert/strict';
const root=process.argv[2]||'art/production-candidates/pursuer-lunge-r02';
const l=JSON.parse(readFileSync(root+'/pursuer_lunge/rig.json')).records;
const r=JSON.parse(readFileSync(root+'/pursuer_recovery/rig.json')).records;
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const paw=(f,id)=>f.legs.find(v=>v.id===id).paw;
const planted=p=>Math.abs(p[1]-224)<.01;
const stride=260*c.clips.pursuer_lunge.ms[0]/1000*2;
const a=paw(l[0],'fore_far'),b=paw(l[1],'fore_far'),released=paw(l[2],'fore_far');
assert(planted(a)&&planted(b),'first two far-forepaw supports must contact ground');
assert(Math.abs(a[0]-b[0]-stride)<.01,'far-forepaw stance must cancel actual lunge travel');
assert(released[1]<222,'old support must unload before final lunge exposure');
const catchPaw=paw(l[2],'fore_near'),recoveryPaw=paw(r[0],'fore_near');
assert(planted(catchPaw)&&planted(recoveryPaw),'near forepaw must catch and support recovery entry');
assert(Math.abs(catchPaw[0]-recoveryPaw[0]-stride)<.01,'catch paw must cancel last lunge interval into stationary recovery');
for(const frame of r)assert(planted(paw(frame,'fore_near'))&&Math.abs(paw(frame,'fore_near')[0]-recoveryPaw[0])<.01,'recovery support must remain fixed while other legs reset');
console.log('PASS lunge support registration: far support unloads, near catch cancels final260u/s interval and remains fixed through recovery');
for(const path of process.argv.slice(3)){
 const capture=JSON.parse(readFileSync(path));
 for(const record of capture.records){
  const sample=(state,frame)=>record.samples.find(s=>s.state===state&&s.frame===frame);
  const worldX=(s,id)=>s.x+record.direction*(paw(s.state==='lunge'?l[s.frame]:r[s.frame],id)[0]-128)*.5;
  const tolerance=record.lunge_speed/120+.01;
  const early=Math.abs(worldX(sample('lunge',1),'fore_far')-worldX(sample('lunge',0),'fore_far'));
  const terminal=Math.abs(worldX(sample('recovery',0),'fore_near')-worldX(sample('lunge',2),'fore_near'));
  assert(early<tolerance&&terminal<tolerance,'captured world support drift exceeds one simulation step');
  const recoveryX=worldX(sample('recovery',0),'fore_near');
  for(const s of record.samples.filter(s=>s.state==='recovery'))assert(Math.abs(worldX(s,'fore_near')-recoveryX)<.01,'captured recovery support moved');
  console.log(`PASS ${path} facing${record.direction}: early support drift${early.toFixed(4)}u, terminal drift${terminal.toFixed(4)}u; bound${tolerance.toFixed(4)}u`);
 }
}
