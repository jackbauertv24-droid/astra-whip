#!/usr/bin/env node
// D23 death dissolution from independently accepted grounded corpse paint.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{mkdirSync,writeFileSync,readFileSync}from'node:fs';
const source='art/production-candidates/pursuer-death-corpse-clean-r01.png';
if(!readFileSync('art/review-pursuer-corpse-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW: PASS'))throw Error('Static corpse source not approved');
const image=readPNG(source),ink=[];
for(let y=0;y<256;y++)for(let x=0;x<320;x++)if(image.data[(y*320+x)*4+3]>160)ink.push([x,y]);
let seed=173519;
const random=()=>{seed=(Math.imul(seed,1664525)+1013904223)>>>0;return seed/4294967296;};
const holes=Array.from({length:18},()=>{const p=ink[Math.floor(random()*ink.length)];return{x:p[0],y:p[1],r:2+random()*3};});
const particles=holes.filter((_,i)=>i%2===0).map(p=>({...p,dx:(random()-.5)*12}));
const directory='art/production-candidates/pursuer-death-ash-r01';mkdirSync(directory,{recursive:true});
const records=[];
for(let stage=0;stage<2;stage++){
 const output=blank(320,256),opacity=stage===0?.62:.08;
 for(let y=0;y<256;y++)for(let x=0;x<320;x++){
  const k=(y*320+x)*4;if(!image.data[k+3])continue;
  let mask=1;
  for(const h of holes){const d=Math.hypot((x-h.x)*1.1,y-h.y),r=h.r*(stage===0?1:2.3);mask*=Math.max(0,Math.min(1,(d-r*.4)/(r*.6)));}
  const mix=stage===0?.65:.95;
  for(let c=0;c<3;c++)output.data[k+c]=Math.round(image.data[k+c]*(1-mix)+[110,106,97][c]*mix);
  output.data[k+3]=Math.round(image.data[k+3]*opacity*mask);
 }
 const flecks=particles.map((p,i)=>({x:p.x+p.dx*(stage===0?.3:1),y:Math.min(223,p.y+(stage===0?4:42)),rx:stage===0?2.2:1.5,ry:stage===0?1.8:1.2,alpha:stage===0?210:170,tone:1+(i%3)*.12}));
 flecks.push({x:128,y:223,rx:2,ry:1.5,alpha:stage===0?190:160,tone:1});
 for(const p of flecks)for(let y=Math.floor(p.y-p.ry*2);y<=Math.ceil(p.y+p.ry*2);y++)for(let x=Math.floor(p.x-p.rx*2);x<=Math.ceil(p.x+p.rx*2);x++){
  if(x<0||x>=320||y<0||y>224)continue;
  const d=Math.hypot((x-p.x)/p.rx,(y-p.y)/p.ry);if(d>=1.6)continue;
  const a=p.alpha*Math.max(0,1-d/1.6)/255,k=(y*320+x)*4,b=output.data[k+3]/255,total=a+b*(1-a);
  for(let c=0;c<3;c++)output.data[k+c]=Math.round(([110,106,97][c]*p.tone*a+output.data[k+c]*b*(1-a))/total);
  output.data[k+3]=Math.round(total*255);
 }
 for(let k=0;k<output.data.length;k+=4)if(output.data[k+3]<=4)output.data.fill(0,k,k+4);
 writePNG(`${directory}/f00${stage+4}.png`,output);
 records.push({frame:stage+4,corpse_opacity:opacity,holes,soft_ash_flecks:flecks});
}
writeFileSync(directory+'/derivation.json',JSON.stringify({source,static_approval:'art/review-pursuer-corpse-key-r01/review_verdict.md',method:'Progressive soft erosion and Ash Grey conversion of corpse paint; seeded small soft ash flecks descend and settle, no rectangular wipe or gore.',records},null,2)+'\n');
