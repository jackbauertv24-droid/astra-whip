#!/usr/bin/env node
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{mkdirSync,writeFileSync}from'node:fs';
const root='art/production-candidates/enemy-defeat-sheet-r01',sheet=readPNG(root+'/canvas.png'),out='art/production-candidates/enemy-defeat-r01',records=[];
mkdirSync(root+'/raw-frames',{recursive:true});mkdirSync(out,{recursive:true});
for(let f=0;f<8;f++){
 const image=blank(256,256),name='f'+String(f).padStart(3,'0')+'.png',ox=f%4*256,oy=Math.floor(f/4)*256;
 for(let y=0;y<256;y++)image.data.set(sheet.data.subarray(((oy+y)*sheet.width+ox)*4,((oy+y)*sheet.width+ox+256)*4),y*256*4);
 writePNG(root+'/raw-frames/'+name,image);let box=[256,256,-1,-1],removed=0;
 for(let y=0;y<256;y++)for(let x=0;x<256;x++){const k=(y*256+x)*4,a=image.data[k+3];if(a>=40)box=[Math.min(box[0],x),Math.min(box[1],y),Math.max(box[2],x),Math.max(box[3],y)];if(a<=8){if(a)removed++;image.data.fill(0,k,k+4)}}
 const dx=Math.round(128-(box[0]+box[2])/2),dy=Math.round(128-(box[1]+box[3])/2),registered=blank(256,256);
 for(let y=0;y<256;y++)for(let x=0;x<256;x++){const X=x+dx,Y=y+dy,k=(y*256+x)*4;if(X<2||X>=254||Y<2||Y>=254){if(image.data[k+3])throw Error('Clipped paint '+f+' '+x+','+y+' alpha '+image.data[k+3]);continue}registered.data.set(image.data.subarray(k,k+4),(Y*256+X)*4)}
 writePNG(out+'/'+name,registered);records.push({frame:f,source_cell:[ox,oy,256,256],source_ink_bbox:box,translation:[dx,dy],corrective_normalization:1,removed_low_alpha_pixels:removed,debris_removed:0});
}
const derivation={kind:'generated_sheet',source:[root+'/raw.png',root+'/canvas.png',root+'/prompt.txt','tools/prepare-enemy-defeat.mjs'],method:'Eight directly painted equal256px cells, uniform sheet conversion and integer ink-centre registration to(128,128). Remove only alpha<=8 near-invisible extraction remnants. No scaling, deformation or opacity adjustment. Raw cells and all counts retained.',records,visual_approval:false};writeFileSync(out+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');console.log(JSON.stringify(records));
