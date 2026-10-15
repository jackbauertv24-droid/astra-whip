#!/usr/bin/env node
// D23 local poised wing-fold acting, baked from a painted folded-body key.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,readFileSync,writeFileSync}from'node:fs';
const source='art/production-candidates/swooper-fold-r01/key.png';
if(!readFileSync('art/review-swooper-fold-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW: PASS'))throw Error('Fold key not independently accepted');
const im=readPNG(source),dir='art/production-candidates/swooper-telegraph-r01';mkdirSync(dir,{recursive:true});
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);},records=[];
for(let frame=0;frame<4;frame++){
 const tension=[0,.6,1,1][frame],quiver=[0,1,-.7,.3][frame];
 const out=frame===0?im:meshWarp(im,[0,135,150,165,175,185,195,205,220,235,250,384],[0,46,60,75,90,105,120,135,150,170,190,210,256],(x,y)=>{
  const folded=smooth(148,165,x)*(1-smooth(187,199,x))*smooth(65,85,y)*(1-smooth(119,139,y));
  const hood=smooth(190,205,x)*(1-smooth(98,118,y))*smooth(62,76,y);
  const rags=smooth(142,158,x)*(1-smooth(185,201,x))*smooth(145,170,y)*(1-smooth(197,210,y));
  return[x+folded*(192-x)*.045*tension+hood*1.5*tension+rags*quiver*1.5,y+hood*.8*tension+rags*quiver*.4];
 });
 for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);
 writePNG(`${dir}/f00${frame}.png`,out);records.push({frame,tension,cloth_quiver:quiver,wing_fold_held:true});
}
writeFileSync(dir+'/derivation.json',JSON.stringify({source,static_review:'art/review-swooper-fold-key-r01/review_verdict.md',method:'Painted folded pose held from first frame through full tell; local folded-membrane tightening, slight hood anticipation and cloth-tip quiver, no global scaling/translation.',records},null,2)+'\n');
