#!/usr/bin/env node
// Image-based regression for the high-density portrait startup fixture.
import{readPNG}from'./lib/png.mjs';
import{writeFileSync}from'node:fs';
const before=process.argv.includes('--before'),path='evidence/pause-density-'+(before?'before-centering-':'')+'portrait-3.png',im=readPNG(path);
let y0=im.height,y1=-1,pixels=0;
for(let y=0;y<im.height;y++)for(let x=Math.ceil(im.width*.15);x<im.width*.85;x++){const j=(y*im.width+x)*4,r=im.data[j],g=im.data[j+1],b=im.data[j+2];if(Math.min(r,g,b)>=150&&Math.max(r,g,b)-Math.min(r,g,b)<=35){y0=Math.min(y0,y);y1=Math.max(y1,y);pixels++;}}
const offset=Math.abs((y0+y1)*.5-im.height*.5),pass=pixels>1000&&offset<=30;
const result={fixture:path,image_size:[im.width,im.height],prompt_ink_y:[y0,y1],ink_pixels:pixels,center_offset_backing_px:offset,maximum_offset_px:30,pass,physical_device:false};
if(!before)writeFileSync('evidence/pause-density-centering.json',JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result,null,2));process.exit(pass?0:1);
