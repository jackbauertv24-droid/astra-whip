#!/usr/bin/env node
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{readFileSync,writeFileSync,mkdirSync,copyFileSync}from'node:fs';
if(!readFileSync('art/review-boss-idle-r01/review_verdict.md','utf8').trimEnd().endsWith('REVIEW: PASS'))throw Error('Unapproved boss source');
const source='art/frames/boss_idle/f000.png',src=readPNG(source),dir='art/production-candidates/boss-hurt-r01';mkdirSync(dir,{recursive:true});const records=[];
for(let f=0;f<3;f++){
 const angle=[-4,-2,0][f]*Math.PI/180;
 if(f===2){copyFileSync(source,`${dir}/f00${f}.png`);records.push({frame:f,reuse:source});continue;}
 const im=meshWarp(src,[0,70,110,140,176,210,240,270,300,512],[0,160,200,240,280,310,340,370,400,440,480,512,576],(x,y)=>{const w=1-clamp((y-330)/100),dx=x-176,dy=y-350;return[x+(176+dx*Math.cos(angle)-dy*Math.sin(angle)-x)*w,y+(350+dx*Math.sin(angle)+dy*Math.cos(angle)-y)*w];});let removed=0;
 for(let k=0;k<im.data.length;k+=4)if(im.data[k+3]<=4){if(im.data[k+3])removed++;im.data.fill(0,k,k+4);}writePNG(`${dir}/f00${f}.png`,im);records.push({frame:f,upper_recoil_degrees:[-4,-2,0][f],removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
const derivation={kind:'scripted_fallback',source:[source,'tools/prepare-boss-hurt.mjs'],method:'Small connected4° upper-body recoil easing through hips to fixed legs/soles,2° release and exact neutral endpoint. No global scaling or actor recentering.',reason:'D23 continuation from approved boss construction after retained generated sheet failed scale/registration; brief local hurt must pass fresh action/runtime review. Scripted motion remains quality debt.',records};writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');for(const p of['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(p)),record=Object.fromEntries(Object.entries(derivation).filter(([k])=>k!=='records'));if(p.endsWith('clips.json'))d.boss_hurt={ms:[70,70,60],loop:false,derivation:record};else d.boss_hurt=record;writeFileSync(p,JSON.stringify(d,null,2)+'\n');}
