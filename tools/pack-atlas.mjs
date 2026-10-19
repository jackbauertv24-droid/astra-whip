#!/usr/bin/env node
import {readdirSync,mkdirSync,writeFileSync,unlinkSync,readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {readPNG,writePNG,blank} from './lib/png.mjs';
const size=2048,padding=8,output='game/assets/atlas';
const files=readdirSync('game/assets',{recursive:true}).filter(f=>/\/f\d+\.png$/.test(f)).sort();
const hash=b=>createHash('sha256').update(b).digest('hex');
const items=files.map(file=>{
 const image=readPNG('game/assets/'+file);let x0=image.width,y0=image.height,x1=-1,y1=-1;
 for(let y=0;y<image.height;y++)for(let x=0;x<image.width;x++){
  const i=(y*image.width+x)*4;
  if(image.data[i]||image.data[i+1]||image.data[i+2]||image.data[i+3]){x0=Math.min(x0,x);y0=Math.min(y0,y);x1=Math.max(x1,x);y1=Math.max(y1,y)}
 }
 if(x1<0){x0=0;y0=0;x1=0;y1=0}
 x0=Math.max(0,x0-2);y0=Math.max(0,y0-2);x1=Math.min(image.width-1,x1+2);y1=Math.min(image.height-1,y1+2);
 return {file,image,x0,y0,w:x1-x0+1,h:y1-y0+1};
}).sort((a,b)=>Math.max(b.w,b.h)-Math.max(a.w,a.h)||b.w*b.h-a.w*a.h||a.file.localeCompare(b.file));
const pages=[],frames={};
function contains(a,b){return a.x<=b.x&&a.y<=b.y&&a.x+a.w>=b.x+b.w&&a.y+a.h>=b.y+b.h}
function insert(page,rect){
 const next=[];
 for(const f of page.free){
  if(rect.x>=f.x+f.w||rect.x+rect.w<=f.x||rect.y>=f.y+f.h||rect.y+rect.h<=f.y){next.push(f);continue}
  if(rect.x>f.x)next.push({x:f.x,y:f.y,w:rect.x-f.x,h:f.h});
  if(rect.x+rect.w<f.x+f.w)next.push({x:rect.x+rect.w,y:f.y,w:f.x+f.w-rect.x-rect.w,h:f.h});
  if(rect.y>f.y)next.push({x:f.x,y:f.y,w:f.w,h:rect.y-f.y});
  if(rect.y+rect.h<f.y+f.h)next.push({x:f.x,y:rect.y+rect.h,w:f.w,h:f.y+f.h-rect.y-rect.h});
 }
 page.free=next.filter((r,i)=>!next.some((other,j)=>j!==i&&contains(other,r)&&(other.w*other.h>r.w*r.h||j<i)));
}
for(const item of items){
 const w=item.w+padding*2,h=item.h+padding*2;
 if(w>size||h>size)throw Error('oversized '+item.file);
 let best;
 for(let p=0;p<pages.length;p++)for(const r of pages[p].free)if(r.w>=w&&r.h>=h){const score=[Math.min(r.w-w,r.h-h),Math.max(r.w-w,r.h-h)];if(!best||score[0]<best.score[0]||score[0]===best.score[0]&&score[1]<best.score[1])best={p,x:r.x,y:r.y,score}}
 if(!best){pages.push({image:blank(size,size),free:[{x:0,y:0,w:size,h:size}]});best={p:pages.length-1,x:0,y:0}}
 insert(pages[best.p],{x:best.x,y:best.y,w,h});
 const x=best.x+padding,y=best.y+padding,page=pages[best.p];
 for(let row=0;row<item.h;row++)page.image.data.set(item.image.data.subarray(((item.y0+row)*item.image.width+item.x0)*4,((item.y0+row)*item.image.width+item.x0+item.w)*4),((y+row)*size+x)*4);
 frames['res://assets/'+item.file]={page:best.p,region:[x,y,item.w,item.h],trim:[item.x0,item.y0],canvas:[item.image.width,item.image.height],rgba_sha256:hash(item.image.data)};
}
mkdirSync(output,{recursive:true});
for(const file of readdirSync(output)){const match=/^page-(\d+)\.png(?:\.import)?$/.exec(file);if(match&&Number(match[1])>=pages.length)unlinkSync(output+'/'+file)}
const pageRecords=pages.map((p,i)=>{const file=`page-${String(i).padStart(2,'0')}.png`;writePNG(output+'/'+file,p.image);return {path:'res://assets/atlas/'+file,width:size,height:size,rgba_bytes:size*size*4}});
const manifest={version:1,rotation:false,padding,filter:'nearest',mipmaps:false,pages:pageRecords,frames:Object.fromEntries(Object.entries(frames).sort(([a],[b])=>a.localeCompare(b)))};
writeFileSync('game/data/atlas.json',JSON.stringify(manifest,null,2)+'\n');
const preset='game/export_presets.cfg';
writeFileSync(preset,readFileSync(preset,'utf8').replace(/exclude_filter="[^"]*"/,'exclude_filter="'+Object.keys(manifest.frames).map(path=>path.replace('res://','')).join(',')+'"'));
console.log(JSON.stringify({frames:items.length,pages:pages.length,rgba_mib:pages.length*size*size*4/1048576}));
