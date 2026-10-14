#!/usr/bin/env node
// D23: reuse approved neutral portrait on the independently reviewed twisting body.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {mkdirSync,writeFileSync} from 'node:fs';
const bodyPath='art/review-hero-keys-r05/key_2.png',headPath='art/frames/style_hero_neutral/f000.png';
const body=readPNG(bodyPath),head=readPNG(headPath),out={...body,data:new Uint8Array(body.data)};
const top=235,dx=10;
for(let y=top;y<top+55;y++)for(let x=225;x<315;x++){const j=(y*512+x)*4,w=Math.max(0,Math.min(1,(y-top-40)/15));if(!(y>=270&&x<244))out.data[j+3]=Math.round(out.data[j+3]*w);}
for(let y=225;y<280;y++)for(let x=232;x<286;x++){const k=(y*512+x)*4,j=((y+top-225)*512+x+dx)*4,a=head.data[k+3]/255*Math.max(0,Math.min(1,(280-y)/10)),b=out.data[j+3]/255,aa=a+b*(1-a);if(!a)continue;for(let c=0;c<3;c++)out.data[j+c]=Math.round((head.data[k+c]*a+out.data[j+c]*b*(1-a))/aa);out.data[j+3]=Math.round(aa*255);}
let removed=0;for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4){if(out.data[j+3])removed++;out.data.fill(0,j,j+4);}
writePNG('art/production-candidates/hero_turn-head-reused-r04.png',out);
writeFileSync('art/production-candidates/hero_turn-head-reused-r04.derivation.json',JSON.stringify({kind:'scripted_fallback',source:[bodyPath,headPath],method:'Approved compact right-facing neutral portrait reused rigidly on approved shoulder/hip twist; feathered neck join, no body rescale',reason:'Generated turn portraits repeatedly grew outside the shared physical head-size contract',near_transparent_pixels_removed:removed},null,2));
