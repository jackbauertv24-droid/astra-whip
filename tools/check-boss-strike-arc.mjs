#!/usr/bin/env node
// Geometry tripwire for the retained discontinuous arm/body draft.
// It cannot approve motion; a fresh independent visual review is mandatory.
import{readFileSync,writeFileSync}from'node:fs';
const before=process.argv.includes('--before'),root='art/production-candidates/boss-strike-'+(before?'r07':'r08');
const read=id=>JSON.parse(readFileSync(`${root}/boss_strike_${id}/derivation.json`));
const held=read('windup').records[6].target_joints[3],records=read('execute').records;
const first=records[0].target_joints,firstFist=first.stroke?first.stroke.joints[3]:first[3];
const fistStep=Math.hypot(firstFist[0]-held[0],firstFist[1]-held[1]);
const angles=[0,...records.map(r=>r.target_joints.stroke?.angle??r.target_joints.supported?.[0]??0)];
const jumps=angles.slice(1).map((n,i)=>Math.abs(n-angles[i]));
const pass=fistStep<=175&&Math.max(...jumps)<=6;
const result={source:root,held_to_first_fist_step_px:fistStep,max_first_step_px:175,torso_angles:angles,max_torso_step_degrees:Math.max(...jumps),allowed_torso_step_degrees:6,pass,visual_approval:false};
if(!before)writeFileSync('evidence/boss-strike-arc.json',JSON.stringify(result,null,2)+'\n');
console.log(JSON.stringify(result,null,2));process.exit(pass?0:1);
