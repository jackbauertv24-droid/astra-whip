#!/usr/bin/env node
// G03 bounded uniform normalization of a flight source key, before animation.
import {readPNG,writePNG} from './lib/png.mjs';
import {meshWarp} from './lib/deform.mjs';
import {writeFileSync} from 'node:fs';
const [source,destination,heightString='170']=process.argv.slice(2);
const image=readPNG(source),height=Number(heightString);let top=image.height,bottom=-1;
for(let y=0;y<image.height;y++)for(let x=0;x<image.width;x++)if(image.data[(y*image.width+x)*4+3]>=40){top=Math.min(top,y);bottom=Math.max(bottom,y);}
const scale=height/(bottom-top+1),from=[192,(top+bottom)/2],to=[192,128];
if(scale<.85||scale>1.18)throw Error(`G03 scale ${scale} requires regeneration`);
const output=meshWarp(image,[0,image.width],[0,image.height],(x,y)=>[(x-from[0])*scale+to[0],(y-from[1])*scale+to[1]]);
let removed=0;for(let k=0;k<output.data.length;k+=4)if(output.data[k+3]<=4){if(output.data[k+3])removed++;output.data.fill(0,k,k+4);}
writePNG(destination,output);
writeFileSync(destination+'.normalization.json',JSON.stringify({source,corrective_normalization:scale,source_pivot:from,delivery_pivot:to,target_height:height,method:'One bounded uniform normalization about authored horizontal origin and measured vertical envelope center; static key only, not per-animation recentering.',removed_alpha_at_most:4,removed_pixels:removed},null,2)+'\n');
