#!/usr/bin/env node
// Disclosed D23 articulated fallback, reused with travel-matched cadence.
import{readPNG,writePNG}from'./lib/png.mjs';
import{readFileSync,writeFileSync,mkdirSync,existsSync,cpSync}from'node:fs';
const paths=Array.from({length:8},(_,i)=>`art/production-candidates/pursuer-gait-rig-r02/f00${i}.png`);
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const meta=JSON.parse(readFileSync('art/frames/clips.json')),derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
for(const id of ['pursuer_patrol_walk','pursuer_approach_walk']){
 const root='art/frames/'+id;
 if(existsSync(root)){const archive=`art/rejected/pursuer-walk-${Date.now()}-${id}`;mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
 mkdirSync(root,{recursive:true});
 for(let i=0;i<8;i++){
  const im=readPNG(paths[i]);for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);
  writePNG(`${root}/f00${i}.png`,im);
 }
 const d={kind:id==='pursuer_approach_walk'?'reused':'scripted_fallback',source:id==='pursuer_approach_walk'?['art/frames/pursuer_patrol_walk']:['art/review-pursuer-keys-r01/f000.png','tools/prepare-pursuer-gait.mjs','art/production-candidates/pursuer-gait-rig-r02/rig.json'],method:id==='pursuer_approach_walk'?'Reuse the articulated patrol gait. Source timings stay70ms; runtime cadence35/27 gives the same43.2u stride.':'Rigid painted bone parts rotated about connected joints from an independently approved static key. Four fixed limb identities, continuous stance and lifted forward swing; stance travels10.8source px per frame. No whole-body scaling. Isolated old toe fragments outside limb cutouts are removed from the remaining connected torso layer.',reason:'D23 fallback after generated gait failed independent motion review (art/review-pursuer-walk-r01/review_verdict.md). Static key independently accepted in art/review-pursuer-keys-r01/review_verdict.md. Full new motion review required; disclose scripted animation as quality debt.'};
 meta[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d};derivations[id]=d;
}
writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2));
writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2));
