#!/usr/bin/env node
import fs from 'node:fs';import{readPNG}from'./lib/png.mjs';import{auditBackgrounds}from'./lib/background-audit.mjs';
const specs=JSON.parse(fs.readFileSync('game/data/background_art.json')).assets,images=Object.fromEntries(Object.keys(specs).map(id=>[id,readPNG('art/production-candidates/background-r01/'+id+'/f000.png')])),results=[];
function control(name,id,edit,rule){const image=images[id],old=image.data.slice();edit(image);const audit=auditBackgrounds(images,specs);image.data.set(old);const detected=audit.findings.some(f=>f.rule===rule);results.push({name,rule,detected});if(!detected)throw Error('control escaped '+name);}
control('opaque panel alpha','bg_sky',i=>i.data[3]=0,'BG-OPAQUE');control('wrapped edge corruption','bg_distant_silhouette',i=>i.data[0]^=255,'BG-SEAM');control('foreground painted backing','bg_foreground_frame',i=>{for(let p=3;p<i.data.length;p+=4)i.data[p]=255},'BG-ALPHA');
fs.writeFileSync('evidence/background-negative-controls.json',JSON.stringify(results,null,2)+'\n');console.log('PASS background audit:3 negative controls detected');
