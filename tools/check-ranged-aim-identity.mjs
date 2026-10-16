#!/usr/bin/env node
// Regression for an idle→aim repaint of the stationary rooted construction.
import {readPNG} from './lib/png.mjs';
import {readFileSync,writeFileSync} from 'node:fs';
const candidate=process.argv[2]??'art/frames/ranged_aim';
const idle=readPNG('art/frames/ranged_idle/f000.png');
const records=[];
for(let frame=0;frame<6;frame++){
 const name=`f00${frame}.png`,img=readPNG(`${candidate}/${name}`);
 if(img.width!==idle.width||img.height!==idle.height)throw Error('Canvas changed');
 let changed=0;
 for(let y=0;y<352;y++)for(let x=0;x<256;x++)if(y<60||y>220||x<110){
  const k=(y*256+x)*4;
  for(let c=0;c<4;c++)if(img.data[k+c]!==idle.data[k+c]){changed++;break;}
 }
 records.push({frame,fixed_region_changed_pixels:changed});
 if(changed)console.error(`FAIL frame${frame}: ${changed} stationary pixels repainted`);
 if(candidate==='art/frames/ranged_aim'){
  const bytes=readFileSync(`${candidate}/${name}`);
  for(const path of [`game/assets/ranged/ranged_aim/${name}`,`art/review-ranged-aim-r03/frames/ranged_aim/${name}`])if(!bytes.equals(readFileSync(path)))throw Error(`Delivery mismatch: ${path}`);
 }
}
const result={reference:'art/frames/ranged_idle/f000.png',candidate,fixed_region:'y<60 or y>220 or x<110; shoulder/arm corridor excluded',records};
if(candidate==='art/frames/ranged_aim')writeFileSync('evidence/ranged-aim-fixed-identity.json',JSON.stringify(result,null,2)+'\n');
const failures=records.filter(x=>x.fixed_region_changed_pixels).length;
console.log(`RANGED AIM IDENTITY: ${6-failures}/6 unchanged fixed-region frames`);
process.exitCode=failures?1:0;
