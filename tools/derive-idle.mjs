#!/usr/bin/env node
// ART_CONTRACT §11 fallback after the generated idle sheet failed A-05/A-06.
// Small breathing deformation; feet stay planted, the head is translated rigidly.
import {readPNG, writePNG, blank} from './lib/png.mjs';
import {mkdirSync, readFileSync, writeFileSync} from 'node:fs';

const source='art/frames/style_hero_neutral/f000.png';
const src=readPNG(source);
const amplitudes=[0,.5,1.25,2,2,1.25,.5,0];
mkdirSync('art/frames/hero_idle',{recursive:true});
for (let f=0;f<amplitudes.length;f++) {
  const dst=blank(src.width,src.height), amount=amplitudes[f];
  for(let y=0;y<src.height;y++)for(let x=0;x<src.width;x++) {
    // Head and shoulders move together; displacement eases to zero at the hips.
    const weight=y<280?1:y<350?(350-y)/70:0;
    const sy=y+amount*weight, y0=Math.floor(sy), t=sy-y0;
    if(y0<0||y0+1>=src.height)continue;
    const a0=src.data[(y0*src.width+x)*4+3]/255;
    const a1=src.data[((y0+1)*src.width+x)*4+3]/255;
    const a=a0*(1-t)+a1*t, j=(y*src.width+x)*4;
    for(let k=0;k<3;k++)dst.data[j+k]=a?Math.round((src.data[(y0*src.width+x)*4+k]*a0*(1-t)+src.data[((y0+1)*src.width+x)*4+k]*a1*t)/a):0;
    dst.data[j+3]=Math.round(a*255);
  }
  writePNG(`art/frames/hero_idle/f${String(f).padStart(3,'0')}.png`,dst);
}
const contract=JSON.parse(readFileSync('contract/art_contract.json'));
const meta=JSON.parse(readFileSync('art/frames/clips.json'));
meta.hero_idle={ms:contract.clips.hero_idle.ms,loop:true,derivation:{kind:'scripted_fallback',source,method:'Planted feet; rigid head translation with a two-pixel breathing displacement easing through the chest to zero at hips.',reason:'Generated whole-clip sheet failed G-02 / A-05 / A-06. See art/rejected/idle-sheet-r01/audit/audit.md.'}};
writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2)+'\n');
writeFileSync('art/frames/derivations.json',JSON.stringify({hero_idle:meta.hero_idle.derivation},null,2)+'\n');
