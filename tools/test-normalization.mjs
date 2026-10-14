#!/usr/bin/env node
// Regression: a trailing boot must not become the horizontal root of an air pose.
import assert from 'node:assert/strict';
import {mkdtempSync,readFileSync,rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {execFileSync,spawnSync} from 'node:child_process';
import {blank,readPNG,writePNG} from './lib/png.mjs';
const dir=mkdtempSync(join(tmpdir(),'astra-registration-'));
try {
 const image=blank(512,512);
 for(let y=200;y<=448;y++)for(let x=(y<380?250:300);x<=(y<380?270:320);x++)image.data.set([90,70,50,255],(y*512+x)*4);
 const src=join(dir,'source.png'),old=join(dir,'legacy.png'),fixed=join(dir,'fixed.png');writePNG(src,image);
 execFileSync(process.execPath,['tools/normalize-frame.mjs',src,old,'249']);
 assert.equal(readPNG(old).data[(200*512+250)*4+3],0,'Legacy foot-centering fixture must demonstrate the horizontal drift.');
 execFileSync(process.execPath,['tools/normalize-frame.mjs',src,fixed,'249','256','448','256']);
 assert.equal(readPNG(fixed).data[(200*512+250)*4+3],255,'Authored root must preserve head placement when the boot is offset.');
 const provenance=JSON.parse(readFileSync(fixed+'.normalization.json'));
 assert.deepEqual(provenance.source_pivot,[256,448]);
 assert.equal(provenance.corrective_normalization,1);
 const rejected=spawnSync(process.execPath,['tools/normalize-frame.mjs',src,join(dir,'overscale.png'),'400']);
 assert.notEqual(rejected.status,0,'Bounded normalization must still reject an excessive scale.');
 console.log('NORMALIZATION TEST: PASS — legacy drift demonstrated; authored origin preserved; scale bound enforced');
} finally {rmSync(dir,{recursive:true,force:true});}
