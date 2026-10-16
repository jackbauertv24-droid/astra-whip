#!/usr/bin/env node
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,copyFileSync,readFileSync,writeFileSync}from'node:fs';
const source='art/production-candidates/ranged-hurt-key-r01/key.png',idle=readPNG('art/frames/ranged_idle/f000.png'),key=readPNG(source),peak=readPNG('art/frames/ranged_idle/f000.png');
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);};
const post=(x,y)=>(x<=124&&y<50)||(x<=116&&y<92)||(x<=108&&y<140);
for(let y=15;y<220;y++)for(let x=95;x<211;x++){
 const k=(y*256+x)*4,w=1-smooth(190,220,y),a=idle.data[k+3]/255,b=key.data[k+3]/255,t=a*(1-w)+b*w;
 for(let c=0;c<3;c++)peak.data[k+c]=t?Math.round((idle.data[k+c]*a*(1-w)+key.data[k+c]*b*w)/t):0;
 peak.data[k+3]=Math.round(t*255);
}
const dir='art/production-candidates/ranged-hurt-r01';mkdirSync(dir,{recursive:true});writePNG(dir+'/peak-source.png',peak);
const xs=[0,70,90,100,108,116,124,132,140,148,160,180,200,220,256],ys=[0,15,25,40,50,65,80,92,110,125,140,160,180,190,205,220,240,280,320,352],records=[];
for(let frame=0;frame<2;frame++){
 const amount=frame===0?.6:1;
 const output=meshWarp(peak,xs,ys,(x,y)=>{const w=(1-smooth(90,220,y))*smooth(108,130,x);return[x-8*amount*w,y+4*amount*w];});
 let removed=0;for(let y=0;y<352;y++)for(let x=0;x<256;x++){
  const k=(y*256+x)*4;
  if(post(x,y)||y>=220||x<95||x>220)output.data.set(idle.data.subarray(k,k+4),k);
  if(output.data[k+3]<=4){if(output.data[k+3])removed++;output.data.fill(0,k,k+4);}
 }
 writePNG(`${dir}/f00${frame}.png`,output);records.push({frame,upper_body_recoil_amount:amount,hood_max_translation:[-8*amount,4*amount],removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
copyFileSync('art/frames/ranged_idle/f000.png',dir+'/f002.png');records.push({frame:2,reuse:'art/frames/ranged_idle/f000.png'});
const derivation={kind:'scripted_fallback',source:[source,'art/frames/ranged_idle/f000.png','tools/prepare-ranged-hurt.mjs'],method:'Generated inward protective arm/torso key patched above fixed idle lower robe/base; restore fixed rear post; local upper-body recoil increases from60%to100%, then exact idle endpoint. No global scale or recentering.',reason:'Generated key supplied the connected defensive fold but leaned toward the incoming hit and repainted stationary construction. Local correction restores fixed idle post/base and adds bounded away-from-hit upper recoil. Fresh full-action/source review required; D23 scripted quality debt retained.',records};
writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');
for(const path of ['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(path)),r={kind:derivation.kind,source:derivation.source,method:derivation.method,reason:derivation.reason};if(path.endsWith('clips.json'))d.ranged_hurt={ms:[60,60,60],loop:false,derivation:r};else d.ranged_hurt=r;writeFileSync(path,JSON.stringify(d,null,2)+'\n');}
