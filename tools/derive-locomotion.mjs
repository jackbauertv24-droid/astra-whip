#!/usr/bin/env node
// Reproduce the visually rejected first rig attempt; never writes production art.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {meshWarp,heroGrid,clamp,registerFoot} from './lib/deform.mjs';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
const source='art/frames/style_hero_neutral/f000.png',src=readPNG(source);
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const outputRoot='art/rejected/locomotion-reproduction';
const meta={},derivations={};
const layer=(predicate)=>{const out=blank(512,512);for(let y=0;y<512;y++)for(let x=0;x<512;x++)if(predicate(x,y))out.data.set(src.data.subarray((y*512+x)*4,(y*512+x)*4+4),(y*512+x)*4);return out;};
const left=(x,y)=>y>=394&&x>=213&&x<247;
const right=(x,y)=>y>=394&&x>=247&&x<302;
const legs=[layer(left),layer(right)],torso=layer((x,y)=>!left(x,y)&&!right(x,y));

function over(dst,im) {
  for(let i=0;i<dst.data.length;i+=4){const a=im.data[i+3]/255,b=dst.data[i+3]/255,aa=a+b*(1-a);if(!a)continue;for(let k=0;k<3;k++)dst.data[i+k]=Math.round((im.data[i+k]*a+dst.data[i+k]*b*(1-a))/aa);dst.data[i+3]=Math.round(aa*255);}
}
function rigid(im,ox,oy,angle,dx,dy) {
  const cos=Math.cos(angle),sin=Math.sin(angle);
  return meshWarp(im,[0,213,247,302,512],[0,394,448,512],(x,y)=>[ox+(x-ox)*cos-(y-oy)*sin+dx,oy+(x-ox)*sin+(y-oy)*cos+dy]);
}
function walk(phase,amount=1) {
  const out=blank(512,512),s=Math.sin(phase),bodyDip=2*(1-Math.cos(phase*2))*amount;
  // Boots swing in opposing phases below the coat; the coat covers knee joins.
  for(const k of [1,0]){
    const step=(k? -s:s)*amount,angle=-step*.4;
    over(out,rigid(legs[k],k?269:230,394,angle,step*10,bodyDip-Math.max(0,-step)*4));
  }
  const body=meshWarp(torso,heroGrid.xs,heroGrid.ys,(x,y)=>{
    const arm=clamp((y-280)/55)*(1-clamp((y-342)/12));
    const outside=clamp((Math.abs(x-256)-20)/20);
    const coat=clamp((y-345)/55);
    return [x+s*amount*(arm*outside*2+coat*3),y+bodyDip];
  });over(out,body);return registerFoot(out);
}
function emit(id,images,method) {
  mkdirSync(outputRoot+'/'+id,{recursive:true});images.forEach((im,i)=>writePNG(`${outputRoot}/${id}/f${String(i).padStart(3,'0')}.png`,im));
  const derivation={kind:'scripted_fallback',source,method,reason:'Generated clip sheet failed the scale/identity delivery contract. Retained evidence: art/rejected/idle-sheet-r01/audit/audit.md. These articulated candidates require independent motion review.'};
  meta[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation};derivations[id]=derivation;
}
emit('hero_walk',Array.from({length:10},(_,i)=>walk(i*Math.PI*2/10)),'Opposed boot swings beneath the painted coat, body weight dip, arm counter-motion and trailing cloth. Painted layers retain their dimensions.');
emit('hero_start_move',[walk(0,0),walk(.3,.5),walk(.6,1)],'Three-frame acceleration into first stride; shares the approved neutral layers.');
emit('hero_stop_move',[walk(.6,1),walk(.3,.5),walk(0,0)],'Reversed acceleration pose settles to neutral.');
emit('hero_turn',[-1,0,1].map(a=>registerFoot(meshWarp(src,heroGrid.xs,heroGrid.ys,(x,y)=>[x+a*clamp((448-y)/150)*3,y]))),'Shoulder and weight transition around planted boots; state-machine facing flip supplies direction change.');
writeFileSync(outputRoot+'/clips.json',JSON.stringify(meta,null,2)+'\n');writeFileSync(outputRoot+'/derivations.json',JSON.stringify(derivations,null,2)+'\n');
