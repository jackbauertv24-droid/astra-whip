#!/usr/bin/env node
// D23: local chest/arm/cloth motion on approved painting; stone post/base stay fixed.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,writeFileSync,readFileSync}from'node:fs';
const source='art/production-candidates/ranged-identity-r02/key.png';
if(!readFileSync('art/review-ranged-key-r02/review_verdict.md','utf8').trimEnd().endsWith('STATIC KEY REVIEW: PASS'))throw Error('Identity source not accepted');
const image=readPNG(source),dir='art/production-candidates/ranged-idle-r01';mkdirSync(dir,{recursive:true});
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);},records=[];
for(let frame=0;frame<6;frame++){
 const phase=frame*Math.PI/3,breath=(1-Math.cos(phase))*.5,sway=Math.sin(phase);
 const out=meshWarp(image,[0,65,85,95,105,115,120,125,130,135,140,145,150,155,160,165,175,185,200,220,256],[0,20,30,40,55,70,85,100,115,130,145,160,175,190,205,220,240,260,280,295,310,320,352],(x,y)=>{
  const free=smooth(120,130,x),chest=free*smooth(70,90,y)*(1-smooth(170,195,y))*(1-smooth(155,175,x));
  const hood=free*smooth(25,40,y)*(1-smooth(80,105,y));
  const arm=smooth(140,150,x)*(1-smooth(170,185,x))*smooth(110,135,y)*(1-smooth(220,240,y));
  const rags=free*smooth(190,220,y)*(1-smooth(275,295,y));
  return[x+3*breath*chest+2.5*sway*arm+2*sway*rags,y-2*breath*chest-breath*hood+1.5*sway*arm];
 });
 let removed=0;for(let k=0;k<out.data.length;k+=4)if(out.data[k+3]<=4){if(out.data[k+3])removed++;out.data.fill(0,k,k+4);}
 writePNG(`${dir}/f00${frame}.png`,out);records.push({frame,breath,sway,removed_alpha_at_most:4,removed_low_alpha_pixels:removed,max_chest_expansion_px:3*breath,post_and_base:'x<=120 and y>=295 remain exactly registered',hood_lift_px:breath});
}
writeFileSync(dir+'/derivation.json',JSON.stringify({source,static_review:'art/review-ranged-key-r02/review_verdict.md',kind:'scripted_fallback',method:'Local3px chest expansion/2px lift,1px hood lift, elbow/wrist sway and2px cloth response; post and grounded base fixed. No global scaling, translation or per-frame normalization.',reason:'D23 local rig preserves accepted painted anatomy for subtle idle. The first generated ranged key failed construction readiness (bound aiming arm/post height); the corrected source retains that repaired construction. Prior generated action corrections elsewhere also changed anatomy/pose; no rejected ranged motion cycle is claimed. Entire resulting idle requires independent action review and remains quality debt.',records},null,2)+'\n');
