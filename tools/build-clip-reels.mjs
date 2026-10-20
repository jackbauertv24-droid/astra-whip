#!/usr/bin/env node
import{readFileSync,existsSync,mkdirSync,writeFileSync}from'node:fs';
const contract=JSON.parse(readFileSync('game/data/art_contract.json'));
const sockets=JSON.parse(readFileSync('game/data/hand_sockets.json'));
const contexts=JSON.parse(readFileSync('game/data/boss_hurt_contexts.json'));
const clips={...contract.clips};
for(const context of Object.values(contexts))clips[context.id]={actor:'boss',ms:context.ms,loop:false,supplemental:true};
const visual=readFileSync('game/scripts/actor_visual.gd','utf8'),rules=readFileSync('game/scripts/rules.gd','utf8');
function number(source,name){const match=source.match(new RegExp('const '+name+' = ([0-9.]+)'));if(!match)throw Error('missing authoritative constant '+name);return Number(match[1])}
const sum=values=>values.reduce((a,b)=>a+b,0);
const scaleMatch=visual.match(/scale = Vector2\(([0-9.]+),/);if(!scaleMatch)throw Error('missing authored runtime scale');
const viewportMatch=readFileSync('game/project.godot','utf8').match(/window\/size\/viewport_height=(\d+)/);if(!viewportMatch)throw Error('missing runtime viewport height');
const preview={source_scale:Number(scaleMatch[1]),viewport_height:Number(viewportMatch[1]),phone:[698,393],compact:[568,320]};
const rates={hero_walk:number(visual,'WALK_CADENCE'),pursuer_approach_walk:sum(clips.pursuer_approach_walk.ms)*number(rules,'PURSUER_APPROACH_SPEED')/(sum(clips.pursuer_patrol_walk.ms)*number(rules,'PURSUER_PATROL_SPEED'))};
const entries=Object.entries(clips).map(([id,spec])=>{
 const actor=spec.actor==='whip'?contract.whip:contract.actors[spec.actor],canvas=spec.canvas||actor?.canvas||[512,576],pivot=spec.anchor||actor?.pivot||[256,512];
 const frames=spec.ms.map((ms,i)=>{const path=id==='style_hero_neutral'?'art/frames/style_hero_neutral/f000.png':`game/assets/${spec.actor==='whip'?'hero':spec.actor}/${id}/f${String(i).padStart(3,'0')}.png`;return existsSync(path)?'../../'+path:null});
 const weapon=id.startsWith('hero_attack_')?spec.ms.map((ms,i)=>{const path=`game/assets/hero/whip_${id.slice(5)}/f${String(i).padStart(3,'0')}.png`;return existsSync(path)?'../../'+path:null}):null;
 return{id,runtime_rate:rates[id]||1,ms:spec.ms,loop:spec.loop,canvas,pivot,frames,weapon,sockets:sockets[id]||null,supplemental:!!spec.supplemental};
});
mkdirSync('art/reels',{recursive:true});
writeFileSync('art/reels/inventory.json',JSON.stringify({scope:'Timed source-art reels. Not visual approval or an in-engine recording.',preview,entries},null,2)+'\n');
console.log(JSON.stringify({clips:entries.length,complete:entries.filter(e=>e.frames.every(Boolean)&&(!e.weapon||e.weapon.every(Boolean))).length,missing_frames:entries.reduce((n,e)=>n+e.frames.filter(f=>!f).length,0)}));
