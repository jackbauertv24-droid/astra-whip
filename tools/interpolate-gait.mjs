#!/usr/bin/env node
// ART_CONTRACT §11: explicit fallback interpolation of independently approved keys.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {meshWarp,clamp,registerFoot} from './lib/deform.mjs';
import {readFileSync,writeFileSync,mkdirSync,cpSync,existsSync} from 'node:fs';
const paths=[
 'art/production-candidates/hero_walk-key-edge-clean.png',
 'art/production-candidates/hero_passing-key-v2-edge-clean.png',
 'art/review-hero-keys-r06/key_3.png',
 'art/production-candidates/hero_passing-b-key-edge-clean.png',
];
const poses=paths.map(readPNG);
function translate(src,dx){const out=blank(512,512);for(let y=0;y<512;y++)for(let x=0;x<512;x++)if(x+dx>=0&&x+dx<512)out.data.set(src.data.subarray((y*512+x)*4,(y*512+x)*4+4),(y*512+x+dx)*4);return out;}
poses[2]=translate(poses[2],17);poses[3]=translate(poses[3],8);
const neutral=readPNG('art/frames/style_hero_neutral/f000.png');
const gridX=[0,170,190,210,230,250,256,270,290,310,330,350,512];
const gridY=[0,350,365,375,385,395,405,415,427,438,448,470,512];
function blend(a,b,t){const out=blank(512,512);for(let i=0;i<out.data.length;i+=4){const aa=a.data[i+3]/255*(1-t),bb=b.data[i+3]/255*t,alpha=aa+bb;for(let k=0;k<3;k++)out.data[i+k]=alpha?Math.round((a.data[i+k]*aa+b.data[i+k]*bb)/alpha):0;out.data[i+3]=Math.round(alpha*255);}return out;}
function over(dst,src){for(let i=0;i<dst.data.length;i+=4){const a=src.data[i+3]/255,b=dst.data[i+3]/255,aa=a+b*(1-a);if(!a)continue;for(let k=0;k<3;k++)dst.data[i+k]=Math.round((src.data[i+k]*a+dst.data[i+k]*b*(1-a))/aa);dst.data[i+3]=Math.round(aa*255);}}
function part(src,side,poseIndex){const out=blank(512,512),right=poseIndex===2?side===0:side===1;for(let y=365;y<512;y++)for(let x=0;x<512;x++)if((x>=256)===right){const j=(y*512+x)*4;out.data.set(src.data.subarray(j,j+4),j);out.data[j+3]=Math.round(out.data[j+3]*clamp((y-365)/12));}return out;}
function anchors(src,side,poseIndex){const right=poseIndex===2?side===0:side===1;let bottom=0;for(let y=380;y<480;y++)for(let x=170;x<350;x++)if((x>=256)===right&&src.data[(y*512+x)*4+3]>=40)bottom=y;const row=(y)=>{const xs=[];for(let x=170;x<350;x++)if((x>=256)===right&&src.data[(Math.round(y)*512+x)*4+3]>=40)xs.push(x);return xs.length?xs.reduce((a,b)=>a+b,0)/xs.length:(right?290:225);};return [[side?270:240,350],[row(bottom-43),bottom-43],[row(bottom-19),bottom-19],[row(bottom-2),bottom]];}
function interpolate(aIndex,bIndex,t){
 if(t===0)return poses[aIndex];if(t===1)return poses[bIndex];
 const a=poses[aIndex],b=poses[bIndex],out=blank(512,512);
 // Far leg first, near leg last. Both parents are warped onto shared joint paths.
 for(const side of [1,0]){
  const aa=anchors(a,side,aIndex),bb=anchors(b,side,bIndex),target=aa.map((p,i)=>p.map((v,k)=>v*(1-t)+bb[i][k]*t));
  const warp=(src,from,index)=>meshWarp(part(src,side,index),gridX,gridY,(x,y)=>{
   let segment=0;while(segment<2&&y>from[segment+1][1])segment++;
   const w=clamp((y-from[segment][1])/(from[segment+1][1]-from[segment][1]));
   const dx=(target[segment][0]-from[segment][0])*(1-w)+(target[segment+1][0]-from[segment+1][0])*w;
   const yy=target[segment][1]*(1-w)+target[segment+1][1]*w;
   return [x+dx,y<350?y:yy+(y>from[3][1]?y-from[3][1]:0)];
  });over(out,t<=.5?warp(a,aa,aIndex):warp(b,bb,bIndex));
 }
 const sourceBody=t<=.5?a:b,body={...sourceBody,data:new Uint8Array(sourceBody.data)};for(let y=365;y<512;y++)for(let x=0;x<512;x++){const j=(y*512+x)*4;body.data[j+3]=Math.round(body.data[j+3]*(1-clamp((y-365)/17)));}over(out,body);return registerFoot(out);
}
function referenceHead(src){
 const out={...src,data:new Uint8Array(src.data)};let top=512;
 for(let y=0;y<512;y++)for(let x=0;x<512;x++)if(src.data[(y*512+x)*4+3]>=40)top=Math.min(top,y);
 for(let y=top;y<top+45;y++)for(let x=220;x<299;x++){const j=(y*512+x)*4,w=1-clamp((y-top-37)/8);out.data[j+3]=Math.round(out.data[j+3]*(1-w));}
 const head=blank(512,512);for(let y=225;y<280;y++)for(let x=232;x<286;x++){const yy=top+y-225,j=(yy*512+x)*4,k=(y*512+x)*4;head.data.set(neutral.data.subarray(k,k+4),j);head.data[j+3]=Math.round(head.data[j+3]*(1-clamp((y-270)/10)));}over(out,head);return out;
}
const sequence=[[0,1,0],[0,1,.5],[0,1,1],[1,2,.5],[1,2,.8],[1,2,1],[2,3,.5],[2,3,1],[3,0,.5],[3,0,1]];
const root='art/frames/hero_walk';if(existsSync(root)){const archive='art/rejected/gait-'+Date.now();mkdirSync(archive,{recursive:true});cpSync(root,archive+'/hero_walk',{recursive:true});}
mkdirSync(root,{recursive:true});sequence.forEach(([a,b,t],i)=>writePNG(`${root}/f${String(i).padStart(3,'0')}.png`,referenceHead(interpolate(a,b,t))));
const c=JSON.parse(readFileSync('contract/art_contract.json')),meta=JSON.parse(readFileSync('art/frames/clips.json')),d=JSON.parse(readFileSync('art/frames/derivations.json'));
d.hero_walk={kind:'scripted_fallback',source:[...paths,'art/frames/style_hero_neutral/f000.png'],method:'Four approved painted contact/passing keys; near/far leg masks interpolated along measured hip/knee/ankle/foot paths, nearest-parent paint retained without texture cross-fades, near leg composited last. Neutral head reused rigidly with a feathered neck join. Authored horizontal origin preserved.',reason:'Generated sheets failed scale; first rig and held-pose gait failed visual continuity. This full alternating candidate requires independent motion acceptance.'};
meta.hero_walk={ms:c.clips.hero_walk.ms,loop:true,derivation:d.hero_walk};writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2));writeFileSync('art/frames/derivations.json',JSON.stringify(d,null,2));
