#!/usr/bin/env node
// Small secondary motions of independently approved key poses, ART_CONTRACT §11.
import {readPNG,writePNG} from './lib/png.mjs';
import {meshWarp,heroGrid,registerFoot,clamp} from './lib/deform.mjs';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
const contract=JSON.parse(readFileSync('contract/art_contract.json'));
const meta=JSON.parse(readFileSync('art/frames/clips.json'));
const derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
const keys={neutral:'art/frames/style_hero_neutral/f000.png',crouch:'art/production-candidates/hero_crouch-key-v2.png',air:'art/production-candidates/hero_air-key-v2.png'};
function emit(id,key,poses,method){
 const src=readPNG(keys[key]);mkdirSync('art/frames/'+id,{recursive:true});
 poses.forEach((pose,i)=>{
  const im=registerFoot(meshWarp(src,heroGrid.xs,heroGrid.ys,pose));
  for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);
  writePNG(`art/frames/${id}/f${String(i).padStart(3,'0')}.png`,im);
 });
 const derivation={kind:'scripted_fallback',source:keys[key],method,reason:'Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.'};
 meta[id]={ms:contract.clips[id].ms,loop:contract.clips[id].loop,derivation};derivations[id]=derivation;
}
emit('hero_crouch_idle','crouch',[0,.5,1,1,.5,0].map(a=>(x,y)=>[x,y-a*clamp((405-y)/55)]),'Rigid head and shoulder breathing above folded hips, planted boots, one-pixel inhale and settle.');
const airPose=(bend,cloth)=>(x,y)=>{
 const lower=clamp((y-350)/70),left=clamp((280-x)/50);
 const cape=clamp((y-320)/40)*(1-clamp((y-390)/20))*left;
 return [x+cloth*cape+Math.sin(lower*Math.PI)*bend,y-bend*lower*left];
};
emit('hero_jump_rise','air',[airPose(0,0),airPose(1,1),airPose(2,2),airPose(3,3)],'Restrained knee tuck and trailing coat progression from the approved airborne pose.');
emit('hero_jump_apex','air',[airPose(3,3),airPose(2,2),airPose(1,1)],'Tuck releases as upward motion stops; coat settles.');
emit('hero_fall','air',[airPose(0,0),airPose(-1,-2),airPose(-2,-3),airPose(-1,-2)],'Leg extension and cloth flutter during descent with a continuous loop seam.');
const recoil=a=>(x,y)=>[x-a*clamp((430-y)/150),y+Math.abs(a)*.12*clamp((430-y)/150)];
emit('hero_hurt_recoil','neutral',[recoil(0),recoil(8),recoil(5),recoil(1)],'Torso and head recoil together about planted feet, then recover; no global resize.');
emit('hero_knockback','neutral',[recoil(4),recoil(10),recoil(8),recoil(5)],'Sustained backward torso lean during state-driven horizontal knockback.');
emit('hero_turn','neutral',[recoil(-3),recoil(0),recoil(3)],'Three weight-transfer poses at the facing transition, with direction controlled by gameplay.');
writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2)+'\n');writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2)+'\n');
