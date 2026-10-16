#!/usr/bin/env node
// D23 fallback after retained generated sheet failed scale/registration.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,writeFileSync,readFileSync}from'node:fs';
if(!readFileSync('art/review-boss-key-r01/review_verdict.md','utf8').includes('STATIC KEY REVIEW PASS'))throw Error('Unapproved construction key');
const source='art/production-candidates/boss-identity-r01/key.png',src=readPNG(source),W=512,H=576;
const legs=[
 {id:'far',phase:0,mean:202,points:[[202,353],[222,426],[228,490],[243,506]],polygon:[[194,337],[215,344],[225,389],[237,423],[239,469],[242,482],[300,482],[300,525],[200,525],[199,487],[204,466],[203,430],[191,402],[185,373]]},
 {id:'near',phase:.5,mean:153,points:[[176,354],[145,427],[132,489],[136,512]],polygon:[[160,336],[186,344],[184,372],[174,399],[167,427],[153,459],[148,481],[148,489],[159,500],[160,515],[109,517],[107,490],[116,471],[115,450],[121,426],[132,402],[143,379],[150,356]]}
];
function inside(x,y,ps){let on=false;for(let i=0,j=ps.length-1;i<ps.length;j=i++)if((ps[i][1]>y)!==(ps[j][1]>y)&&x<(ps[j][0]-ps[i][0])*(y-ps[i][1])/(ps[j][1]-ps[i][1])+ps[i][0])on=!on;return on;}
function over(dst,im){for(let j=0;j<im.data.length;j+=4){const a=im.data[j+3]/255,b=dst.data[j+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[j+c]=Math.round((im.data[j+c]*a+dst.data[j+c]*b*(1-a))/t);dst.data[j+3]=Math.round(t*255);}}
function project(p,a,b){const dx=b[0]-a[0],dy=b[1]-a[1],t=clamp(((p[0]-a[0])*dx+(p[1]-a[1])*dy)/(dx*dx+dy*dy));return Math.hypot(p[0]-a[0]-t*dx,p[1]-a[1]-t*dy);}
function ik(s,e,w,S,T){const a=Math.hypot(e[0]-s[0],e[1]-s[1]),b=Math.hypot(w[0]-e[0],w[1]-e[1]),dx=T[0]-S[0],dy=T[1]-S[1],dist=Math.hypot(dx,dy),d=Math.min(a+b-.001,Math.max(Math.abs(a-b)+.001,dist)),along=(a*a-b*b+d*d)/(2*d),h=Math.sqrt(Math.max(0,a*a-along*along)),sign=((w[0]-s[0])*(e[1]-s[1])-(w[1]-s[1])*(e[0]-s[0]))>=0?1:-1;return[S[0]+dx/dist*along-dy/dist*h*sign,S[1]+dy/dist*along+dx/dist*h*sign];}
const body={...src,data:Buffer.from(src.data)},parts=legs.map(()=>blank(W,H));
for(let y=0;y<H;y++)for(let x=0;x<W;x++){let owner=-1;for(let k=0;k<legs.length;k++)if(inside(x+.5,y+.5,legs[k].polygon))owner=k;if(owner<0)continue;const j=(y*W+x)*4;parts[owner].data.set(src.data.subarray(j,j+4),j);body.data.fill(0,j,j+4);}
const boneParts=legs.map((leg,k)=>{const bs=[blank(W,H),blank(W,H),blank(W,H)];for(let y=0;y<H;y++)for(let x=0;x<W;x++){const j=(y*W+x)*4;if(!parts[k].data[j+3])continue;const ds=leg.points.slice(0,-1).map((p,i)=>project([x,y],p,leg.points[i+1])),owner=ds.indexOf(Math.min(...ds));for(let n=0;n<3;n++)if(n===owner||n<2&&Math.hypot(x-leg.points[n+1][0],y-leg.points[n+1][1])<7||n>0&&Math.hypot(x-leg.points[n][0],y-leg.points[n][1])<7)bs[n].data.set(parts[k].data.subarray(j,j+4),j);}return bs;});
const dir='art/production-candidates/boss-walk-r01';mkdirSync(dir,{recursive:true});
writePNG(dir+'/body.png',body);parts.forEach((im,i)=>writePNG(dir+`/leg-${i}.png`,im));
const records=[];
for(let frame=0;frame<8;frame++){
 const out=blank(W,H),bob=2-2*Math.cos(frame*Math.PI/2),sample={frame,bob,legs:[]},rendered=[];
 for(let k=0;k<legs.length;k++){
  const leg=legs[k],p=(frame/8+leg.phase)%1,u=(p-.6)/.4,foot=p<.6?[leg.mean+26.88-89.6*p,512]:[leg.mean-26.88+53.76*(.5-.5*Math.cos(Math.PI*u)),512-22*Math.sin(Math.PI*u)],ps=leg.points,S=[ps[0][0],ps[0][1]+bob],T=[foot[0]-(ps[3][0]-ps[2][0]),foot[1]-(ps[3][1]-ps[2][1])],E=ik(ps[0],ps[1],ps[2],S,T),targets=[S,E,T,foot],im=blank(W,H);
  for(let n=0;n<3;n++){const a=ps[n],b=ps[n+1],ta=targets[n],tb=targets[n+1],angle=n===2?0:Math.atan2(tb[1]-ta[1],tb[0]-ta[0])-Math.atan2(b[1]-a[1],b[0]-a[0]);over(im,meshWarp(boneParts[k][n],[0,W],[0,H],(x,y)=>[ta[0]+(x-a[0])*Math.cos(angle)-(y-a[1])*Math.sin(angle),ta[1]+(x-a[0])*Math.sin(angle)+(y-a[1])*Math.cos(angle)]));}
  rendered.push(im);sample.legs.push({id:leg.id,phase:p,stance:p<.6,foot,source_joints:ps,target_joints:targets});
 }
 over(out,rendered[0]);over(out,rendered[1]);
 // Retained torso and overhanging shroud occlude the hip seams. No actor scaling.
 over(out,meshWarp(body,[0,100,176,220,300,512],[0,160,260,340,420,480,576],(x,y)=>[x+(y>340?Math.sin(frame*Math.PI/4)*1.5*clamp((y-340)/140):0),y+bob]));
 let removed=0;for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4){if(out.data[j+3])removed++;out.data.fill(0,j,j+4);}sample.removed_low_alpha_pixels=removed;writePNG(`${dir}/f00${frame}.png`,out);records.push(sample);
}
const derivation={kind:'scripted_fallback',source:[source,'tools/prepare-boss-walk.mjs'],method:'Two connected plated-leg bone rigs with fixed-length upper/lower segments, flat translated boots, alternating60% stance,22px swing clearance,89.6px stride, small weight/shroud response; no global scale or per-frame recenter.',reason:'Generated eight-frame sheet enlarged actors to485–503px versus352px and changed root registration; retained raw/equal crops/rejection. D23 local rig requires fresh full gait/runtime review and remains scripted animation quality debt.',records};writeFileSync(dir+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');
for(const path of['art/frames/clips.json','art/frames/derivations.json']){const d=JSON.parse(readFileSync(path)),record=Object.fromEntries(Object.entries(derivation).filter(([k])=>k!=='records'));if(path.endsWith('clips.json'))d.boss_walk={ms:Array(8).fill(80),loop:true,derivation:record};else d.boss_walk=record;writeFileSync(path,JSON.stringify(d,null,2)+'\n');}
