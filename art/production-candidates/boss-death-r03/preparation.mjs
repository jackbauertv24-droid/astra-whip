#!/usr/bin/env node
// Candidate only: approval and source integration are separate gates.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{makeBossSupportRenderer}from'./lib/boss-supported-pose.mjs';
import{mkdirSync,writeFileSync,copyFileSync}from'node:fs';
const W=512,H=576,dir='art/production-candidates/boss-death-r03';mkdirSync(dir,{recursive:true});
const idle='art/frames/boss_idle/f000.png',src=readPNG(idle),support=makeBossSupportRenderer(src);
function move(im,dx,dy){const out=blank(W,H);for(let y=0;y<H;y++)for(let x=0;x<W;x++){const X=x+dx,Y=y+dy;if(X<0||X>=W||Y<0||Y>=H)continue;out.data.set(im.data.subarray((y*W+x)*4,(y*W+x)*4+4),(Y*W+X)*4)}return out}
const keys={kneel:{dx:-44,dy:0,scale:.95},fold:{dx:-44,dy:-17,scale:.9},settle:{dx:-44,dy:-22,scale:.9}},images={},registrations={};
keys.bridge={dx:0,dy:-17,scale:1};
for(const[id,p]of Object.entries(keys)){const path=`art/production-candidates/boss-death-${id}-r01/canvas.png`;images[id]=meshWarp(move(readPNG(path),p.dx,p.dy),[0,W],[0,H],(x,y)=>[176+(x-176)*p.scale,512+(y-512)*p.scale]);registrations[id]={source:path,translation:[p.dx,p.dy],corrective_normalization:p.scale,reason:'Bounded uniform correction about common root to physical plate size, never normalize collapsed height to standing height. Floor registration is retained.'};writePNG(dir+'/'+id+'-registered.png',images[id])}
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t)};
const fold=images.fold;
const kneelSag=meshWarp(images.kneel,[0,W],[0,220,300,380,440,480,512,576],(x,y)=>[x,y+4*(1-smooth(420,505,y))]);
const frames=[src,support(15,15).image,support(25,20).image,images.kneel,kneelSag,fold,images.bridge,images.settle,images.settle];
// The final ash is a newly painted local effect, not a scaled actor.
const ashSource='art/production-candidates/boss-death-ash-r01/canvas.png',ash=meshWarp(readPNG(ashSource),[0,W],[0,H],(x,y)=>[220+(x-256)*.65,512+(y-561)*.65]);
const seed=730441,dist=new Uint16Array(W*H);
for(let p=0;p<dist.length;p++)dist[p]=images.settle.data[p*4+3]>40?1024:0;
for(let y=0;y<H;y++)for(let x=0;x<W;x++){const p=y*W+x;if(x)dist[p]=Math.min(dist[p],dist[p-1]+1);if(y)dist[p]=Math.min(dist[p],dist[p-W]+1)}
for(let y=H-1;y>=0;y--)for(let x=W-1;x>=0;x--){const p=y*W+x;if(x<W-1)dist[p]=Math.min(dist[p],dist[p+1]+1);if(y<H-1)dist[p]=Math.min(dist[p],dist[p+W]+1)}
const noise=(x,y)=>{let v=Math.imul((x>>2)+seed,374761393)^Math.imul((y>>2)+seed,668265263);v=Math.imul(v^(v>>>13),1274126177);return((v^(v>>>16))>>>0)/4294967296};
for(const stage of [0,1,2]){const out=blank(W,H),opacity=[.85,.25,0][stage];for(let i=0;i<out.data.length;i+=4){const x=(i/4)%W,y=Math.floor(i/4/W),threshold=[5,14,0][stage]+noise(x,y)*6,mask=smooth(threshold,threshold+3,dist[i/4]);const a=images.settle.data[i+3]/255*opacity*mask,b=ash.data[i+3]/255*[.35,.75,1][stage],t=b+a*(1-b);if(!t)continue;for(let c=0;c<3;c++)out.data[i+c]=Math.round((ash.data[i+c]*b+(images.settle.data[i+c]*.25+[132,127,116][c]*.75)*a*(1-b))/t);out.data[i+3]=Math.round(t*255)}frames.push(out)}
const frameRecords=[];
for(let n=0;n<frames.length;n++){const image=frames[n];let removed=0;for(let j=0;j<image.data.length;j+=4)if(image.data[j+3]<=4){if(image.data[j+3])removed++;image.data.fill(0,j,j+4)}writePNG(dir+'/f'+String(n).padStart(3,'0')+'.png',image);frameRecords.push({frame:n,removed_low_alpha_pixels:removed,debris_removed:0})}
const derivation={kind:'scripted_fallback',source:[idle,...Object.values(registrations).map(p=>p.source),ashSource,'tools/prepare-boss-death.mjs','tools/lib/boss-supported-pose.mjs'],method:'Approved neutral and fixed-sole articulated loading; generated kneeling, folding and settled keys with integer root/floor registration; a separately painted supported-hand inbetween; two seeded irregular edge-distance ash-erosion frames and newly painted ash final. Bounded uniform physical-size corrections0.95/0.90 are recorded per generated key; collapsed height is never normalized to standing height. No full-length horizontal fall. Final local ash effect sized0.65 about its floor anchor. Low-alpha resampling cleanup<=4 is explicit.',reason:'D23 candidate continuation; independently generated joint-folded keys retain source detail and require fresh motion/runtime approval. Scripted rig and erosion are declared quality debt.',registrations,seed,erosion:{method:"two-pass distance from existing silhouette/cloth edges; seeded2D grain modulates edge retreat, no placed circular holes",stage_opacity:[.85,.25,0],maximum_stage0_retreat_pixels:14},runtime_entry:"First90ms holds the exact body texture visible at lethal contact; common loading resumes at f1. Runtime snapshots use already delivered approved poses, not new/generated art.",ash_effect:{source:ashSource,source_anchor:[256,561],target_anchor:[220,512],scale:.65},visual_approval:false};
derivation.records=frameRecords;
writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');writeFileSync(dir+'/candidate-manifest.json',JSON.stringify({boss_death:{ms:Array(12).fill(90),loop:false,derivation}},null,2)+'\n');
