#!/usr/bin/env node
import fs from 'node:fs';
import {readPNG,writePNG} from './lib/png.mjs';
import {canvas,paste,text} from './lib/draw.mjs';
const args=process.argv.slice(2),opt=n=>{const i=args.indexOf(n);return i<0?undefined:args[i+1]};
const root=opt('--frames')||'art/production-candidates/ui-completion-r01',out=opt('--out')||'art/review-ui-completion-r01',ids=['ui_retry','ui_victory'],findings=[],images={};
fs.mkdirSync(out+'/frames',{recursive:true});
const line=canvas(320,172,[55,55,60,255]);
for(const [index,id] of ids.entries()){
 const im=images[id]=readPNG(root+'/'+id+'/f000.png');
 fs.mkdirSync(out+'/frames/'+id,{recursive:true});
 for(const name of ['f000.png','f000.png.provenance.json','derivation.json'])fs.copyFileSync(root+'/'+id+'/'+name,out+'/frames/'+id+'/'+name);
 if(im.width!==128||im.height!==128)findings.push({rule:'UI-CANVAS',severity:'DEFECT',id});
 let clear=0,border=0;
 for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++){
  const a=im.data[(y*im.width+x)*4+3];if(a===0)clear++;
  if((x<2||y<2||x>=im.width-2||y>=im.height-2)&&a>8)border++;
 }
 if(clear<im.width*im.height*.1)findings.push({rule:'UI-ALPHA',severity:'DEFECT',id});
 if(border)findings.push({rule:'UI-BORDER',severity:'DEFECT',id});
 const strip=canvas(160,172,[65,65,70,255]);text(strip,4,5,id,[240,240,240,255]);paste(strip,im,16,28);writePNG(out+'/strip_'+id+'.png',strip);paste(line,strip,index*160,0);
}
let changed=0;for(let i=0;i<Math.min(images[ids[0]].data.length,images[ids[1]].data.length);i+=4){if(Math.abs(images[ids[0]].data[i]-images[ids[1]].data[i])>40)changed++;}
if(changed<30)findings.push({rule:'UI-STATE-DISTINCT',severity:'DEFECT',id:ids.join('/')});
const audit={defects:findings.length,flags:0,findings,changed_red_pixels:changed,visual_approval:false};
writePNG(out+'/lineup_ui_completion.png',line);
fs.writeFileSync(out+'/audit.json',JSON.stringify(audit,null,2)+'\n');
fs.writeFileSync(out+'/audit.md',`# Static completion UI audit\n\n${audit.defects}DEFECT,0FLAG\n\n${JSON.stringify(findings)}\n`);
fs.writeFileSync(out+'/scope.json',JSON.stringify({assets:ids,canvas:[128,128],frames_each:1,ui_space:true,render_css:{ui_retry:[32,32],ui_victory:[48,48]},original_animation_contract:'unchanged',style_lock:'art/style-lock.json',engine_captures:'evidence/ui-completion-captures/capture.json',visual_approval:false},null,2)+'\n');
fs.writeFileSync(out+'/index.md','# Completion UI review\n\nBlind first: lineup and both strips; save/read observations before intent. Individually inspect both raw frames,5style references, all actual engine/browser images. Static retry128px icon displayed32CSS in live retry button; victory128px displayed48CSS with live stage-clear caption. Uniform whole-canvas conversion only. Check menu scrolling,64CSS targets/live labels, completion mapping, real retry clicks and portrait hiding. No physical-device or combat/boss-animation approval; original animation contract unchanged.\n');
fs.writeFileSync(out+'/review_contract.json',JSON.stringify({scope:'two static completion UI assets',requirements:['transparent safe margins','clear return arrow and crown/laurel victory trophy','legible32/48CSS','all wording live','completion only victory row','retry remains usable in scrolled phone menu']},null,2)+'\n');
console.log(audit);if(audit.defects)process.exit(1);
