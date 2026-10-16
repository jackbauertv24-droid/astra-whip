#!/usr/bin/env node
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{readFileSync,writeFileSync,mkdirSync}from'node:fs';
if(!readFileSync('art/review-boss-walk-r01/review_verdict.md','utf8').trimEnd().endsWith('REVIEW: PASS'))throw Error('Unapproved boss source');
const source='art/frames/boss_walk/f000.png',src=readPNG(source),dir='art/production-candidates/boss-idle-r01';mkdirSync(dir,{recursive:true});const records=[];
for(let f=0;f<8;f++){
 const breath=1-Math.cos(f*Math.PI/4),sway=Math.sin(f*Math.PI/4),im=meshWarp(src,[0,70,110,176,220,260,300,512],[0,160,200,260,310,350,400,450,480,512,576],(x,y)=>[x+sway*.6*clamp((y-340)/120)*(1-clamp((y-480)/32)),y-breath*(1-clamp((y-310)/110))]);let removed=0;
 for(let k=0;k<im.data.length;k+=4)if(im.data[k+3]<=4){if(im.data[k+3])removed++;im.data.fill(0,k,k+4);}writePNG(`${dir}/f00${f}.png`,im);records.push({frame:f,head_inhale_pixels:breath,cloth_sway_pixels:sway*.6,removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
const derivation={kind:'scripted_fallback',source:[source,'tools/prepare-boss-idle.mjs'],method:'Reuse accepted walk neutral support, local0–2px inhale above hips,0.6px shroud sway,unchanged boots/pivot and no actor scale. Eight125ms samples complete a1s loop.',reason:'D23 continuation from approved boss construction after generated sheet failed actor scale/registration; local idle requires fresh motion/runtime review. Scripted animation remains quality debt.',records};writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');for(const p of['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(p)),record=Object.fromEntries(Object.entries(derivation).filter(([k])=>k!=='records'));if(p.endsWith('clips.json'))d.boss_idle={ms:Array(8).fill(125),loop:true,derivation:record};else d.boss_idle=record;writeFileSync(p,JSON.stringify(d,null,2)+'\n');}
