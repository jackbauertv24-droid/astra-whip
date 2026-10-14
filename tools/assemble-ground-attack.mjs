#!/usr/bin/env node
// Painted attack bodies and a labeled ART_CONTRACT section11 leather-whip fallback.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{readFileSync,writeFileSync,mkdirSync,existsSync,cpSync}from'node:fs';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const paths=['hero_attack-rest-key','hero_windup-key-v2','hero_same-arm-strike-key','hero_ground-strike-f3-key-r03','hero_attack-follow-key','hero_ground-return-f5-key-r01','hero_ground-gather-f6-key-r02','hero_ground-settle-f7-key-r01'].map(p=>'art/production-candidates/'+p+'.png');
// Source-pixel annotations, refined against the painted closed gloves before review.
const sockets=[[234,337],[217,241],[327,275],[331,280],[286,338],[223,345],[232,343],[236,340]];
const ends=[[227,354],[198,241],[346,277],[349,281],[298,351],[218,361],[225,361],[226,358]];
const body='hero_attack_ground',weapon='whip_attack_ground';
for(const id of[body,weapon]){
 const root='art/frames/'+id;
 if(existsSync(root)){const archive=`art/rejected/ground-${Date.now()}-${id}`;mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
 mkdirSync(root,{recursive:true});
}
paths.forEach((p,i)=>{const im=readPNG(p);for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);writePNG(`art/frames/${body}/f00${i}.png`,im);});
const neutral=readPNG('art/frames/style_hero_neutral/f000.png'),strike=readPNG(paths[2]);
function palette(im,x0,y0,x1,y1){const a=[];for(let y=y0;y<y1;y++)for(let x=x0;x<x1;x++){const j=(y*im.width+x)*4,r=im.data[j],g=im.data[j+1],b=im.data[j+2];if(im.data[j+3]>=200&&r>g*1.15&&g>b*1.1&&r>45&&r<210)a.push([r,g,b]);}if(!a.length)throw Error('No approved leather/handle swatch');return a;}
const leather=palette(neutral,220,345,249,379),wood=palette(strike,334,273,346,281);
const mix=(a,b,t)=>a+(b-a)*t;
function spline(points){const out=[];for(let i=0;i<points.length-1;i++){const a=points[Math.max(0,i-1)],b=points[i],d=points[i+1],e=points[Math.min(points.length-1,i+2)];const steps=Math.max(12,Math.ceil(Math.hypot(d[0]-b[0],d[1]-b[1])*1.5));for(let k=0;k<steps;k++){const t=k/steps,t2=t*t,t3=t2*t;out.push([0,1].map(q=>.5*((2*b[q])+(-a[q]+d[q])*t+(2*a[q]-5*b[q]+4*d[q]-e[q])*t2+(-a[q]+3*b[q]-3*d[q]+e[q])*t3)));}}out.push(points.at(-1));return out;}
function stroke(im,points,w0,w1,swatch){
 let x0=im.width,y0=im.height,x1=0,y1=0;for(const p of points){x0=Math.min(x0,p[0]);y0=Math.min(y0,p[1]);x1=Math.max(x1,p[0]);y1=Math.max(y1,p[1]);}
 const radius=Math.max(w0,w1)/2+1;
 for(let y=Math.max(0,Math.floor(y0-radius));y<=Math.min(im.height-1,Math.ceil(y1+radius));y++)for(let x=Math.max(0,Math.floor(x0-radius));x<=Math.min(im.width-1,Math.ceil(x1+radius));x++){
  let best=Infinity,at=0,signed=0;
  for(let k=0;k<points.length-1;k++){const a=points[k],b=points[k+1],dx=b[0]-a[0],dy=b[1]-a[1],len2=dx*dx+dy*dy;if(!len2)continue;const t=Math.max(0,Math.min(1,((x+.5-a[0])*dx+(y+.5-a[1])*dy)/len2)),px=a[0]+t*dx,py=a[1]+t*dy,d=Math.hypot(x+.5-px,y+.5-py);if(d<best){best=d;at=(k+t)/(points.length-1);signed=((x+.5-px)*dy-(y+.5-py)*dx)/Math.sqrt(len2);}}
  const width=mix(w0,w1,at),alpha=Math.max(0,Math.min(1,width/2+.5-best));if(!alpha)continue;
  const col=swatch[(Math.floor(at*127)*13+x*3+y*7)%swatch.length],shade=Math.max(.72,Math.min(1.18,.97+signed/Math.max(1,width)*.22));
  const j=(y*im.width+x)*4,old=im.data[j+3]/255,total=alpha+old*(1-alpha);for(let k=0;k<3;k++)im.data[j+k]=Math.round((Math.min(255,col[k]*shade)*alpha+im.data[j+k]*old*(1-alpha))/total);im.data[j+3]=Math.round(total*255);
 }
}
function coil(end){const[x,y]=end;return[[x,y],[x-8,y+10],[x-8,y+29],[x+5,y+39],[x+19,y+28],[x+17,y+9],[x+1,y+5],[x-3,y+22],[x+7,y+32],[x+13,y+21],[x+8,y+11]];}
for(let i=0;i<8;i++){
 const im=blank(768,512),s=sockets[i],e=ends[i],dx=e[0]-s[0],dy=e[1]-s[1],length=Math.hypot(dx,dy),unit=[dx/length,dy/length];
 stroke(im,[[s[0]-6*unit[0],s[1]-6*unit[1]],e],5.5,4.5,wood);
 let points;
 if(i===0||i===7)points=coil(e);
 else if(i===1)points=[e,[e[0]-22,e[1]-26],[e[0]-75,e[1]-48],[e[0]-125,e[1]-34]];
 else if(i===2)points=[e,[408,263],[475,296],[538,328],[600,320]];
 else if(i===3)points=[e,[410,269],[480,307],[548,333],[610,320]];
 else if(i===4)points=[e,[335,391],[405,401],[462,375],[450,340],[410,330],[372,356],[392,380],[429,378]];
 else if(i===5)points=[e,[240,396],[298,408],[351,386],[344,353],[310,350],[282,377],[299,398],[325,385],[319,366]];
 else points=[e,[215,375],[217,395],[237,410],[262,399],[273,378],[260,362],[237,365],[230,387],[245,401],[261,389],[264,374],[248,368]];
 stroke(im,spline(points),i===0||i===7?3.8:4.2,1.3,leather);
 writePNG(`art/frames/${weapon}/f00${i}.png`,im);
}
const meta=JSON.parse(readFileSync('art/frames/clips.json')),derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
const bodyDerivation={kind:'reused',source:paths,method:'Four approved attack anchors plus four direct painted in-betweens, each new body normalized once from its original delivery at bounded uniform scale; alpha<=4 cleanup only.',reason:'Replace held preview poses with a complete ordered action. Fresh independent body/weapon motion review required.'};
const whipDerivation={kind:'scripted_fallback',source:['art/frames/style_hero_neutral/f000.png',paths[2]],method:'Tapered raster leather curves and wood grip use sampled colors from approved coil/grip paint; source-pixel glove sockets and grip directions register each frame. Separate eight-frame weapon layer, no blank phases. Hand occlusion is explicit in the review composites and runtime shader.',reason:'Generated weapon key missed its hand socket by31.6px and had19.7px root thickness; diagnostic retained in art/rejected/whip-ground-key-r01. Full independent composite/motion review required.'};
for(const[id,d]of[[body,bodyDerivation],[weapon,whipDerivation]]){meta[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d};derivations[id]=d;}
writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2));writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2));
const socketPath='art/frames/hand_sockets.json',socketData=existsSync(socketPath)?JSON.parse(readFileSync(socketPath)):{};socketData[body]=sockets;writeFileSync(socketPath,JSON.stringify(socketData,null,2));
const occlusionPath='art/frames/hand_occlusion.json',occlusion=existsSync(occlusionPath)?JSON.parse(readFileSync(occlusionPath)):{};occlusion[body]=sockets.map(()=>8);writeFileSync(occlusionPath,JSON.stringify(occlusion,null,2));
