#!/usr/bin/env node
import{cpSync,readFileSync,writeFileSync,mkdirSync,existsSync}from'node:fs';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
for(const id of['pursuer_lunge_windup','pursuer_lunge','pursuer_recovery']){
 const root='art/frames/'+id,source='art/production-candidates/pursuer-lunge-r02/'+id;
 if(existsSync(root)){const archive='art/rejected/pursuer-lunge-'+Date.now();mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
 mkdirSync(root,{recursive:true});for(let i=0;i<c.clips[id].ms.length;i++)cpSync(`${source}/f00${i}.png`,`${root}/f00${i}.png`);
 const d={kind:'scripted_fallback',source:['art/review-pursuer-keys-r01/f000.png','tools/prepare-pursuer-lunge.mjs',source+'/rig.json'],method:'Same approved painted bone parts and articulated cutout technique as locomotion/alert. Windup compresses through hips and independent knees/elbows; lunge extends low with alternating forepaw supports compensating41.6source px per80ms at260u/s, including the final catch into recovery; recovery replants and rises into the approved approach entry. No whole-body scale. Alpha<=4 cleanup only.',reason:'Continue the actor D23 fallback after direct generated keys failed gait continuity and alert density/pose constraints; retain those failures. Every new action receives a fresh independent motion and actual-AI travel review; disclose scripted quality debt.'};
 for(const file of['clips.json','derivations.json']){const path='art/frames/'+file,all=JSON.parse(readFileSync(path));all[id]=file==='clips.json'?{ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d}:d;writeFileSync(path,JSON.stringify(all,null,2));}
 mkdirSync('game/assets/pursuer/'+id,{recursive:true});cpSync(root,'game/assets/pursuer/'+id,{recursive:true});
}
