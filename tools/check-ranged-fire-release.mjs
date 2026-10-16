#!/usr/bin/env node
// Tripwire for the reviewed charge rebound; does not substitute for art review.
import{readPNG}from'./lib/png.mjs';
const path=process.argv[2]??'art/frames/ranged_fire/f002.png',img=readPNG(path);
let green=0;
for(let y=120;y<185;y++)for(let x=175;x<235;x++){
 const k=(y*img.width+x)*4,[r,g,b,a]=img.data.subarray(k,k+4);
 if(a>=40&&g>120&&g-r>20&&g-b>20)green++;
}
console.log(`RANGED FIRE RELEASE: ${green} bright phosphor pixels in final hand region; ${path}`);
process.exitCode=green?1:0;
