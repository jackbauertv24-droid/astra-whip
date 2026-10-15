#!/usr/bin/env node
// Airborne attack bodies and a separately registered leather whip.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {palette,spline,stroke,coil} from './lib/leather-whip.mjs';
import {readFileSync,writeFileSync,mkdirSync,existsSync,cpSync} from 'node:fs';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const names=['rest','windup','strike','apex','follow','return','settle','rest'];
const paths=names.map(n=>'art/production-candidates/hero_air-attack-'+n+'-key-'+(['strike','apex','follow'].includes(n)?'r02':'r01')+'.png');
const sockets=[[234,335],[207,262],[323,283],[323,285],[271,324],[270,325],[236,334],[234,335]];
const ends=[[219,348],[182,263],[344,284],[344,285],[282,332],[283,320],[217,341],[219,348]];
const body='hero_attack_air',weapon='whip_attack_air';
for(const id of [body,weapon]){
 const root='art/frames/'+id;
 if(existsSync(root)){const archive=`art/rejected/air-${Date.now()}-${id}`;mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
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
 if(i===0||i===7)points=coil(e);
 else if(i===1)points=[e,[e[0]-22,e[1]-26],[e[0]-75,e[1]-48],[e[0]-125,e[1]-34]];
 else if(i===2)points=[e,[420,279],[484,306],[543,329],[600,320]];
 else if(i===3)points=[e,[422,282],[490,310],[551,334],[610,320]];
 else if(i===4)points=[e,[350,392],[420,399],[468,372],[456,338],[416,331],[382,356],[400,380],[438,378]];
 else if(i===5)points=[e,[310,318],[355,343],[375,372],[350,394],[311,385],[308,358],[335,345],[354,365],[336,380],[325,363]];
 else points=[e,[211,366],[213,385],[233,400],[259,390],[268,370],[255,354],[234,357],[226,379],[241,392],[257,379],[258,365],[243,358]];
 stroke(im,spline(points),i===0||i===7?3.8:4.2,1.3,leather);
 writePNG(`art/frames/${weapon}/f00${i}.png`,im);
}
const metadata=JSON.parse(readFileSync('art/frames/clips.json')),derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
const bodyDerivation={kind:'reused',source:paths,method:'Seven directly painted airborne poses, with the ready key reused at the final settle. Same near weapon arm, tucked/adjusting legs and trailing coat. One bounded uniform normalization from each original delivery; alpha<=4 cleanup only.',reason:'Replace the held jump-pose preview with a distinct complete airborne attack. Initial arm-switch candidates are retained in art/rejected/air-attack-arm-r01; corrected strike/follow use the approved same-arm ground keys as edit targets.'};
const weaponDerivation={kind:'scripted_fallback',source:['art/frames/whip_attack_ground','art/frames/style_hero_neutral/f000.png','art/production-candidates/hero_same-arm-strike-key.png'],method:'Adapt the approved ground leather/wood raster fallback to airborne fist sockets and the standing-height active hitbox. Tapered flexible lash gathers in ordered recovery loops; shared runtime/review glove occlusion.',reason:'Original weapon generation failed socket/thickness checks (art/rejected/whip-ground-key-r01). Reuse its independently approved scripted replacement method under ART_CONTRACT section11, with a fresh independent air-attack review.'};
for(const[id,d]of[[body,bodyDerivation],[weapon,weaponDerivation]]){metadata[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation:d};derivations[id]=d;}
writeFileSync('art/frames/clips.json',JSON.stringify(metadata,null,2));
writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2));
for(const[file,values]of[['hand_sockets.json',sockets],['hand_occlusion.json',sockets.map(()=>8)]]){
 const path='art/frames/'+file,record=JSON.parse(readFileSync(path));record[body]=values;writeFileSync(path,JSON.stringify(record,null,2));
}
