#!/usr/bin/env node
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{mkdirSync,writeFileSync}from'node:fs';
const root='art/production-candidates/whip-impact-sheet-r01',sheet=readPNG(root+'/canvas.png'),out='art/production-candidates/whip-impact-r01',records=[];
mkdirSync(root+'/raw-frames',{recursive:true});mkdirSync(out,{recursive:true});
for(let frame=0;frame<6;frame++){
 const image=blank(192,192),name='f'+String(frame).padStart(3,'0')+'.png',ox=frame%3*192,oy=Math.floor(frame/3)*192;
 for(let y=0;y<192;y++)image.data.set(sheet.data.subarray(((oy+y)*sheet.width+ox)*4,((oy+y)*sheet.width+ox+192)*4),y*192*4);
 writePNG(root+'/raw-frames/'+name,image);
 let x0=192,y0=192,x1=-1,y1=-1,removed=0;
 for(let y=0;y<192;y++)for(let x=0;x<192;x++){const k=(y*192+x)*4;if(image.data[k+3]>=40){x0=Math.min(x0,x);y0=Math.min(y0,y);x1=Math.max(x1,x);y1=Math.max(y1,y)}if(image.data[k+3]<=4){if(image.data[k+3])removed++;image.data.fill(0,k,k+4)}}
 if(x1<0)throw Error('Empty frame '+frame);
 const dx=Math.round(96-(x0+x1)/2),dy=Math.round(96-(y0+y1)/2),registered=blank(192,192);
 if(Math.abs(dx)>24||Math.abs(dy)>24)throw Error('Excessive cell registration '+frame);
 for(let y=0;y<192;y++)for(let x=0;x<192;x++){const X=x+dx,Y=y+dy,k=(y*192+x)*4;if(X<0||X>=192||Y<0||Y>=192){if(image.data[k+3])throw Error('Clipped paint '+frame);continue}registered.data.set(image.data.subarray(k,k+4),(Y*192+X)*4)}
 writePNG(out+'/'+name,registered);records.push({frame,source_cell:[ox,oy,192,192],source_ink_bbox:[x0,y0,x1,y1],translation:[dx,dy],corrective_normalization:1,removed_low_alpha_pixels:removed,debris_removed:0});
}
const derivation={kind:'generated_sheet',source:[root+'/raw.png',root+'/canvas.png',root+'/prompt.txt',root+'/guide.png','tools/prepare-whip-impact.mjs'],method:'Six directly painted equal192px cells, uniform sheet resolution conversion, integer registration of each ink-bbox centre to(96,96), no frame scale or painted content deformation. Remove only alpha<=4 resampling remnants; raw cells and all shifts/counts retained.',records,visual_approval:false};
writeFileSync(out+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');writeFileSync(out+'/candidate-manifest.json',JSON.stringify({vfx_whip_impact:{ms:[40,40,40,50,50,60],loop:false,derivation}},null,2)+'\n');console.log(JSON.stringify(records));
