#!/usr/bin/env node
import {readPNG} from './lib/png.mjs';
import {readFileSync,writeFileSync} from 'node:fs';
const args=process.argv.slice(2),opt=name=>{const i=args.indexOf(name);return i<0?undefined:args[i+1]},beforeRoot=opt('--before')||'evidence/atlas-before',afterRoot=opt('--after')||'evidence/atlas-after',out=opt('--out')||'evidence/atlas-render-comparison.json';
const before=JSON.parse(readFileSync(beforeRoot+'/index.json')),after=JSON.parse(readFileSync(afterRoot+'/index.json'));
if(JSON.stringify(before)!==JSON.stringify(after))throw Error('capture inventories differ');
let changed=0,maxDifference=0;const pages=[];
for(const entry of before.pages){
 const a=readPNG(beforeRoot+'/'+entry.file),b=readPNG(afterRoot+'/'+entry.file);let pixels=0,maximum=0;
 if(a.width!==b.width||a.height!==b.height)throw Error('canvas differs');
 for(let i=0;i<a.data.length;i+=4){let difference=0;for(let c=0;c<4;c++)difference=Math.max(difference,Math.abs(a.data[i+c]-b.data[i+c]));if(difference)pixels++;maximum=Math.max(maximum,difference)}
 changed+=pixels;maxDifference=Math.max(maxDifference,maximum);pages.push({file:entry.file,changed_pixels:pixels,maximum_difference:maximum});
}
const result={samples:before.samples,pages:pages.length,changed_pixels:changed,maximum_difference:maxDifference,exact:changed===0,tolerance:"At most one pixel, at most one 8-bit channel value across the complete fixture; raw RGBA roundtrip remains exact",pass:changed<=1&&maxDifference<=1,visual_approval:false,details:pages};
writeFileSync(out,JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify({...result,details:undefined}));if(!result.pass)process.exit(1);
