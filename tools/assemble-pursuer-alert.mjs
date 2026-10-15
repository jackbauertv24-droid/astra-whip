#!/usr/bin/env node
import{cpSync,readFileSync,writeFileSync,mkdirSync,existsSync}from'node:fs';
const id='pursuer_alert',root='art/frames/'+id,source='art/production-candidates/pursuer-alert-fallback-r03';
if(existsSync(root)){const archive='art/rejected/pursuer-alert-'+Date.now();mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
mkdirSync(root,{recursive:true});for(let i=0;i<4;i++)cpSync(`${source}/f00${i}.png`,`${root}/f00${i}.png`);
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const d={kind:'scripted_fallback',source:['art/review-pursuer-keys-r01/f000.png','tools/prepare-pursuer-alert.mjs',source+'/rig.json'],method:'Same approved painted bone parts as locomotion. Torso rears around hips up to18degrees; four independent joint chains lift forepaws and place the far hind support while the near hindpaw stays fixed. Return pose equals approved approach entry. No whole-body scaling or translation. Alpha<=4 cleanup only.',reason:'Two generated intermediate entries exceeded G-03 normalization limits, with raw images and failures retained. D23 articulated fallback from independently approved static source; full new action/phone review required and quality debt disclosed.'};
for(const file of['clips.json','derivations.json']){const path='art/frames/'+file,all=JSON.parse(readFileSync(path));all[id]=file==='clips.json'?{ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d}:d;writeFileSync(path,JSON.stringify(all,null,2));}
mkdirSync('game/assets/pursuer/'+id,{recursive:true});cpSync(root,'game/assets/pursuer/'+id,{recursive:true});
