#!/usr/bin/env node
import{readPNG,writePNG}from'./lib/png.mjs';
import{readFileSync,writeFileSync,mkdirSync,cpSync,existsSync}from'node:fs';
const paths=['art/frames/pursuer_lunge_windup/f001.png','art/production-candidates/pursuer-death-f001-key-r02.png','art/production-candidates/pursuer-death-f002-key-r01.png','art/production-candidates/pursuer-death-corpse-clean-r01.png','art/production-candidates/pursuer-death-ash-r01/f004.png','art/production-candidates/pursuer-death-ash-r01/f005.png'];
const id='pursuer_death',root='art/frames/'+id,c=JSON.parse(readFileSync('contract/art_contract.json'));
if(existsSync(root)){const archive='art/rejected/pursuer-death-'+Date.now();mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
mkdirSync(root,{recursive:true});
for(let i=0;i<paths.length;i++){
 const im=readPNG(paths[i]);for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);
 writePNG(`${root}/f00${i}.png`,im);
}
const d={kind:'scripted_fallback',source:[...paths,'tools/prepare-pursuer-ash.mjs','art/review-pursuer-corpse-key-r01/review_verdict.md'],method:'Reuse approved compression for the lethal buckling entry, directly painted intermediate fall poses and independently accepted complete grounded corpse. Final two frames derive soft Ash Grey erosion and descending/settling flecks from that approved corpse; no whole-body scale. Generated body keys get one factor1 baseline registration. Alpha<=4 cleanup only.',reason:'Complete the one-HP lethal sequence with supported collapse and D13 ash rather than a tinted held pose. Body identity is preserved through a declared D23 scripted ash derivation from approved paint; retain derived-animation quality debt and require full independent motion review.'};
for(const file of['clips.json','derivations.json']){const path='art/frames/'+file,all=JSON.parse(readFileSync(path));all[id]=file==='clips.json'?{ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d}:d;writeFileSync(path,JSON.stringify(all,null,2));}
mkdirSync('game/assets/pursuer/'+id,{recursive:true});cpSync(root,'game/assets/pursuer/'+id,{recursive:true});
