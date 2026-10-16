#!/usr/bin/env node
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,copyFileSync,readFileSync,writeFileSync}from'node:fs';
if(!readFileSync('art/review-ranged-fire-r02/review_verdict.md','utf8').trimEnd().endsWith('REVIEW: PASS'))throw Error('Unapproved firing source');
const source='art/production-candidates/ranged-fire-r02/clean-body-source.png',body=readPNG(source),elbow=[143,130],theta=Math.atan2(25,65),cs=Math.cos(theta),sn=Math.sin(theta);
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);};
function over(dst,img){for(let k=0;k<dst.data.length;k+=4){const a=img.data[k+3]/255,b=dst.data[k+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[k+c]=Math.round((img.data[k+c]*a+dst.data[k+c]*b*(1-a))/t);dst.data[k+3]=Math.round(t*255);}}
const foreground=blank(256,352);
for(let y=0;y<352;y++)for(let x=0;x<256;x++){
 const k=(y*256+x)*4,dx=x-elbow[0],dy=y-elbow[1],along=dx*cs+dy*sn,across=-dx*sn+dy*cs,w=smooth(0,10,along)*(1-smooth(9,15,Math.abs(across)));
 foreground.data.set(body.data.subarray(k,k+4),k);foreground.data[k+3]=Math.round(body.data[k+3]*w);
}
const xs=[...new Set([0,60,85,100,110,...Array.from({length:31},(_,i)=>116+i*4),143,208,256])].sort((a,b)=>a-b);
const ys=[...new Set([0,20,40,60,80,90,...Array.from({length:36},(_,i)=>100+i*4),130,155,260,280,295,320,352])].sort((a,b)=>a-b);
const dir='art/production-candidates/ranged-recover-r01';mkdirSync(dir,{recursive:true});
copyFileSync('art/frames/ranged_fire/f002.png',dir+'/f000.png');
copyFileSync('art/frames/ranged_idle/f000.png',dir+'/f006.png');
const records=[{frame:0,reuse:'art/frames/ranged_fire/f002.png'}];
for(let frame=1;frame<6;frame++){
 const degrees=[0,0,12,25,40,55][frame],angle=degrees*Math.PI/180;
 const rigid=(x,y)=>{const dx=x-elbow[0],dy=y-elbow[1];return[elbow[0]+dx*Math.cos(angle)-dy*Math.sin(angle),elbow[1]+dx*Math.sin(angle)+dy*Math.cos(angle)];};
 const output=meshWarp(body,xs,ys,(x,y)=>{const dx=x-elbow[0],dy=y-elbow[1],along=dx*cs+dy*sn,across=-dx*sn+dy*cs,w=smooth(0,16,along)*(1-smooth(10,24,Math.abs(across))),p=rigid(x,y);return[x+(p[0]-x)*w,y+(p[1]-y)*w];});
 over(output,meshWarp(foreground,[0,256],[0,352],rigid));
 let removed=0;for(let k=0;k<output.data.length;k+=4)if(output.data[k+3]<=4){if(output.data[k+3])removed++;output.data.fill(0,k,k+4);}
 writePNG(`${dir}/f00${frame}.png`,output);records.push({frame,forearm_down_angle_degrees:degrees,removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
records.push({frame:6,reuse:'art/frames/ranged_idle/f000.png'});
const derivation={kind:'scripted_fallback',source:['art/frames/ranged_fire/f002.png','art/frames/ranged_idle/f000.png',source,'tools/prepare-ranged-recover.mjs'],method:'Reuse exact recoil and idle endpoints; reverse the approved elbow-lift articulation over five effect-free clean-hand poses using foreground arm occlusion. Fixed hood/post/base; no actor scaling or recentering.',reason:'D23 reuse/reversal of accepted action construction, with local scripted in-betweens from corrected generated hand. Earlier generated arm construction/recoil changed anatomy or firing lane; preserved failures motivate the local rig. Requires fresh recovery/runtime review and remains scripted quality debt.',records};
writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');
for(const path of ['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(path)),record={kind:derivation.kind,source:derivation.source,method:derivation.method,reason:derivation.reason};if(path.endsWith('clips.json'))d.ranged_recover={ms:Array(7).fill(100),loop:false,derivation:record};else d.ranged_recover=record;writeFileSync(path,JSON.stringify(d,null,2)+'\n');}
