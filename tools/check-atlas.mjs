#!/usr/bin/env node
import {readFileSync,readdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {readPNG} from './lib/png.mjs';
const args=process.argv.slice(2),output=args.includes('--out')?args[args.indexOf('--out')+1]:'evidence/atlas-roundtrip.json';
const manifest=JSON.parse(readFileSync('game/data/atlas.json'));
const hash=b=>createHash('sha256').update(b).digest('hex');
const pages=manifest.pages.map(p=>readPNG(p.path.replace('res://','game/')));
const failures=[];let roundtrips=0,negativeControl=false,sourceBytes=0;
const inventory=readdirSync('game/assets',{recursive:true}).filter(f=>/\/f\d+\.png$/.test(f)).map(f=>'res://assets/'+f).sort();
if(JSON.stringify(inventory)!==JSON.stringify(Object.keys(manifest.frames).sort()))failures.push('source inventory differs');
const rects=pages.map(()=>[]),padding=manifest.padding;
for(const [path,entry]of Object.entries(manifest.frames)){
 const image=readPNG(path.replace('res://','game/')),page=pages[entry.page];
 const[x,y,w,h]=entry.region,[tx,ty]=entry.trim,[cw,ch]=entry.canvas;
 if(cw!==image.width||ch!==image.height||tx<0||ty<0||tx+w>cw||ty+h>ch||x<padding||y<padding||x+w+padding>page.width||y+h+padding>page.height)failures.push(path+' invalid geometry');
 const rectangle={x:x-padding,y:y-padding,w:w+padding*2,h:h+padding*2};
 for(const r of rects[entry.page])if(rectangle.x<r.x+r.w&&rectangle.x+rectangle.w>r.x&&rectangle.y<r.y+r.h&&rectangle.y+rectangle.h>r.y)failures.push(path+' overlap');
 rects[entry.page].push(rectangle);
 const restored=new Uint8Array(cw*ch*4);
 for(let row=0;row<h;row++)restored.set(page.data.subarray(((y+row)*page.width+x)*4,((y+row)*page.width+x+w)*4),((ty+row)*cw+tx)*4);
 const original=hash(image.data),rebuilt=hash(restored);
 if(original!==rebuilt||original!==entry.rgba_sha256)failures.push(path+' RGBA mismatch');
 if(!negativeControl){restored[(ty*cw+tx)*4]^=1;negativeControl=hash(restored)!==original}
 sourceBytes+=image.width*image.height*4;roundtrips++;
}
const unpacked=readdirSync('game/assets',{recursive:true}).filter(f=>f.endsWith('.png')&&!manifest.pages.some(page=>page.path==='res://assets/'+f)&&!manifest.frames['res://assets/'+f]).sort().map(file=>{const im=readPNG('game/assets/'+file);return{path:'res://assets/'+file,width:im.width,height:im.height,rgba_bytes:im.width*im.height*4}});
const atlasBytes=manifest.pages.reduce((n,p)=>n+p.rgba_bytes,0),unpackedBytes=unpacked.reduce((n,p)=>n+p.rgba_bytes,0);
const total=atlasBytes+unpackedBytes;
if(total>128*1048576)failures.push('conservative resident inventory exceeds 128MiB');
if(!negativeControl)failures.push('one-byte negative control not detected');
const result={scope:'current delivered inventory; future art requires repacking/rebudgeting; no physical-device profiling',visual_approval:false,roundtrips,negative_control:negativeControl,source_rgba_bytes:sourceBytes,atlas_rgba_bytes:atlasBytes,unpacked_rgba_bytes:unpackedBytes,conservative_rgba_bytes:total,conservative_mib:total/1048576,mipmaps:false,unpacked,failures};
writeFileSync(output,JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify({roundtrips,negativeControl,conservative_mib:total/1048576,failures}));if(failures.length)process.exit(1);
