#!/usr/bin/env node
// Candidate only: approval and source integration are separate gates.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{makeBossSupportRenderer}from'./lib/boss-supported-pose.mjs';
import{mkdirSync,writeFileSync,copyFileSync}from'node:fs';
const W=512,H=576,dir='art/production-candidates/boss-death-r01';mkdirSync(dir,{recursive:true});
const idle='art/frames/boss_idle/f000.png',src=readPNG(idle),support=makeBossSupportRenderer(src);
function move(im,dx,dy){const out=blank(W,H);for(let y=0;y<H;y++)for(let x=0;x<W;x++){const X=x+dx,Y=y+dy;if(X<0||X>=W||Y<0||Y>=H)continue;out.data.set(im.data.subarray((y*W+x)*4,(y*W+x)*4+4),(Y*W+X)*4)}return out}
const keys={kneel:{dx:-44,dy:0},fold:{dx:-44,dy:-17},settle:{dx:-44,dy:-22}},images={},registrations={};
for(const[id,p]of Object.entries(keys)){const path=`art/production-candidates/boss-death-${id}-r01/canvas.png`;images[id]=move(readPNG(path),p.dx,p.dy);registrations[id]={source:path,translation:[p.dx,p.dy],corrective_normalization:1,reason:'Floor and common root registration only; collapsed height is never normalized to standing height.'};writePNG(dir+'/'+id+'-registered.png',images[id])}
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t)};
const fold=images.fold,deep=meshWarp(fold,[0,50,100,150,200,250,300,350,400,450,512],[0,220,260,300,340,380,410,440,470,495,512,576],(x,y)=>{const w=1-smooth(420,500,y),a=25*Math.PI/180,dx=x-220,dy=y-440;return[x+w*(220+dx*Math.cos(a)-dy*Math.sin(a)-x),y+w*(440+dx*Math.sin(a)+dy*Math.cos(a)-y)]});
const frames=[src,support(15,15).image,support(25,35).image,images.kneel,move(images.kneel,0,5),fold,deep,images.settle,images.settle];
// The final ash is a newly painted local effect, not a scaled actor.
const ashSource='art/production-candidates/boss-death-ash-r01/canvas.png',ash=meshWarp(readPNG(ashSource),[0,W],[0,H],(x,y)=>[220+(x-256)*.65,512+(y-561)*.65]);
let seed=730441;const random=()=>{seed=(Math.imul(seed,1664525)+1013904223)>>>0;return seed/4294967296};
const ink=[];for(let y=0;y<H;y++)for(let x=0;x<W;x++)if(images.settle.data[(y*W+x)*4+3]>180)ink.push([x,y]);
const holes=Array.from({length:70},()=>{const[x,y]=ink[Math.floor(random()*ink.length)];return{x,y,r:8+random()*12}});
for(const stage of [0,1,2]){const out=blank(W,H),opacity=[.7,.25,0][stage];for(let i=0;i<out.data.length;i+=4){const x=(i/4)%W,y=Math.floor(i/4/W);let mask=1;if(opacity)for(const h of holes)mask*=clamp((Math.hypot(x-h.x,y-h.y)-h.r*(.4+stage*.3))/(h.r*.6));const a=images.settle.data[i+3]/255*opacity*mask,b=ash.data[i+3]/255*[.35,.75,1][stage],t=b+a*(1-b);if(!t)continue;for(let c=0;c<3;c++)out.data[i+c]=Math.round((ash.data[i+c]*b+(images.settle.data[i+c]*.25+[132,127,116][c]*.75)*a*(1-b))/t);out.data[i+3]=Math.round(t*255)}frames.push(out)}
for(let n=0;n<frames.length;n++){const image=frames[n];let removed=0;for(let j=0;j<image.data.length;j+=4)if(image.data[j+3]<=4){if(image.data[j+3])removed++;image.data.fill(0,j,j+4)}writePNG(dir+'/f'+String(n).padStart(3,'0')+'.png',image)}
const derivation={kind:'scripted_fallback',source:[idle,...Object.values(registrations).map(p=>p.source),ashSource,'tools/prepare-boss-death.mjs','tools/lib/boss-supported-pose.mjs'],method:'Approved neutral and fixed-sole articulated loading; generated kneeling, folding and settled keys with integer root/floor registration; one local supported fold between generated keys; two seeded soft ash-erosion frames and newly painted ash final. No full-actor scale normalization or full-length horizontal fall. Final local ash effect sized0.65 about its floor anchor. Low-alpha resampling cleanup<=4 is explicit.',reason:'D23 candidate continuation; independently generated joint-folded keys retain source detail and require fresh motion/runtime approval. Scripted rig and erosion are declared quality debt.',registrations,seed,holes,ash_effect:{source:ashSource,source_anchor:[256,561],target_anchor:[220,512],scale:.65},visual_approval:false};
writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');writeFileSync(dir+'/candidate-manifest.json',JSON.stringify({boss_death:{ms:Array(12).fill(90),loop:false,derivation}},null,2)+'\n');
