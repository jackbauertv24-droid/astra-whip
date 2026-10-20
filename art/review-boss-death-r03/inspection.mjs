import {readPNG,writePNG} from '../../tools/lib/png.mjs';
import {canvas,paste,text} from '../../tools/lib/draw.mjs';
import {readFileSync,mkdirSync} from 'node:fs';
const out='art/review-boss-death-r03/inspection';mkdirSync(out,{recursive:true});
for(const res of ['native','phone']){const dir=`evidence/boss-death-r03-${res}`;const j=JSON.parse(readFileSync(dir+'/capture.json'));for(let g=0;g<j.records.length;g++){let ss=j.records[g].samples;for(let k=0;k<ss.length;k+=4){let ims=ss.slice(k,k+4).map(s=>readPNG(dir+'/'+s.file));let sh=canvas(ims[0].width,ims.reduce((n,i)=>n+i.height+22,0));let y=0;ims.forEach((im,l)=>{text(sh,4,y+3,ss[k+l].file);paste(sh,im,0,y+22);y+=im.height+22});writePNG(`${out}/${res}-${g}-${k/4}.png`,sh)}}}
