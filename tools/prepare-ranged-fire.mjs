#!/usr/bin/env node
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,copyFileSync,readFileSync,writeFileSync}from'node:fs';
const reference='art/review-ranged-aim-r03/review_verdict.md';
if(!readFileSync(reference,'utf8').trimEnd().endsWith('REVIEW: PASS'))throw Error('Unapproved aim');
const source='art/production-candidates/ranged-fire-r02/clean-body-source.png',body=readPNG(source),effect=readPNG('art/production-candidates/ranged-aim-r03/charge-source.png');
const elbow=[143,130],anchor=[208,155],theta=Math.atan2(25,65),cs=Math.cos(theta),sn=Math.sin(theta);
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);};
function over(dst,img,opacity=1){for(let k=0;k<dst.data.length;k+=4){const a=img.data[k+3]/255*opacity,b=dst.data[k+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[k+c]=Math.round((img.data[k+c]*a+dst.data[k+c]*b*(1-a))/t);dst.data[k+3]=Math.round(t*255);}}
const foreground=blank(256,352);
for(let y=0;y<352;y++)for(let x=0;x<256;x++){
 const k=(y*256+x)*4,dx=x-elbow[0],dy=y-elbow[1],along=dx*cs+dy*sn,across=-dx*sn+dy*cs;
 const weight=smooth(0,10,along)*(1-smooth(9,15,Math.abs(across)));
 foreground.data.set(body.data.subarray(k,k+4),k);foreground.data[k+3]=Math.round(body.data[k+3]*weight);
}
const xs=[...new Set([0,60,85,100,110,...Array.from({length:31},(_,i)=>116+i*4),143,208,256])].sort((a,b)=>a-b);
const ys=[...new Set([0,20,40,60,80,90,...Array.from({length:36},(_,i)=>100+i*4),130,155,260,280,295,320,352])].sort((a,b)=>a-b);
const dir='art/production-candidates/ranged-fire-r02';mkdirSync(dir,{recursive:true});
copyFileSync('art/frames/ranged_aim/f005.png',dir+'/f000.png');
const records=[{frame:0,ms:50,reuse:'art/frames/ranged_aim/f005.png',charge_scale:1,charge_opacity:1}];
for(let frame=1;frame<3;frame++){
 const angle=frame===2?-6*Math.PI/180:0,tx=frame===2?-6:0,ty=frame===2?-1:0;
 const rigid=(x,y)=>{const dx=x-elbow[0],dy=y-elbow[1];return[elbow[0]+dx*Math.cos(angle)-dy*Math.sin(angle)+tx,elbow[1]+dx*Math.sin(angle)+dy*Math.cos(angle)+ty];};
 const output=meshWarp(body,xs,ys,(x,y)=>{const dx=x-elbow[0],dy=y-elbow[1],along=dx*cs+dy*sn,across=-dx*sn+dy*cs,w=smooth(0,16,along)*(1-smooth(10,24,Math.abs(across))),p=rigid(x,y);return[x+(p[0]-x)*w,y+(p[1]-y)*w];});
 over(output,meshWarp(foreground,[0,256],[0,352],rigid));
 if(frame===1)over(output,meshWarp(effect,[0,256],[0,352],(x,y)=>[anchor[0]+(x-anchor[0])*.65,anchor[1]+(y-anchor[1])*.65]),.6);
 let removed=0;for(let k=0;k<output.data.length;k+=4)if(output.data[k+3]<=4){if(output.data[k+3])removed++;output.data.fill(0,k,k+4);}
 writePNG(`${dir}/f00${frame}.png`,output);records.push({frame,ms:frame===1?50:100,forearm_angle_degrees:angle*180/Math.PI,translation:[tx,ty],charge_scale:frame===1?.65:0,charge_opacity:frame===1?.6:0,removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
const derivation={kind:'scripted_fallback',source:['art/frames/ranged_aim/f005.png',source,'art/production-candidates/ranged-fire-clean-hand-r01/key.png','tools/prepare-ranged-fire-clean-body.mjs','art/production-candidates/ranged-aim-r03/charge-source.png','tools/prepare-ranged-fire.mjs'],method:'Exact aim endpoint reuse, painted diamond contraction/fade on50ms release, local six-degree forearm recoil and six-pixel retraction after release with foreground occlusion; local generated hand correction removes embedded charge; fixed approved identity, no global scale/recenter.',reason:'Generated recoil key lifted the hand out of the muzzle neighborhood and introduced a red wrist remnant; retained rejected source/prompt. D23 fallback requires fresh motion/runtime review and remains quality debt.',records};
writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');
for(const path of ['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(path)),record={kind:derivation.kind,source:derivation.source,method:derivation.method,reason:derivation.reason};if(path.endsWith('clips.json'))d.ranged_fire={ms:[50,50,100],loop:false,derivation:record};else d.ranged_fire=record;writeFileSync(path,JSON.stringify(d,null,2)+'\n');}
