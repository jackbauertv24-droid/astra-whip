#!/usr/bin/env node
// Reviewed painted cutout method: short asymmetric hit recoil with fixed supports.
// Static key acceptance is separate: art/review-pursuer-keys-r01/review_verdict.md.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{mkdirSync,writeFileSync}from'node:fs';
const source='art/review-pursuer-keys-r01/f000.png',src=readPNG(source);
const legs=[
 {id:'hind_far',phase:.75,start:175,root:[140,166],points:[[143,162],[132,188],[156,209],[168,216]],polygon:[[144,153],[153,160],[148,180],[156,195],[172,203],[180,211],[179,218],[161,219],[145,207],[128,190],[135,166]]},
 {id:'fore_far',phase:.5,start:241,root:[210,155],points:[[214,146],[221,176],[244,193],[254,211]],polygon:[[210,145],[222,153],[225,169],[242,179],[252,190],[264,200],[266,211],[253,215],[244,203],[235,195],[220,185],[212,174],[208,156]]},
 {id:'hind_near',phase:.25,start:135,points:[[138,155],[118,181],[101,209],[87,224]],polygon:[[139,146],[150,152],[145,169],[126,184],[107,191],[104,205],[98,218],[97,226],[76,226],[67,225],[72,209],[84,199],[89,182],[106,175],[123,165],[125,152]]},
 {id:'fore_near',phase:0,start:231,points:[[195,142],[182,177],[214,207],[226,224]],polygon:[[195,132],[208,137],[204,155],[189,178],[202,192],[217,201],[228,210],[240,217],[240,226],[212,226],[205,215],[198,205],[176,191],[170,178],[180,154],[183,140]]},
];
function inside(x,y,ps){let on=false;for(let i=0,j=ps.length-1;i<ps.length;j=i++)if((ps[i][1]>y)!==(ps[j][1]>y)&&x<(ps[j][0]-ps[i][0])*(y-ps[i][1])/(ps[j][1]-ps[i][1])+ps[i][0])on=!on;return on;}
const parts=legs.map(()=>blank(320,256)),body={...src,data:Buffer.from(src.data)};
for(let y=0;y<256;y++)for(let x=0;x<320;x++){
 let owner=-1;for(let k=0;k<legs.length;k++)if(inside(x+.5,y+.5,legs[k].polygon))owner=k;
 if(owner<0)continue;const j=(y*320+x)*4;parts[owner].data.set(src.data.subarray(j,j+4),j);body.data.fill(0,j,j+4);
}
// Remove isolated old toe fragments left outside the four limb masks. Retain
// the connected cloak/head/torso paint, including its attached ragged edges.
const seen=new Uint8Array(320*256),components=[];
for(let p=0;p<seen.length;p++){if(seen[p]||body.data[p*4+3]<5)continue;const q=[p];seen[p]=1;for(let k=0;k<q.length;k++){const v=q[k],x=v%320,y=Math.floor(v/320);for(const [dx,dy]of[[1,0],[-1,0],[0,1],[0,-1]]){const nx=x+dx,ny=y+dy,n=ny*320+nx;if(nx<0||nx>=320||ny<0||ny>=256||seen[n]||body.data[n*4+3]<5)continue;seen[n]=1;q.push(n);}}components.push(q);}
components.sort((a,b)=>b.length-a.length);for(const component of components.slice(1))for(const p of component)body.data.fill(0,p*4,p*4+4);
function project(p,a,b){const dx=b[0]-a[0],dy=b[1]-a[1],t=clamp(((p[0]-a[0])*dx+(p[1]-a[1])*dy)/(dx*dx+dy*dy));return{t,d:Math.hypot(p[0]-a[0]-t*dx,p[1]-a[1]-t*dy)};}
function ik(s,e,w,targetS,targetW){
 const a=Math.hypot(e[0]-s[0],e[1]-s[1]),b=Math.hypot(w[0]-e[0],w[1]-e[1]);
 const dx=targetW[0]-targetS[0],dy=targetW[1]-targetS[1],dist=Math.hypot(dx,dy),d=Math.min(a+b-.001,Math.max(Math.abs(a-b)+.001,dist));
 const along=(a*a-b*b+d*d)/(2*d),height=Math.sqrt(Math.max(0,a*a-along*along)),sign=((w[0]-s[0])*(e[1]-s[1])-(w[1]-s[1])*(e[0]-s[0]))>=0?1:-1;
 return[targetS[0]+dx/dist*along-dy/dist*height*sign,targetS[1]+dy/dist*along+dx/dist*height*sign];
}
function over(dst,im){for(let j=0;j<im.data.length;j+=4){const a=im.data[j+3]/255,b=dst.data[j+3]/255,total=a+b*(1-a);if(!a)continue;for(let k=0;k<3;k++)dst.data[j+k]=Math.round((im.data[j+k]*a+dst.data[j+k]*b*(1-a))/total);dst.data[j+3]=Math.round(total*255);}}
const boneParts=legs.map((leg,k)=>{
 let bottom=0;for(let y=0;y<256;y++)for(let x=0;x<320;x++)if(parts[k].data[(y*320+x)*4+3]>=40)bottom=Math.max(bottom,y);
 leg.points[3][1]=bottom;
 const ps=leg.points,bs=[blank(320,256),blank(320,256),blank(320,256)];
 for(let y=0;y<256;y++)for(let x=0;x<320;x++){
  const j=(y*320+x)*4;if(!parts[k].data[j+3])continue;
  const ds=ps.slice(0,-1).map((p,i)=>project([x,y],p,ps[i+1]).d),owner=ds.indexOf(Math.min(...ds));
  for(let n=0;n<3;n++)if(n===owner||n<2&&Math.hypot(x-ps[n+1][0],y-ps[n+1][1])<5||n>0&&Math.hypot(x-ps[n][0],y-ps[n][1])<5)bs[n].data.set(parts[k].data.subarray(j,j+4),j);
 }
 return bs;
});
function targetFoot(leg,frame){const p=(frame/8+leg.phase)%1,travel=86.4;return p<.5?{p,stance:true,point:[leg.start-travel*p,224]}:{p,stance:false,point:[leg.start-43.2+43.2*(.5-.5*Math.cos((p-.5)*2*Math.PI)),224-16*Math.sin((p-.5)*2*Math.PI)]};}
const clips={pursuer_hurt:[
 {angle:-8,drop:3,lean_x:-5,feet:[[153.4,224],[197.8,224],[113.4,224],[205,190]]},
 {angle:-4,drop:1,lean_x:-2.5,feet:[[153.4,216],[197.8,224],[113.4,224],[218,210]]},
 {angle:0,drop:0,feet:[[153.4,208],[197.8,224],[113.4,224],[231,224]]}
]};
for(const [id,poses]of Object.entries(clips)){
 const directory='art/production-candidates/pursuer-hurt-r02/'+id;
 mkdirSync(directory,{recursive:true});
 const records=[];
 for(let frame=0;frame<poses.length;frame++){
 const pose=poses[frame],angle=pose.angle*Math.PI/180;
 const torso=(x,y)=>[138+(x-138)*Math.cos(angle)-(y-160)*Math.sin(angle)+(pose.lean_x||0),160+(x-138)*Math.sin(angle)+(y-160)*Math.cos(angle)+pose.drop];
 const out=blank(320,256),rendered=[],sample={frame,torso_rotation_degrees:pose.angle,hips_drop_px:pose.drop,legs:[]};
 for(let k=0;k<legs.length;k++){
  const leg=legs[k],ps=leg.points,foot={point:pose.feet[k]};
  const root=leg.root||ps[0],s=torso(root[0],root[1]),w=[foot.point[0]-(ps[3][0]-ps[2][0]),foot.point[1]-(ps[3][1]-ps[2][1])],e=ik(ps[0],ps[1],ps[2],s,w),targets=[s,e,w,foot.point],image=blank(320,256);
  for(let n=0;n<3;n++){
   const a=ps[n],b=ps[n+1],ta=targets[n],tb=targets[n+1],angle=n===2?0:Math.atan2(tb[1]-ta[1],tb[0]-ta[0])-Math.atan2(b[1]-a[1],b[0]-a[0]);
   over(image,meshWarp(boneParts[k][n],[0,320],[0,256],(x,y)=>[ta[0]+(x-a[0])*Math.cos(angle)-(y-a[1])*Math.sin(angle),ta[1]+(x-a[0])*Math.sin(angle)+(y-a[1])*Math.cos(angle)]));
  }
  if(process.env.ASTRA_RIG_DEBUG==='1')writePNG(`/tmp/${id}-f${frame}-${leg.id}.png`,image);
  rendered.push(image);sample.legs.push({id:leg.id,ground_contact:Math.abs(foot.point[1]-224)<.01,paw:foot.point,source_joints:ps,target_joints:targets});
 }
 for(const k of [0,1,2])over(out,rendered[k]);
 over(out,meshWarp(body,[0,320],[0,256],torso));over(out,rendered[3]);
 for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);
 writePNG(`${directory}/f00${frame}.png`,out);records.push(sample);
}
writeFileSync(directory+'/rig.json',JSON.stringify({source,static_key_review:'art/review-pursuer-keys-r01/review_verdict.md',method:'Asymmetric hit recoil: torso/head retract about the hips, one forearm folds against the chest, fixed opposite forepaw and near hindpaw provide support. Recover into approved approach entry. Source bone lengths preserved; no whole-body scale or translation.',records},null,2)+'\n');
}
