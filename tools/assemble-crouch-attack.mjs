#!/usr/bin/env node
// Distinct painted low attack, with a registered adaptation of the approved whip fallback.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {palette,spline,stroke} from './lib/leather-whip.mjs';
import {readFileSync,writeFileSync,mkdirSync,existsSync,cpSync} from 'node:fs';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const names=['rest','windup','strike','apex','follow','return','settle','rest'];
const paths=names.map(n=>'art/production-candidates/hero_crouch-attack-'+n+'-key-r01.png');
const sockets=[[228,403],[222,323],[337,355],[337,358],[273,386],[273,390],[236,401],[228,403]];
const ends=[[211,418],[202,321],[362,355],[362,359],[290,404],[259,398],[220,418],[211,418]];
const body='hero_attack_crouch',weapon='whip_attack_crouch';
for(const id of [body,weapon]){
 const root='art/frames/'+id;
 if(existsSync(root)){const archive=`art/rejected/crouch-${Date.now()}-${id}`;mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
 mkdirSync(root,{recursive:true});
}
for(let i=0;i<8;i++){
 const im=readPNG(paths[i]);
 for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);
 writePNG(`art/frames/${body}/f00${i}.png`,im);
}
const neutral=readPNG('art/frames/style_hero_neutral/f000.png');
const strike=readPNG('art/production-candidates/hero_same-arm-strike-key.png');
const leather=palette(neutral,220,345,249,379),wood=palette(strike,334,273,346,281);
for(let i=0;i<8;i++){
 const im=blank(768,512),s=sockets[i],e=ends[i],length=Math.hypot(e[0]-s[0],e[1]-s[1]),unit=[(e[0]-s[0])/length,(e[1]-s[1])/length];
 stroke(im,[[s[0]-6*unit[0],s[1]-6*unit[1]],e],5.5,4.5,wood);
 let points;
 if(i===0||i===7)points=[e,[201,422],[196,435],[211,443],[227,437],[229,424],[214,418],[207,430],[216,437],[222,427]];
 else if(i===1)points=[e,[e[0]-22,e[1]-26],[e[0]-75,e[1]-48],[e[0]-125,e[1]-34]];
 else if(i===2)points=[e,[410,347],[472,370],[540,389],[600,380]];
 else if(i===3)points=[e,[416,352],[483,375],[550,393],[610,380]];
 else if(i===4)points=[e,[375,434],[455,431],[479,404],[467,376],[427,375],[392,398],[412,421],[447,415]];
 else if(i===5)points=[e,[279,437],[349,435],[392,411],[379,384],[345,386],[317,414],[341,431],[366,411],[351,396]];
 else points=[e,[211,430],[217,445],[238,443],[254,429],[249,414],[232,415],[225,432],[237,440],[247,427],[238,419]];
 stroke(im,spline(points),i===0||i===7?3.8:4.2,1.3,leather);
 writePNG(`art/frames/${weapon}/f00${i}.png`,im);
}
const metadata=JSON.parse(readFileSync('art/frames/clips.json')),derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
const bodyDerivation={kind:'reused',source:paths,method:'Seven directly painted crouched body poses; ready pose reused at final settle. Each key is normalized once from its original delivery with bounded uniform scale; alpha<=4 cleanup only.',reason:'Replace the held crouch preview with same-arm wind-up, extension, follow-through and recovery without standing up.'};
const weaponDerivation={kind:'scripted_fallback',source:['art/frames/whip_attack_ground','art/frames/style_hero_neutral/f000.png','art/production-candidates/hero_same-arm-strike-key.png'],method:'Adapt the approved ground raster fallback to the low fist sockets and hitbox. Thin tapered leather and wood colors come from approved paint; recovery folds gather into a compact coil above the floor. Shared shader/review hand occlusion preserves the painted glove.',reason:'The original weapon generation failed socket/thickness checks (art/rejected/whip-ground-key-r01). Reuse its independently approved scripted replacement method under ART_CONTRACT section11, with a new independent low-attack motion review.'};
for(const[id,d]of[[body,bodyDerivation],[weapon,weaponDerivation]]){metadata[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d};derivations[id]=d;}
writeFileSync('art/frames/clips.json',JSON.stringify(metadata,null,2));
writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2));
for(const[file,values]of[['hand_sockets.json',sockets],['hand_occlusion.json',sockets.map(()=>8)]]){
 const path='art/frames/'+file,record=JSON.parse(readFileSync(path));record[body]=values;writeFileSync(path,JSON.stringify(record,null,2));
}
