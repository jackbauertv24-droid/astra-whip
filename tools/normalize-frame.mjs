#!/usr/bin/env node
// Contract G-03: one uniform bounded scale and pivot registration, logged.
import {readPNG,writePNG} from './lib/png.mjs';
import {writeFileSync} from 'node:fs';
const [src,dst,heightString='224',pivotX='256',pivotY='448']=process.argv.slice(2);
const im=readPNG(src),target=Number(heightString);
let minX=im.width,minY=im.height,maxX=-1,maxY=-1;
for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++)if(im.data[(y*im.width+x)*4+3]>=40){minX=Math.min(minX,x);maxX=Math.max(maxX,x);minY=Math.min(minY,y);maxY=Math.max(maxY,y);}
const scale=target/(maxY-minY+1);
if(scale<.85||scale>1.18)throw Error(`G-03: scale ${scale} outside allowed range; regenerate`);
let footMin=im.width,footMax=-1;
for(let y=maxY-Math.ceil((maxY-minY+1)*.08);y<=maxY;y++)for(let x=0;x<im.width;x++)if(im.data[(y*im.width+x)*4+3]>=40){footMin=Math.min(footMin,x);footMax=Math.max(footMax,x);}
const pivot=[(footMin+footMax)/2,maxY],to=[Number(pivotX),Number(pivotY)],data=new Uint8Array(im.width*im.height*4);
for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++){
 const sx=(x-to[0])/scale+pivot[0],sy=(y-to[1])/scale+pivot[1];
 const ix=Math.floor(sx),iy=Math.floor(sy),fx=sx-ix,fy=sy-iy;
 let a=0,rgb=[0,0,0];
 for(let dy=0;dy<2;dy++)for(let dx=0;dx<2;dx++){
  if(ix+dx<0||ix+dx>=im.width||iy+dy<0||iy+dy>=im.height)continue;
  const j=((iy+dy)*im.width+ix+dx)*4,w=(dx?fx:1-fx)*(dy?fy:1-fy),alpha=im.data[j+3]/255;
  a+=alpha*w;
  for(let c=0;c<3;c++)rgb[c]+=im.data[j+c]*alpha*w;
 }
 const j=(y*im.width+x)*4;
 for(let c=0;c<3;c++)data[j+c]=a?Math.round(rgb[c]/a):0;
 data[j+3]=Math.round(a*255);
}
writePNG(dst,{width:im.width,height:im.height,data});
const record={source:src,corrective_normalization:scale,source_pivot:pivot,delivery_pivot:to,target_height:target,method:'uniform bounded scale about measured foot pivot, registration at contract pivot',debris_removed:0};
writeFileSync(dst+'.normalization.json',JSON.stringify(record,null,2));console.log(record);
