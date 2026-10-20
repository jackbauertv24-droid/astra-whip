#!/usr/bin/env node
import{readFileSync,writeFileSync}from'node:fs';
import{readPNG}from'./lib/png.mjs';
const args=process.argv.slice(2),opt=name=>{const i=args.indexOf(name);return i<0?undefined:args[i+1]},prefix=opt('--prefix')||'evidence/boss-hazard',out=opt('--out')||'evidence/boss-hazard-visibility.json';
const failures=[],samples=[],contract=JSON.parse(readFileSync('contract/art_contract.json'));
const warm=(r,g,b)=>r>135&&r>g*1.12&&g>b*1.15;
for(const size of ['native','phone']){
 const dir=prefix+'-'+size,data=JSON.parse(readFileSync(dir+'/capture.json'));
 for(const record of data.records.filter(r=>r.branch==='full_cycle'))for(const sample of record.samples.filter(s=>['hazard_windup','hazard_execute'].includes(s.state))){
  const image=readPNG(dir+'/'+sample.file),scale=image.height/720,originX=sample.position[0],cx=image.width/2+(sample.hazard_x-originX)*scale,ground=sample.position[1]*scale;
  const height=sample.state==='hazard_execute'?46:56;let warmPixels=0;
  const id=sample.state==='hazard_execute'?'vfx_hazard_eruption':'vfx_hazard_telegraph';let frame=0,time=sample.elapsed*1000;while(frame<contract.clips[id].ms.length-1&&time>=contract.clips[id].ms[frame]){time-=contract.clips[id].ms[frame];frame++}const source=readPNG('art/frames/'+id+'/f'+String(frame).padStart(3,'0')+'.png');let sourceWarm=0;for(let i=0;i<source.data.length;i+=4)if(source.data[i+3]>=64&&warm(source.data[i],source.data[i+1],source.data[i+2]))sourceWarm++;
  const bounds=[Math.max(0,Math.floor(cx-82*scale)),Math.max(0,Math.floor(ground-(height+2)*scale)),Math.min(image.width,Math.ceil(cx+82*scale)),Math.min(image.height,Math.ceil(ground+2*scale))];
  for(let y=bounds[1];y<bounds[3];y++)for(let x=bounds[0];x<bounds[2];x++){const i=(y*image.width+x)*4;if(warm(image.data[i],image.data[i+1],image.data[i+2]))warmPixels++}
  const minimum=Math.max(4,Math.floor(sourceWarm*(scale*.5)**2*.2));
  samples.push({size,direction:record.direction,file:sample.file,state:sample.state,frame:sample.frame,effect_id:id,effect_frame:frame,warm_pixels:warmPixels,source_warm_pixels:sourceWarm,minimum,bounds});if(warmPixels<minimum)failures.push(size+' '+sample.file+' hazard warning hidden');
 }
}
const result={visual_approval:false,scope:'source-derived warm-pixel visibility tripwire; independent visual review remains required',pass:!failures.length,samples,failures};writeFileSync(out,JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify({samples:samples.length,failures:failures.length,pass:result.pass}));if(failures.length)process.exit(1);
