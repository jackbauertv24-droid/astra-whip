#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';
import {readPNG} from './lib/png.mjs';
const ids=['ui_retry','ui_victory'],pack='art/review-ui-completion-r01',errors=[],hashes={},check=(ok,m)=>{if(!ok)errors.push(m)};
check(fs.existsSync(pack+'/review_verdict.md')&&/^REVIEW: PASS\b/m.test(fs.readFileSync(pack+'/review_verdict.md','utf8')),'fresh full independent PASS');
for(const id of ids){const p=pack+'/frames/'+id+'/f000.png',bytes=fs.readFileSync(p),im=readPNG(p);check(im.width===128&&im.height===128,'brief canvas '+id);hashes[id]=crypto.createHash('sha256').update(bytes).digest('hex');for(const q of ['art/frames/'+id+'/f000.png','game/assets/ui/'+id+'/f000.png'])check(fs.existsSync(q)&&bytes.equals(fs.readFileSync(q)),'reviewed bytes '+q);}
const audit=JSON.parse(fs.readFileSync(pack+'/audit.json'));check(audit.defects===0,'no source defects');
const c=JSON.parse(fs.readFileSync('evidence/ui-completion-captures/capture.json'));check(c.samples.length===21&&c.physical_device===false,'20state images plus portrait');
for(const prefix of ['native','phone','compact','density2'])for(const state of ['pause-retry','checkpoint-retried','victory-top','victory-retry','completion-retried']){const s=c.samples.find(s=>s.file===prefix+'-'+state+'.png');check(!!s,'capture '+prefix+state);if(s)check(s.complete===state.startsWith('victory')&&s.victory_visible===state.startsWith('victory'),'completion presentation '+s.file);}
for(const s of c.samples){const im=readPNG('evidence/ui-completion-captures/'+s.file);check(im.width===s.image_size[0]&&im.height===s.image_size[1],'actual PNG dimensions '+s.file);}
for(const log of ['ui-completion-runtime','ui-completion-captures','ui-completion-exported-runtime'])check(!/SCRIPT ERROR|Parse Error|ERROR:|FAIL /.test(fs.readFileSync('evidence/'+log+'.log','utf8')),'clean runtime '+log);
fs.writeFileSync('evidence/ui-completion-inventory.json',JSON.stringify({assets:ids,source_frames:2,actual_capture_samples:c.samples.length,sha256:hashes,physical_device:false,errors},null,2)+'\n');console.log({frames:2,captures:c.samples.length,errors});if(errors.length)process.exit(1);
