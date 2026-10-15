#!/usr/bin/env node
// D23 fallback after generated idle endpoints failed independent review.
import{readPNG,writePNG}from'./lib/png.mjs';
import{readFileSync,writeFileSync,mkdirSync,existsSync,cpSync}from'node:fs';
const paths=Array.from({length:6},(_,i)=>`art/production-candidates/pursuer-idle-fallback-r03/f00${i}.png`);
const id='pursuer_idle',root='art/frames/'+id,c=JSON.parse(readFileSync('contract/art_contract.json'));
if(existsSync(root)){const archive='art/rejected/pursuer-idle-'+Date.now();mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
mkdirSync(root,{recursive:true});
for(let i=0;i<paths.length;i++){
 const im=readPNG(paths[i]);for(let p=0;p<im.data.length;p+=4)if(im.data[p+3]<=4)im.data.fill(0,p,p+4);
 writePNG(`${root}/f00${i}.png`,im);
}
const d={kind:'scripted_fallback',source:['art/frames/pursuer_patrol_walk/f000.png','tools/prepare-pursuer-idle.mjs','art/production-candidates/pursuer-idle-fallback-r03/derivation.json'],method:'Painted source geometry retained with local three-pixel chest/neck breathing and subpixel beard/rag follow-through. Legs and paws stay registered. No whole-body scaling, translation or rotation. Alpha<=4 cleanup only.',reason:'Generated breathing poses changed chest/forelimb volume at neutral transitions; independent r01 FAIL retained. D23 permits a reviewed scripted fallback from approved art. The coherent six-frame breathing envelope uses the fixed approved patrol entry key; disclose quality debt.'};
for(const file of['clips.json','derivations.json']){const path='art/frames/'+file,all=JSON.parse(readFileSync(path));all[id]=file==='clips.json'?{ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d}:d;writeFileSync(path,JSON.stringify(all,null,2));}
mkdirSync('game/assets/pursuer/'+id,{recursive:true});cpSync(root,'game/assets/pursuer/'+id,{recursive:true});
