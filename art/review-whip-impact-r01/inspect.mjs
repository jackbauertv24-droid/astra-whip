import {readFileSync,writeFileSync} from 'node:fs';
import {decodePNG,encodePNG,blank} from '../../tools/lib/png.mjs';
import {paste,text} from '../../tools/lib/draw.mjs';
const out='art/review-whip-impact-r01';let inventory=[];
for(const res of ['native','phone']){const dir=`evidence/whip-impact-r01-${res}`,d=JSON.parse(readFileSync(`${dir}/capture.json`));for(let ri=0;ri<d.records.length;ri++){const r=d.records[ri],sheet=blank(1000,Math.ceil(r.samples.length/4)*240,[30,30,35,255]);let pt=r.samples.find(s=>s.effect_frame===0).effect_image_point;for(let i=0;i<r.samples.length;i++){const s=r.samples[i],p=`${dir}/${s.file}`,im=decodePNG(readFileSync(p));const x=(i%4)*250,y=Math.floor(i/4)*240;paste(sheet,im,x,y+30,{sx:Math.round(pt[0])-110,sy:Math.round(pt[1])-105,w:220,h:200});text(sheet,x+2,y+2,`${i} ${s.file.replace('.png','')}`,undefined,1);inventory.push(p);}writeFileSync(`${out}/${res}-${ri}.png`,encodePNG(sheet));}}
writeFileSync(`${out}/inspection_inventory.json`,JSON.stringify(inventory,null,2));console.log(inventory.length);
