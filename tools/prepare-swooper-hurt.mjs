#!/usr/bin/env node
// D23 initial hood recoil, painted stagger, then approved bank/catch handoff.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,copyFileSync,writeFileSync,readFileSync}from'node:fs';
const source='art/frames/swooper_cruise/f002.png',image=readPNG(source),dir='art/production-candidates/swooper-hurt-r01';
if(!readFileSync('art/review-swooper-cruise-r01/review_verdict.md','utf8').includes('REVIEW: PASS'))throw Error('Cruise source not accepted');
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);};
const out=meshWarp(image,[0,150,170,185,195,205,215,225,235,245,270,384],[0,44,65,72,80,90,100,110,120,128,145,160,185,200,212,256],(x,y)=>{
 const hood=smooth(185,195,x)*(1-smooth(235,245,x))*smooth(72,80,y)*(1-smooth(110,128,y));
 const rags=smooth(140,155,x)*(1-smooth(190,205,x))*smooth(145,165,y)*(1-smooth(200,212,y));
 return[x-10*hood,y-2*hood+3*rags];
});
for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);
mkdirSync(dir,{recursive:true});writePNG(dir+'/f000.png',out);
copyFileSync('art/production-candidates/swooper-hurt-stagger-r01/key.png',dir+'/f001.png');
copyFileSync('art/frames/swooper_recovery_climb/f000.png',dir+'/f002.png');
writeFileSync(dir+'/derivation.json',JSON.stringify({source,method:'Frame0:10px rigid-region hood recoil with blended neck and3px cloth response over approved articulated wings. Frame1:new painted stagger. Frame2:approved banked recovery start reused exactly. Torso anchor unchanged, no global scale/translation.',painted_frame:'art/production-candidates/swooper-hurt-stagger-r01/key.png',reused_frame:'art/frames/swooper_recovery_climb/f000.png'},null,2)+'\n');
