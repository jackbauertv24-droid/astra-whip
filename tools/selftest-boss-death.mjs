#!/usr/bin/env node
// Prove the dissolve tripwire rejects the retained production defect.
import{spawnSync}from'node:child_process';
import{mkdtempSync,readFileSync,writeFileSync,rmSync}from'node:fs';
import{tmpdir}from'node:os';
const temp=mkdtempSync(tmpdir()+'/astra-death-selftest-'),cases=[];
try{
 for(const[revision,expected]of[['r02',1],['r03',0]]){
  const out=temp+'/'+revision+'.json',run=spawnSync(process.execPath,['tools/check-boss-death-erosion.mjs','--frames','art/production-candidates/boss-death-'+revision,'--out',out],{encoding:'utf8'});
  if(run.status!==expected)throw Error('Unexpected erosion result '+revision+': '+run.stdout+run.stderr);
  const result=JSON.parse(readFileSync(out));
  if(revision==='r02'&&result.punched_interior_pixels<1||revision==='r03'&&result.punched_interior_pixels!==0)throw Error('Defect not distinguished');
  cases.push({revision,expected_exit:expected,actual_exit:run.status,solid_interior_samples:result.solid_interior_samples,punched_interior_pixels:result.punched_interior_pixels});
 }
 writeFileSync('evidence/boss-death-erosion-selftest.json',JSON.stringify({cases,pass:true,scope:'Retained round-hole defect versus edge-led erosion; independent visual approval is separate.'},null,2)+'\n');
 console.log('SELFTEST boss death: retained punched-hole failure detected; corrected edge erosion passes');
}finally{rmSync(temp,{recursive:true,force:true})}
