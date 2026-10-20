#!/usr/bin/env node
import{readPNG,writePNG,blank}from'./lib/png.mjs';import{mkdirSync,writeFileSync}from'node:fs';
for(const [name,id,count,cols,width,height,scale,pivot,rowY] of [['checkpoint-marker','prop_checkpoint',2,2,192,320,1,[96,288],[0]],['checkpoint-effect','vfx_checkpoint_activate',8,4,256,384,.85,[128,352],[0,438]]]){
 const root='art/production-candidates/'+name+'-sheet-r01',sheet=readPNG(root+'/canvas.png'),out='art/production-candidates/'+name+'-r01',records=[];mkdirSync(out,{recursive:true});mkdirSync(root+'/raw-frames',{recursive:true});
 for(let f=0;f<count;f++){
  const ox=f%cols*width,oy=rowY[Math.floor(f/cols)],sourceHeight=count===2?320:(f<4?438:330),im=blank(width,sourceHeight),file='f'+String(f).padStart(3,'0')+'.png';
  for(let y=0;y<sourceHeight;y++)im.data.set(sheet.data.subarray(((oy+y)*sheet.width+ox)*4,((oy+y)*sheet.width+ox+width)*4),y*width*4);
  writePNG(root+'/raw-frames/'+file,im);let b=[width,sourceHeight,-1,-1],removed=0;
  for(let y=0;y<sourceHeight;y++)for(let x=0;x<width;x++){const k=(y*width+x)*4,a=im.data[k+3];if(a>=40)b=[Math.min(b[0],x),Math.min(b[1],y),Math.max(b[2],x),Math.max(b[3],y)];if(a<=8){if(a)removed++;im.data.fill(0,k,k+4)}}
  const from=[(b[0]+b[2])/2,b[3]],to=blank(width,height);
  for(let y=0;y<height;y++)for(let x=0;x<width;x++){
   const sx=(x-pivot[0])/scale+from[0],sy=(y-pivot[1])/scale+from[1],ix=Math.floor(sx),iy=Math.floor(sy),fx=sx-ix,fy=sy-iy;let a=0,rgb=[0,0,0];
   for(let dy=0;dy<2;dy++)for(let dx=0;dx<2;dx++){if(ix+dx<0||ix+dx>=width||iy+dy<0||iy+dy>=sourceHeight)continue;const k=((iy+dy)*width+ix+dx)*4,w=(dx?fx:1-fx)*(dy?fy:1-fy),alpha=im.data[k+3]/255;a+=alpha*w;for(let c=0;c<3;c++)rgb[c]+=im.data[k+c]*alpha*w}
   const k=(y*width+x)*4;for(let c=0;c<3;c++)to.data[k+c]=a?Math.round(rgb[c]/a):0;to.data[k+3]=Math.round(a*255);
   if((x<2||x>=width-2||y<2||y>=height-2)&&to.data[k+3]>8)throw Error('Border paint '+id+f);
  }
  writePNG(out+'/'+file,to);records.push({frame:f,source_cell:[ox,oy,width,sourceHeight],source_ink_bbox:b,source_pivot:from,delivery_pivot:pivot,corrective_normalization:scale,removed_low_alpha_pixels:removed,debris_removed:0});
 }
 const derivation={kind:'generated_sheet',source:[root+'/raw.png',root+'/canvas.png',root+'/prompt.txt','tools/prepare-checkpoint.mjs'],method:count===2?'Two directly painted static states, equal192x320 cells, full-canvas resolution conversion then base registration.':'Eight directly painted phases; actual generated sheet row split y438 retained in raw cells. One uniform bounded0.85 correction for ALL phases, preserving relative sizes, then base registration. No per-frame size normalization. Remove only alpha<=8 extraction remnants, premultiplied bilinear resampling.',records,visual_approval:false};writeFileSync(out+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');console.log(JSON.stringify({id,records}));
}
