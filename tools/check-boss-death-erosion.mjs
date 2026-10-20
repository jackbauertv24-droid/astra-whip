#!/usr/bin/env node
// Tripwire for newly punched holes deep inside an otherwise solid plate.
// Edge-led erosion may retreat around existing silhouette/cloth openings.
import{readPNG}from'./lib/png.mjs';
import{writeFileSync}from'node:fs';
const args=process.argv.slice(2),opt=name=>args[args.indexOf(name)+1],root=args.includes('--frames')?opt('--frames'):'art/production-candidates/boss-death-r04',out=args.includes('--out')?opt('--out'):'evidence/boss-death-erosion.json';
const source=readPNG(root+'/f008.png'),fade=readPNG(root+'/f009.png'),radius=15;
let solidInterior=0,punchedInterior=0;const examples=[];
for(let y=radius;y<Math.min(475,source.height-radius);y++)for(let x=radius;x<source.width-radius;x++){
 const p=(y*source.width+x)*4;if(source.data[p+3]<220)continue;let solid=true;
 outer:for(let dy=-radius;dy<=radius;dy++)for(let dx=-radius;dx<=radius;dx++)if(source.data[((y+dy)*source.width+x+dx)*4+3]<220){solid=false;break outer}
 if(!solid)continue;solidInterior++;
 if(fade.data[p+3]<source.data[p+3]*.6){punchedInterior++;if(examples.length<12)examples.push([x,y])}
}
const result={frames_root:root,solid_interior_samples:solidInterior,punched_interior_pixels:punchedInterior,examples,pass:solidInterior>=100&&punchedInterior===0,scope:'Deep opaque31×31 source neighborhoods above ground; an edge-erosion tripwire, not visual approval.'};writeFileSync(out,JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));if(!result.pass)process.exit(1);
