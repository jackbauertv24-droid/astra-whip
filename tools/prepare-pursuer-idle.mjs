#!/usr/bin/env node
// D23 fallback: painted breathing from an independently approved locomotion key.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,writeFileSync}from'node:fs';
const source='art/frames/pursuer_patrol_walk/f000.png',image=readPNG(source);
const directory='art/production-candidates/pursuer-idle-fallback-r03';
mkdirSync(directory,{recursive:true});
const smooth=(a,b,v)=>{const t=clamp((v-a)/(b-a));return t*t*(3-2*t);};
const records=[];
for(let frame=0;frame<6;frame++){
 const phase=frame/6*Math.PI*2,breath=(1-Math.cos(phase))/2,settle=Math.sin(phase);
 const output=meshWarp(image,[0,65,90,115,140,165,185,205,225,245,265,285,320],[0,95,110,125,140,155,170,185,200,210,224,240,256],(x,y)=>{
  // Below the torso the original leg chains and paws remain exactly registered.
  const chest=smooth(75,140,x)*(1-smooth(155,183,y))*smooth(90,120,y);
  const skull=smooth(210,240,x)*(1-smooth(143,160,y))*smooth(90,110,y);
  const upper=Math.max(chest*.85,skull);
  const beard=smooth(230,250,x)*(1-smooth(274,286,x))*smooth(140,157,y)*(1-smooth(177,190,y));
  const rags=smooth(100,120,x)*(1-smooth(160,180,x))*smooth(158,174,y)*(1-smooth(190,205,y));
  return[x+settle*(beard*.7+rags*.8),y-3*breath*upper+settle*(beard*.8+rags*.6)];
 });
 for(let i=0;i<output.data.length;i+=4)if(output.data[i+3]<=4)output.data.fill(0,i,i+4);
 writePNG(`${directory}/f00${frame}.png`,output);
 records.push({frame,breath,settle,max_head_lift_px:3*breath,feet:'unchanged source geometry below y210'});
}
writeFileSync(directory+'/derivation.json',JSON.stringify({source,source_acceptance:'art/review-pursuer-walk-r02/review_verdict.md',failed_painted_clip:'art/review-pursuer-idle-r01/review_verdict.md',method:'Local chest/neck breathing with three-pixel maximum head lift and subpixel cloth follow-through. Legs, paws and ground pivot remain fixed; no whole-body scale, rotation or translation.',records},null,2)+'\n');
