#!/usr/bin/env node
// D23: generated correction drafts retained supported arches; articulate approved wings instead.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,writeFileSync,readFileSync}from'node:fs';
const source='art/production-candidates/swooper-identity-r02/key.png';
if(!readFileSync('art/review-swooper-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW: PASS'))throw Error('Unapproved source');
const src=readPNG(source),parts=[blank(384,256),blank(384,256)],body=blank(384,256);
const polygons=[[[0,0],[160,0],[175,98],[161,120],[144,136],[134,150],[107,155],[0,160]],[[215,0],[384,0],[384,170],[246,157],[225,136],[215,104]]];
function inside(x,y,p){let v=false;for(let a=0,b=p.length-1;a<p.length;b=a++)if((p[a][1]>y)!==(p[b][1]>y)&&x<(p[b][0]-p[a][0])*(y-p[a][1])/(p[b][1]-p[a][1])+p[a][0])v=!v;return v;}
for(let y=0;y<256;y++)for(let x=0;x<384;x++){const k=(y*384+x)*4,owner=polygons.findIndex(p=>inside(x+.5,y+.5,p));(owner<0?body:parts[owner]).data.set(src.data.subarray(k,k+4),k);}
function over(dst,img){for(let k=0;k<dst.data.length;k+=4){let a=img.data[k+3]/255,b=dst.data[k+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[k+c]=Math.round((img.data[k+c]*a+dst.data[k+c]*b*(1-a))/t);dst.data[k+3]=Math.round(t*255);}}
const out=blank(384,256),xs=[0,45,65,85,105,120,128,135,145,155,165,175,192,215,225,240,255,270,279,290,310,330,350,384],ys=[0,40,45,50,55,65,80,95,110,125,140,155,175,195,213,256];
for(let side=0;side<2;side++){
 const pivot=side===0?[175,100]:[215,104],angle=(side===0?-1:1)*78*Math.PI/180;
 over(out,meshWarp(parts[side],xs,ys,(x,y)=>{const d=[x-pivot[0],y-pivot[1]],a=angle*clamp(side===0?(175-x)/16:(x-215)/16);return[pivot[0]+d[0]*Math.cos(a)-d[1]*Math.sin(a),pivot[1]+d[0]*Math.sin(a)+d[1]*Math.cos(a)];}));
}
const smooth=(a,b,x)=>{const t=clamp((x-a)/(b-a));return t*t*(3-2*t);};
over(out,meshWarp(body,xs,ys,(x,y)=>{const h=smooth(190,205,x)*(1-smooth(240,255,x))*smooth(65,80,y)*(1-smooth(115,135,y)),a=30*Math.PI/180*h,dx=x-200,dy=y-110;return[200+dx*Math.cos(a)-dy*Math.sin(a),110+dx*Math.sin(a)+dy*Math.cos(a)];}));
for(let k=0;k<out.data.length;k+=4)if(out.data[k+3]<=4)out.data.fill(0,k,k+4);
const dir='art/production-candidates/swooper-death-limp-r04';mkdirSync(dir,{recursive:true});writePNG(dir+'/unregistered.png',out);
let top=256,bottom=-1;for(let y=0;y<256;y++)for(let x=0;x<384;x++)if(out.data[(y*384+x)*4+3]>=40){top=Math.min(top,y);bottom=Math.max(bottom,y);}
const dy=128-(top+bottom)/2,registered=meshWarp(out,[0,384],[0,256],(x,y)=>[x,y+dy]);
for(let k=0;k<registered.data.length;k+=4)if(registered.data[k+3]<=4)registered.data.fill(0,k,k+4);
writePNG(dir+'/key.png',registered);writeFileSync(dir+'/derivation.json',JSON.stringify({kind:'scripted_fallback',source,reason:'Three generated death corrections retained active supported wing arches; independent r01/r03 keys rejected. Reuse approved paint with actual shoulder articulation.',method:'Separate complete wing layers rotated78degrees downward about blended attached shoulder roots, local30degree hood droop. Static key envelope registered once by uniform factor1 with vertical translation; no size scaling.',polygons,shoulders:[[175,100],[215,104]],wing_rotation_degrees:[-78,78],static_registration_translation:[0,dy],source_envelope:[top,bottom],corrective_normalization:1},null,2)+'\n');
