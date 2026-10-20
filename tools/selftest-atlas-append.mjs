#!/usr/bin/env node
import{spawnSync}from'node:child_process';
import{readFileSync,writeFileSync,mkdtempSync,rmSync}from'node:fs';
import{tmpdir}from'node:os';
import{createHash}from'node:crypto';
const base=JSON.parse(readFileSync('evidence/boss-death-atlas-base.json')),current=JSON.parse(readFileSync('game/data/atlas.json')),digest=p=>createHash('sha256').update(readFileSync(p)).digest('hex'),initial=digest('game/data/atlas.json'),temp=mkdtempSync(tmpdir()+'/astra-atlas-append-');
let retained=0;for(const[path,entry]of Object.entries(base.frames)){if(JSON.stringify(entry)!==JSON.stringify(current.frames[path]))throw Error('Existing placement changed '+path);retained++}
const cases=[];
try{
 for(const kind of ['changed-source','incompatible-padding']){
  const bad=structuredClone(base);if(kind==='changed-source')bad.frames[Object.keys(bad.frames)[0]].rgba_sha256='0'.repeat(64);else bad.padding++;
  const file=temp+'/'+kind+'.json';writeFileSync(file,JSON.stringify(bad));const run=spawnSync(process.execPath,['tools/pack-atlas.mjs','--append-from',file],{encoding:'utf8'});
  if(run.status===0||!run.stderr.includes(kind==='changed-source'?'Append requires unchanged existing source':'Incompatible append layout'))throw Error('Negative control escaped '+kind);
  if(digest('game/data/atlas.json')!==initial)throw Error('Rejected append changed manifest');cases.push({case:kind,exit:run.status,rejected:true});
 }
 writeFileSync('evidence/boss-death-atlas-append-selftest.json',JSON.stringify({retained_placements:retained,cases,pass:true},null,2)+'\n');console.log('SELFTEST atlas append: '+retained+' placements unchanged; changed source and incompatible padding rejected');
}finally{rmSync(temp,{recursive:true,force:true})}
