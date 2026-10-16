#!/usr/bin/env node
// Equal-cell export of a generated three-frame strip; no pose or effect resizing.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{mkdirSync,readFileSync,writeFileSync}from'node:fs';
const source='art/production-candidates/projectile-grave-shot-sheet-r01/sheet.png',sheet=readPNG(source);
if(sheet.width!==192||sheet.height!==64)throw Error('Expected192x64 three-cell source');
const dir='art/production-candidates/projectile-grave-shot-r01';mkdirSync(dir,{recursive:true});const records=[];
for(let frame=0;frame<3;frame++){
 const img=blank(64,64);let removed=0;
 for(let y=0;y<64;y++)for(let x=0;x<64;x++){
  const k=(y*64+x)*4,j=(y*192+x+frame*64)*4;img.data.set(sheet.data.subarray(j,j+4),k);
  if(img.data[k+3]<=4){if(img.data[k+3])removed++;img.data.fill(0,k,k+4);}
 }
 writePNG(`${dir}/f00${frame}.png`,img);records.push({frame,source_rect:[frame*64,0,64,64],removed_alpha_at_most:4,removed_low_alpha_pixels:removed});
}
writeFileSync(dir+'/provenance.json',JSON.stringify({source,prompt_record:'art/prompts/projectile-grave-shot.json',method:'Uniform source resolution conversion recorded on sheet, equal-cell crop, zero alpha≤4 only; no corrective scale/translation or new painted pixels',records},null,2)+'\n');
const path='art/frames/clips.json',d=JSON.parse(readFileSync(path));d.projectile_grave_shot={ms:[80,80,80],loop:true,generation:{prompt_record:'art/prompts/projectile-grave-shot.json',source,provenance:dir+'/provenance.json'}};writeFileSync(path,JSON.stringify(d,null,2)+'\n');
