#!/usr/bin/env node
import fs from 'node:fs';import{readPNG,writePNG,blank}from'./lib/png.mjs';
const root='art/production-candidates/background-r01',spec=JSON.parse(fs.readFileSync('game/data/background_art.json')).assets,derivations={};
for(const[id,s]of Object.entries(spec)){
 const mirrored=s.tiling==='x',input=readPNG(root+'/'+id+(mirrored?'/half.png':'/canvas.png')),out=mirrored?blank(input.width*2,input.height):input;
 if(mirrored)for(let y=0;y<input.height;y++)for(let x=0;x<input.width;x++)for(let c=0;c<4;c++){const v=input.data[(y*input.width+x)*4+c];out.data[(y*out.width+x)*4+c]=v;out.data[(y*out.width+out.width-1-x)*4+c]=v;}
 if(out.width!==s.canvas[0]||out.height!==s.canvas[1])throw Error('canvas '+id);
 writePNG(root+'/'+id+'/f000.png',out);const runtime=s.path.replace('res://','game/');fs.mkdirSync(runtime.slice(0,runtime.lastIndexOf('/')),{recursive:true});fs.copyFileSync(root+'/'+id+'/f000.png',runtime);
 derivations[id]={kind:'generated_background',source:[root+'/'+id+'/raw.png',root+'/'+id+'/prompt.txt',root+'/'+id+(mirrored?'/half.png.provenance.json':'/canvas.png.provenance.json')],method:mirrored?'Uniform half-module resolution conversion followed by exact horizontal reflection; centre and wrap edge RGBA match. No seam repaint or deformation.':'Uniform whole-canvas resolution conversion only.',corrective_normalization:1,visual_approval:false};if(id==='bg_sky')derivations[id].source.push(root+'/'+id+'/raw-r02.png',root+'/'+id+'/edit-prompt-r02.txt');if(id==='bg_foreground_frame')derivations[id].method='Exact source left/right half extraction; separate uniform256px whole-half conversions; placed at opposite ends of2048x256transparent strip. No stretching or repaint.';fs.writeFileSync(root+'/'+id+'/derivation.json',JSON.stringify(derivations[id],null,2)+'\n');
}fs.writeFileSync(root+'/derivations.json',JSON.stringify(derivations,null,2)+'\n');console.log('PREPARED four standalone background panels; no atlas or collision changes');
