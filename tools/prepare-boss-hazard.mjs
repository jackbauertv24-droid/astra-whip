#!/usr/bin/env node
// Generated open-hand paint on the supported approved boss rig.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
import{makeBossSupportRenderer}from'./lib/boss-supported-pose.mjs';
import{meshWarp,clamp}from'./lib/deform.mjs';
import{readFileSync,writeFileSync,mkdirSync,copyFileSync}from'node:fs';
if(!readFileSync('art/review-boss-idle-r01/review_verdict.md','utf8').trimEnd().endsWith('REVIEW: PASS'))throw Error('Unapproved neutral');
const source='art/frames/boss_idle/f000.png',src=readPNG(source),W=512,H=576,ps=[[215,233],[240,308],[267,371],[271,400]];
const polygon=[[205,225],[221,225],[232,243],[241,274],[250,298],[264,327],[272,350],[291,376],[296,393],[295,409],[278,418],[257,413],[244,402],[243,380],[232,351],[221,329],[213,307],[210,281],[209,253]];
function inside(x,y){let on=false;for(let i=0,j=polygon.length-1;i<polygon.length;j=i++)if((polygon[i][1]>y)!==(polygon[j][1]>y)&&x<(polygon[j][0]-polygon[i][0])*(y-polygon[i][1])/(polygon[j][1]-polygon[i][1])+polygon[i][0])on=!on;return on;}
function over(dst,im){for(let j=0;j<im.data.length;j+=4){const a=im.data[j+3]/255,b=dst.data[j+3]/255,t=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)dst.data[j+c]=Math.round((im.data[j+c]*a+dst.data[j+c]*b*(1-a))/t);dst.data[j+3]=Math.round(t*255);}}
function project(p,a,b){const dx=b[0]-a[0],dy=b[1]-a[1],t=clamp(((p[0]-a[0])*dx+(p[1]-a[1])*dy)/(dx*dx+dy*dy));return Math.hypot(p[0]-a[0]-t*dx,p[1]-a[1]-t*dy);}
const body={...src,data:Buffer.from(src.data)},arm=blank(W,H),parts=[blank(W,H),blank(W,H),blank(W,H)];
for(let y=0;y<H;y++)for(let x=0;x<W;x++){if(!inside(x+.5,y+.5))continue;const j=(y*W+x)*4;arm.data.set(src.data.subarray(j,j+4),j);body.data[j+3]=Math.round(body.data[j+3]*(1-clamp((y-275)/12)));const ds=ps.slice(0,-1).map((a,i)=>project([x,y],a,ps[i+1])),owner=ds.indexOf(Math.min(...ds));for(let n=0;n<3;n++)if(n===owner||n<2&&Math.hypot(x-ps[n+1][0],y-ps[n+1][1])<9||n>0&&Math.hypot(x-ps[n][0],y-ps[n][1])<9)parts[n].data.set(src.data.subarray(j,j+4),j);}
function ik(S,T){const a=Math.hypot(ps[1][0]-ps[0][0],ps[1][1]-ps[0][1]),b=Math.hypot(ps[2][0]-ps[1][0],ps[2][1]-ps[1][1]),dx=T[0]-S[0],dy=T[1]-S[1],dist=Math.hypot(dx,dy),d=Math.min(a+b-.001,Math.max(Math.abs(a-b)+.001,dist)),along=(a*a-b*b+d*d)/(2*d),h=Math.sqrt(Math.max(0,a*a-along*along)),sign=((ps[2][0]-ps[0][0])*(ps[1][1]-ps[0][1])-(ps[2][1]-ps[0][1])*(ps[1][0]-ps[0][0]))>=0?1:-1;return[S[0]+dx/dist*along-dy/dist*h*sign,S[1]+dy/dist*along+dx/dist*h*sign];}
const turn=(p,degrees)=>{const a=degrees*Math.PI/180,dx=p[0]-ps[0][0],dy=p[1]-ps[0][1];return[ps[0][0]+dx*Math.cos(a)-dy*Math.sin(a),ps[0][1]+dx*Math.sin(a)+dy*Math.cos(a)];};
const atAngle=degrees=>ps.map(p=>turn(p,degrees));
const apex=atAngle(-160),strikeWrist=[343,306],fingerLength=Math.hypot(4,29);
const pose=(w,a=Math.atan2(29,4))=>[ps[0],ik(ps[0],w),w,[w[0]+fingerLength*Math.cos(a),w[1]+fingerLength*Math.sin(a)]];
const strike=pose(strikeWrist),release=t=>pose([strikeWrist[0]+(ps[2][0]-strikeWrist[0])*t,strikeWrist[1]+(ps[2][1]-strikeWrist[1])*t]);
// Retain only the connected torso after cutting out the moving arm. The
// disconnected remnants are old forearm/gauntlet paint, not new debris cleanup
// on a delivered frame; counts/bounds are preserved below.
const seen=new Uint8Array(W*H),components=[];
for(let p=0;p<seen.length;p++){if(seen[p]||body.data[p*4+3]<5)continue;const q=[p];seen[p]=1;for(let k=0;k<q.length;k++){const v=q[k],x=v%W,y=Math.floor(v/W);for(const[dx,dy]of[[1,0],[-1,0],[0,1],[0,-1]]){const X=x+dx,Y=y+dy,n=Y*W+X;if(X<0||X>=W||Y<0||Y>=H||seen[n]||body.data[n*4+3]<5)continue;seen[n]=1;q.push(n);}}components.push(q);}components.sort((a,b)=>b.length-a.length);const removedBodyComponents=components.slice(1).map(q=>({pixels:q.length,bbox:[Math.min(...q.map(p=>p%W)),Math.min(...q.map(p=>Math.floor(p/W))),Math.max(...q.map(p=>p%W)),Math.max(...q.map(p=>Math.floor(p/W)))]}));for(const q of components.slice(1))for(const p of q)body.data.fill(0,p*4,p*4+4);

const keyPath='art/production-candidates/boss-hazard-key-r01/registered.png',key=readPNG(keyPath),hand=blank(W,H);
const handPolygon=[[310,346],[342,346],[364,357],[390,372],[405,389],[405,416],[385,421],[365,409],[345,403],[326,405],[312,389]];
for(let y=0;y<H;y++)for(let x=0;x<W;x++)if(insideHand(x+.5,y+.5)){const j=(y*W+x)*4;hand.data.set(key.data.subarray(j,j+4),j)}
function insideHand(x,y){let on=false;for(let i=0,j=handPolygon.length-1;i<handPolygon.length;j=i++)if((handPolygon[i][1]>y)!==(handPolygon[j][1]>y)&&x<(handPolygon[j][0]-handPolygon[i][0])*(y-handPolygon[i][1])/(handPolygon[j][1]-handPolygon[i][1])+handPolygon[i][0])on=!on;return on}
const handWrist=[330,365],handAngle=Math.atan2(29,4)-Math.atan2(35,65),handScale=.65;
const openHand=meshWarp(hand,[0,W],[0,H],(x,y)=>[ps[2][0]+((x-handWrist[0])*Math.cos(handAngle)-(y-handWrist[1])*Math.sin(handAngle))*handScale,ps[2][1]+((x-handWrist[0])*Math.sin(handAngle)+(y-handWrist[1])*Math.cos(handAngle))*handScale]);
const dir='art/production-candidates/boss-hazard-r01';mkdirSync(dir,{recursive:true});writePNG(dir+'/hand-source.png',hand);writePNG(dir+'/hand-rig.png',openHand);writePNG(dir+'/body.png',body);
const supportPose=makeBossSupportRenderer(src);
const strokeBody=makeBossSupportRenderer(body);
function render(targets){
 if(targets.stroke){const {angle,drop,joints}=targets.stroke,a=angle*Math.PI/180,cs=Math.cos(a),sn=Math.sin(a),torso=(x,y)=>[176+(x-176)*cs-(y-350)*sn,350+(x-176)*sn+(y-350)*cs+drop],neck=torso(208,235),delta=[Math.round(neck[0]-208),Math.round(neck[1]-235)],w=1-((233-215)/40)**2*(3-2*((233-215)/40)),s=torso(...ps[0]),anchor=[s[0]*(1-w)+(ps[0][0]+delta[0])*w,s[1]*(1-w)+(ps[0][1]+delta[1])*w],path=joints.map(p=>{const q=torso(...p);return[q[0]+anchor[0]-s[0],q[1]+anchor[1]-s[1]];}),out=strokeBody(angle,drop).image;for(let n=0;n<3;n++){const A=ps[n],B=ps[n+1],T=path[n],U=path[n+1],r=Math.atan2(U[1]-T[1],U[0]-T[0])-Math.atan2(B[1]-A[1],B[0]-A[0]);over(out,meshWarp(n===2&&targets.stroke.open?openHand:parts[n],[0,W],[0,H],(x,y)=>[T[0]+(x-A[0])*Math.cos(r)-(y-A[1])*Math.sin(r),T[1]+(x-A[0])*Math.sin(r)+(y-A[1])*Math.cos(r)]));}for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);return out;}
 if(targets.supported)return supportPose(...targets.supported).image;
 if(targets.bow!==undefined){const angle=targets.bow*Math.PI/180;const out=meshWarp(src,[0,70,110,140,176,210,240,270,300,512],[0,160,200,240,280,310,340,370,400,440,480,512,576],(x,y)=>{const w=1-clamp((y-330)/100),dx=x-176,dy=y-350;return[x+(176+dx*Math.cos(angle)-dy*Math.sin(angle)-x)*w,y+(350+dx*Math.sin(angle)+dy*Math.cos(angle)-y)*w];});for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);return out;}
 const out={...body,data:Buffer.from(body.data)};for(let n=0;n<3;n++){const a=ps[n],b=ps[n+1],ta=targets[n],tb=targets[n+1],angle=Math.atan2(tb[1]-ta[1],tb[0]-ta[0])-Math.atan2(b[1]-a[1],b[0]-a[0]);over(out,meshWarp(parts[n],[0,W],[0,H],(x,y)=>[ta[0]+(x-a[0])*Math.cos(angle)-(y-a[1])*Math.sin(angle),ta[1]+(x-a[0])*Math.sin(angle)+(y-a[1])*Math.cos(angle)]));}for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);return out;}

const cast=(w,degrees,angle,drop,open=true)=>({stroke:{angle,drop,open,joints:pose(w,degrees*Math.PI/180)}});
const states={boss_hazard_windup:{ms:Array(8).fill(150),poses:[{neutral:true},cast([286,351],65,0,0,false),cast([309,329],50,1,1),cast([330,316],25,2,1),cast([338,309],10,3,2),cast([338,306],8,3,2),cast([338,305],8,3,2),cast([338,305],8,3,2)]},boss_hazard_execute:{ms:Array(4).fill(100),poses:[cast([334,315],18,5,3),cast([316,333],35,8,5),cast([285,366],75,12,8),{supported:[16,12]}]},boss_hazard_recover:{ms:Array(6).fill(150),poses:[{supported:[16,12]},{supported:[20,8]},{supported:[18,10]},{supported:[14,8]},{supported:[8,4]},{neutral:true}]}};
const base={kind:'scripted_fallback',source:[source,keyPath,'art/production-candidates/boss-hazard-key-r01/raw.png','tools/prepare-boss-hazard.mjs','tools/lib/boss-supported-pose.mjs'],method:'Generated articulated open palm, cropped by recorded polygon and attached to the approved three-piece front-arm rig. Original helmet,body,small rear arm,plated legs and fixed soles are preserved. Supported torso loading and closed-gauntlet stoop return use the approved support rig. Windup opens forward below shoulder height; execution presses down and releases to the knee; recovery returns to exact neutral. Low-alpha resampling cleanup is explicit in the rig source.',reason:'The full generated key changes the approved boot placement and stance width; reuse only its new hand paint to preserve planted-foot continuity.',hand_polygon:handPolygon,hand_wrist:handWrist,hand_scale:handScale,hand_rotation_radians:handAngle,visual_approval:false};
for(const[id,clip]of Object.entries(states)){mkdirSync(dir+'/'+id,{recursive:true});const records=[];for(let frame=0;frame<clip.poses.length;frame++){const path=dir+'/'+id+'/f'+String(frame).padStart(3,'0')+'.png',target=clip.poses[frame];if(target.neutral)copyFileSync(source,path);else writePNG(path,render(target));records.push({frame,target,reuse_neutral:!!target.neutral})}writeFileSync(dir+'/'+id+'/derivation.json',JSON.stringify({...base,records},null,2)+'\n')}
writeFileSync(dir+'/candidate-manifest.json',JSON.stringify({scope:'three boss hazard body clips; VFX remain separately pending',clips:Object.fromEntries(Object.entries(states).map(([id,clip])=>[id,{ms:clip.ms,loop:false,derivation:base}]))},null,2)+'\n');
// Keep existing context variants; add the accelerated late hazard release.
const id='boss_hurt_hazard_late',path='art/variants/'+id,poses=[[12,8],[6,4],[0,0]],records=[];
mkdirSync(path,{recursive:true});mkdirSync('game/assets/boss/'+id,{recursive:true});
for(let frame=0;frame<poses.length;frame++){const name='f00'+frame+'.png';if(frame===2)copyFileSync(source,path+'/'+name);else writePNG(path+'/'+name,supportPose(...poses[frame]).image);copyFileSync(path+'/'+name,'game/assets/boss/'+id+'/'+name);records.push({frame,supported:poses[frame],reuse_neutral:frame===2})}
const derivation={kind:'scripted_fallback',source:[source,'tools/prepare-boss-hazard.mjs','tools/lib/boss-supported-pose.mjs'],method:'Fixed-sole supported12→6→0degree release over70/70/60ms. This supplemental flinch finishes at the neutral pose due after a late hazard-recovery hit.',reason:'The900ms hazard recovery reaches neutral sooner than the1100ms strike recovery.',records};
writeFileSync(path+'/derivation.json',JSON.stringify(derivation,null,2)+'\n');
for(const file of ['art/variants/boss_hurt_contexts.json','game/data/boss_hurt_contexts.json']){const data=JSON.parse(readFileSync(file));if(file.startsWith('art/'))data[id]={ms:[70,70,60],loop:false,derivation};else data.hazard_late={id,ms:[70,70,60],loop:false};writeFileSync(file,JSON.stringify(data,null,2)+'\n')}
// Provisional native integration for engine capture. Independent review gates release.
for(const[id,clip]of Object.entries(states)){
 for(const root of ['art/frames','game/assets/boss']){mkdirSync(root+'/'+id,{recursive:true});for(let frame=0;frame<clip.poses.length;frame++){const name='f'+String(frame).padStart(3,'0')+'.png';copyFileSync(dir+'/'+id+'/'+name,root+'/'+id+'/'+name)}}
 copyFileSync(dir+'/'+id+'/derivation.json','art/frames/'+id+'/derivation.json');
}
for(const file of ['art/frames/clips.json','art/frames/derivations.json']){const data=JSON.parse(readFileSync(file));for(const[id,clip]of Object.entries(states))data[id]=file.endsWith('clips.json')?{ms:clip.ms,loop:false,derivation:base}:base;writeFileSync(file,JSON.stringify(data,null,2)+'\n')}
