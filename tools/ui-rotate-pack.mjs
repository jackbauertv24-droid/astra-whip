#!/usr/bin/env node
import fs from 'node:fs';
import {readPNG,writePNG} from './lib/png.mjs';
import {canvas,paste,text} from './lib/draw.mjs';
const args=process.argv.slice(2),opt=n=>{const i=args.indexOf(n);return i<0?undefined:args[i+1]};
const root=opt('--frames')||'art/production-candidates/ui-rotate-r01',out=opt('--out')||'art/review-ui-rotate-r01',ids=['ui_rotate_prompt'],findings=[],images={};
fs.mkdirSync(out+'/frames',{recursive:true});
const line=canvas(224,172,[55,55,60,255]);
for(const [index,id] of ids.entries()){
 const im=images[id]=readPNG(root+'/'+id+'/f000.png');
 fs.mkdirSync(out+'/frames/'+id,{recursive:true});
 for(const name of ['f000.png','f000.png.provenance.json','derivation.json'])fs.copyFileSync(root+'/'+id+'/'+name,out+'/frames/'+id+'/'+name);
 if(im.width!==192||im.height!==128)findings.push({rule:'UI-CANVAS',severity:'DEFECT',id});
 let clear=0,border=0,ink=0;
 for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++){
  const a=im.data[(y*im.width+x)*4+3];if(a===0)clear++;if(a>40)ink++;
  if((x<2||y<2||x>=im.width-2||y>=im.height-2)&&a>8)border++;
 }
 if(clear<im.width*im.height*.1)findings.push({rule:'UI-ALPHA',severity:'DEFECT',id});
 if(ink<100)findings.push({rule:'UI-EMPTY',severity:'DEFECT',id});
 if(border)findings.push({rule:'UI-BORDER',severity:'DEFECT',id});
 const strip=canvas(224,172,[65,65,70,255]);text(strip,4,5,id,[240,240,240,255]);paste(strip,im,16,28);writePNG(out+'/strip_'+id+'.png',strip);paste(line,strip,index*224,0);
}
const audit={defects:findings.length,flags:0,findings,visual_approval:false};
writePNG(out+'/lineup_ui_rotate.png',line);
fs.writeFileSync(out+'/audit.json',JSON.stringify(audit,null,2)+'\n');
fs.writeFileSync(out+'/audit.md',`# Static rotate UI audit\n\n${audit.defects}DEFECT,0FLAG\n\n${JSON.stringify(findings)}\n`);
fs.writeFileSync(out+'/scope.json',JSON.stringify({assets:ids,canvas:[192,128],frames_each:1,ui_space:true,render_css:{maximum:[96,64],short_content_uniform_shrink:true},original_animation_contract:'unchanged',style_lock:'art/style-lock.json',engine_captures:'evidence/ui-rotate-captures/capture.json',visual_approval:false},null,2)+'\n');
fs.writeFileSync(out+'/index.md','# Rotate UI review\n\nBlind first: lineup and strip; save/read notes before metadata. Inspect raw source, all5style references and all supplied actual engine/browser images.192x128static UI-space graphic shown at up to96x64CSS; short content uniformly shrinks it. All wording live,20CSS minimum, centered separately; no overlap with graphic or pause. Portrait automatically pauses/hides gameplay; landscape hides graphic and requires explicit resume. No actor/VFX animation, traversal or physical-device approval. Original animation contract unchanged.\n');
fs.writeFileSync(out+'/review_contract.json',JSON.stringify({scope:'one static portrait rotate graphic',requirements:['transparent safe margins','portrait-to-landscape device orientation reads at actual size','live20CSS wording','no graphic/text/pause overlap','portrait-only visibility and landscape resume']},null,2)+'\n');
console.log(audit);if(audit.defects)process.exit(1);
