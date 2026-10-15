#!/usr/bin/env node
// D23 baked mesh-wing fallback. Paint comes from independently accepted key.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,readFileSync,writeFileSync}from'node:fs';
const source='art/production-candidates/swooper-identity-r02/key.png';
if(!readFileSync('art/review-swooper-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW: PASS'))throw Error('Source key not accepted');
const image=readPNG(source),parts=[blank(384,256),blank(384,256)],body=blank(384,256);
const polygons=[[[0,0],[160,0],[175,98],[161,120],[144,136],[134,150],[107,155],[0,160]],[[215,0],[384,0],[384,170],[246,157],[225,136],[215,104]]];
function inside(x,y,p){let v=false;for(let a=0,b=p.length-1;a<p.length;b=a++)if((p[a][1]>y)!==(p[b][1]>y)&&x<(p[b][0]-p[a][0])*(y-p[a][1])/(p[b][1]-p[a][1])+p[a][0])v=!v;return v;}
for(let y=0;y<256;y++)for(let x=0;x<384;x++){const j=(y*384+x)*4;let owner=polygons.findIndex(p=>inside(x+.5,y+.5,p));(owner<0?body:parts[owner]).data.set(image.data.subarray(j,j+4),j);}
function over(dst,src){for(let j=0;j<dst.data.length;j+=4){const a=src.data[j+3]/255,b=dst.data[j+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[j+c]=Math.round((src.data[j+c]*a+dst.data[j+c]*b*(1-a))/t);dst.data[j+3]=Math.round(t*255);}}
const dir='art/production-candidates/swooper-cruise-rig-r01';mkdirSync(dir,{recursive:true});const records=[];
const xs=[0,45,65,85,105,120,128,135,145,155,165,175,192,215,225,240,255,270,279,290,310,330,350,384],ys=[0,40,45,50,55,65,80,95,110,125,140,155,175,195,213,256];
for(let frame=0;frame<8;frame++){
 const phase=frame*Math.PI/4,stroke=(1-Math.cos(phase))*.5,out=blank(384,256),wing_records=[];
 for(let side=0;side<2;side++){
  const pivot=side===0?[128,49]:[279,55],angle=(side===0?-1:1)*stroke*35*Math.PI/180;
  const warp=(x,y)=>{const influence=clamp(side===0?(175-x)/40:(x-215)/50),a=angle*influence,dx=x-pivot[0],dy=y-pivot[1],flex=Math.sin(phase)*2*clamp((y-80)/60)*influence;return[pivot[0]+dx*Math.cos(a)-dy*Math.sin(a),pivot[1]+dx*Math.sin(a)+dy*Math.cos(a)+flex];};
  over(out,meshWarp(parts[side],xs,ys,warp));
  wing_records.push({side,pivot,outer_angle_degrees:angle*180/Math.PI,shoulder:side===0?[175,100]:[215,104],tip:warp(side===0?53:335,side===0?65:95)});
 }
 over(out,body);
 for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);
 writePNG(`${dir}/f00${frame}.png`,out);records.push({frame,stroke,wings:wing_records});
}
writeFileSync(dir+'/rig.json',JSON.stringify({source,static_review:'art/review-swooper-key-r01/review_verdict.md',method:'Separate wing membranes, fixed shoulder roots, elbow-centered outer-wing flexion with progressive inner-web influence and phase-lagged membrane camber; torso and tail paint remain fixed. Baked compatible RGBA frames, no global scale or translation.',polygons,records},null,2)+'\n');
