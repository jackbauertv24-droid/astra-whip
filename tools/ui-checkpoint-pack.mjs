#!/usr/bin/env node
import fs from 'node:fs';
import {readPNG,writePNG} from './lib/png.mjs';
import {canvas,paste,text} from './lib/draw.mjs';
const args=process.argv.slice(2),opt=n=>{const i=args.indexOf(n);return i<0?undefined:args[i+1]};
const root=opt('--frames')||'art/production-candidates/ui-checkpoint-r01',out=opt('--out')||'art/review-ui-checkpoint-r01',ids=['ui_checkpoint_off','ui_checkpoint_on'],findings=[],images={};
fs.mkdirSync(out+'/frames',{recursive:true});
const line=canvas(320,140,[55,55,60,255]);
for(const [index,id] of ids.entries()){
 const im=images[id]=readPNG(root+'/'+id+'/f000.png');
 fs.mkdirSync(out+'/frames/'+id,{recursive:true});
 for(const name of ['f000.png','f000.png.provenance.json','derivation.json'])fs.copyFileSync(root+'/'+id+'/'+name,out+'/frames/'+id+'/'+name);
 if(im.width!==128||im.height!==96)findings.push({rule:'UI-CANVAS',severity:'DEFECT',id});
 let clear=0,border=0;
 for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++){
  const a=im.data[(y*im.width+x)*4+3];if(a===0)clear++;
  if((x<2||y<2||x>=im.width-2||y>=im.height-2)&&a>8)border++;
 }
 if(clear<im.width*im.height*.1)findings.push({rule:'UI-ALPHA',severity:'DEFECT',id});
 if(border)findings.push({rule:'UI-BORDER',severity:'DEFECT',id});
 const strip=canvas(160,140,[65,65,70,255]);text(strip,4,5,id,[240,240,240,255]);paste(strip,im,16,28);writePNG(out+'/strip_'+id+'.png',strip);paste(line,strip,index*160,0);
}
let changed=0;for(let i=0;i<Math.min(images[ids[0]].data.length,images[ids[1]].data.length);i+=4){if(Math.abs(images[ids[0]].data[i]-images[ids[1]].data[i])>40)changed++;}
if(changed<30)findings.push({rule:'UI-STATE-DISTINCT',severity:'DEFECT',id:ids.join('/')});
const audit={defects:findings.length,flags:0,findings,changed_red_pixels:changed,visual_approval:false};
writePNG(out+'/lineup_ui_checkpoint.png',line);
fs.writeFileSync(out+'/audit.json',JSON.stringify(audit,null,2)+'\n');
fs.writeFileSync(out+'/audit.md',`# Static checkpoint HUD audit\n\n${audit.defects}DEFECT,0FLAG\n\n${JSON.stringify(findings)}\n`);
fs.writeFileSync(out+'/scope.json',JSON.stringify({assets:ids,canvas:[128,96],frames_each:1,ui_space:true,render_css:[32,24],original_animation_contract:'unchanged',style_lock:'art/style-lock.json',engine_captures:'evidence/ui-checkpoint-captures/capture.json',visual_approval:false},null,2)+'\n');
fs.writeFileSync(out+'/index.md','# Checkpoint HUD review\n\nBlind first: lineup and both strips, save/read observations before metadata/intent. Inspect both raw frames, all five style references and every supplied engine/browser PNG. Static UI at32x24CSS, hollow/off versus filled/lit must be legible. Whole-canvas uniform conversion only. Live HUD text should fit beside health and pause without cut-off words. Actual trigger/death/retry/completion-reset and portrait fixtures are scoped UI evidence, not combat animation or physical-device approval. Original animation contract unchanged.\n');
fs.writeFileSync(out+'/review_contract.json',JSON.stringify({scope:'two static checkpoint HUD states',requirements:['transparent margins','same shrine identity/scale','inactive hollow versus active filled ember','legible32x24CSS','live health text fits safe space','matches checkpoint capture and retry, portrait hidden']},null,2)+'\n');
console.log(audit);if(audit.defects)process.exit(1);
