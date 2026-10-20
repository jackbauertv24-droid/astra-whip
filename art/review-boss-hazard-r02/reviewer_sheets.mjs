import {readFileSync} from 'node:fs';
import {readPNG,writePNG} from '../../tools/lib/png.mjs';
import {canvas,paste,text} from '../../tools/lib/draw.mjs';
for(const mode of ['native','phone']){const dir='evidence/boss-hazard-r02-'+mode; const cap=JSON.parse(readFileSync(dir+'/capture.json'));for(let ri=0;ri<cap.records.length;ri++){const rec=cap.records[ri];for(let n=0;n<rec.samples.length;n+=6){const ss=rec.samples.slice(n,n+6);const a=readPNG(dir+'/'+ss[0].file);const out=canvas(a.width*2,(a.height+24)*Math.ceil(ss.length/2));ss.forEach((s,k)=>{const x=k%2*a.width,y=Math.floor(k/2)*(a.height+24);text(out,s.file,x+3,y+4);paste(out,readPNG(dir+'/'+s.file),x,y+24);});writePNG('art/review-boss-hazard-r02/reviewer_'+mode+'_'+ri+'_'+n+'.png',out);}}}
