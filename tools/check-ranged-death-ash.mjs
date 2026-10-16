#!/usr/bin/env node
// Scoped opacity tripwire for the retained faint-pile failure; visual review still required.
import{readPNG}from'./lib/png.mjs';
const path=process.argv[2]??'art/frames/ranged_death/f005.png',img=readPNG(path);
let opaqueGroundAsh=0;
for(let y=280;y<=320;y++)for(let x=60;x<210;x++)if(img.data[(y*img.width+x)*4+3]>=220)opaqueGroundAsh++;
// Require a useful core of opaque ash rather than relying solely on low-alpha blur.
// 500 source pixels is a small subset of the intended pile's footprint; not a visibility approval.
console.log(`RANGED DEATH ASH: ${opaqueGroundAsh} opaque ground-region pixels (minimum500); ${path}`);
process.exitCode=opaqueGroundAsh<500?1:0;
