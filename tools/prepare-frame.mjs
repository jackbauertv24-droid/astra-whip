#!/usr/bin/env node
// Deterministic export-resolution conversion only, no pose/identity editing.
// Corrective normalization remains bounded and must be explicitly requested.
import {readPNG,writePNG} from './lib/png.mjs';
import {mkdirSync,writeFileSync} from 'node:fs';
import {dirname} from 'node:path';
const [src,dst,wstr,hstr] = process.argv.slice(2);
const input=readPNG(src), width=Number(wstr),height=Number(hstr);
const data=new Uint8Array(width*height*4);
const resolutionScale=Math.min(width/input.width,height/input.height),offsetX=(width-input.width*resolutionScale)/2,offsetY=(height-input.height*resolutionScale)/2;
// Area integration of premultiplied alpha avoids edge halos on downsampling.
for(let y=0;y<height;y++)for(let x=0;x<width;x++){
 const x0=(x-offsetX)/resolutionScale,x1=(x+1-offsetX)/resolutionScale;
 const y0=(y-offsetY)/resolutionScale,y1=(y+1-offsetY)/resolutionScale;
 let rgba=[0,0,0,0], area=(x1-x0)*(y1-y0);
 for(let sy=Math.floor(y0);sy<Math.ceil(y1);sy++)for(let sx=Math.floor(x0);sx<Math.ceil(x1);sx++){
  if(sy<0||sy>=input.height||sx<0||sx>=input.width)continue;
  const weight=(Math.min(sx+1,x1)-Math.max(sx,x0))*(Math.min(sy+1,y1)-Math.max(sy,y0));
  const i=(sy*input.width+sx)*4,a=input.data[i+3]/255;
  for(let c=0;c<3;c++)rgba[c]+=input.data[i+c]*a*weight;
  rgba[3]+=a*weight;
 }
 const i=(y*width+x)*4;
 for(let c=0;c<3;c++)data[i+c]=rgba[3]?Math.round(rgba[c]/rgba[3]):0;
 data[i+3]=Math.round(rgba[3]/area*255);
}
mkdirSync(dirname(dst),{recursive:true});writePNG(dst,{width,height,data});
writeFileSync(dst+'.provenance.json',JSON.stringify({source:src,source_canvas:[input.width,input.height],export_canvas:[width,height],method:'uniform canvas resolution conversion, area filter, premultiplied alpha',corrective_normalization:1,debris_removed:0},null,2));
