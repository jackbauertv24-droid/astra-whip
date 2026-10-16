#!/usr/bin/env node
// Local generated correction for residual phosphor embedded in the painted hand.
import{readPNG,writePNG}from'./lib/png.mjs';
import{mkdirSync,writeFileSync}from'node:fs';
const original='art/production-candidates/ranged-aim-r03/body-source.png',correction='art/production-candidates/ranged-fire-clean-hand-r01/key.png';
const body=readPNG(original),clean=readPNG(correction),polygon=[[183,134],[219,130],[226,148],[224,178],[188,177],[181,155]];
function inside(x,y){let hit=false;for(let i=0,j=polygon.length-1;i<polygon.length;j=i++){const a=polygon[i],b=polygon[j];if((a[1]>y)!=(b[1]>y)&&x<(b[0]-a[0])*(y-a[1])/(b[1]-a[1])+a[0])hit=!hit;}return hit;}
let changed=0;
for(let y=0;y<352;y++)for(let x=0;x<256;x++)if(inside(x,y)){
 const k=(y*256+x)*4;
 // Feather only at the attached wrist; replace the contaminated outer silhouette completely.
 const w=Math.max(0,Math.min(1,(x-182)/8));
 const a=body.data[k+3]/255,b=clean.data[k+3]/255,t=a*(1-w)+b*w;
 for(let c=0;c<3;c++)body.data[k+c]=t?Math.round((body.data[k+c]*a*(1-w)+clean.data[k+c]*b*w)/t):0;
 body.data[k+3]=Math.round(t*255);changed++;
}
const dir='art/production-candidates/ranged-fire-r02';mkdirSync(dir,{recursive:true});writePNG(dir+'/clean-body-source.png',body);
writeFileSync(dir+'/hand-correction.json',JSON.stringify({original,correction,polygon,edited_region_pixels:changed,method:'Local generated hand patch, eight-pixel alpha-aware wrist blend; all other body pixels preserved. Uniform source registration recorded separately.'},null,2)+'\n');
