#!/usr/bin/env node
// D23 articulated tuck from the independently accepted folded-wing paint.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,readFileSync,writeFileSync}from'node:fs';
const source='art/production-candidates/swooper-fold-r01/key.png';
if(!readFileSync('art/review-swooper-fold-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW: PASS'))throw Error('Fold key not accepted');
const image=readPNG(source),dir='art/production-candidates/swooper-dive-r01';mkdirSync(dir,{recursive:true});
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);},records=[];
for(let frame=0;frame<4;frame++){
 const pitch=[20,40,80,80][frame],wing_angle=[2,6,10,7][frame],cloth=[0,-3,3,-2][frame],a=pitch*Math.PI/180;
 const output=meshWarp(image,[0,135,143,150,160,170,180,190,196,200,205,210,220,235,245,260,384],[0,40,45,50,60,75,90,105,120,125,140,150,170,190,200,210,256],(x,y)=>{
  const wing=smooth(143,160,x)*(1-smooth(196,210,x))*smooth(40,45,y)*(1-smooth(125,143,y));
  const w=wing_angle*Math.PI/180*wing,dx=x-190,dy=y-120;
  const rags=smooth(138,150,x)*(1-smooth(188,205,x))*smooth(140,160,y)*(1-smooth(195,210,y));
  const xx=190+dx*Math.cos(w)-dy*Math.sin(w),yy=120+dx*Math.sin(w)+dy*Math.cos(w)+rags*cloth;
  return[192+(xx-192)*Math.cos(a)-(yy-128)*Math.sin(a),128+(xx-192)*Math.sin(a)+(yy-128)*Math.cos(a)];
 });
 for(let j=0;j<output.data.length;j+=4)if(output.data[j+3]<=4)output.data.fill(0,j,j+4);
 writePNG(`${dir}/f00${frame}.png`,output);records.push({frame,body_pitch_degrees:pitch,folded_wing_articulation_degrees:wing_angle,cloth_deflection:cloth,pivot:[192,128]});
}
writeFileSync(dir+'/derivation.json',JSON.stringify({source,static_review:'art/review-swooper-fold-key-r01/review_verdict.md',method:'Progressive dive pitch about body center, independent folded-wing strut flexion about shoulder, and wind-driven cloth deflection. No global scaling, no per-frame recentering; one mesh sample per output pixel.',records},null,2)+'\n');
