#!/usr/bin/env node
// Raster secondary motion from independently reviewed keys; every fallback is labeled.
import {readPNG,writePNG,blank} from './lib/png.mjs';
import {meshWarp,heroGrid,registerFoot,clamp} from './lib/deform.mjs';
import {readFileSync,writeFileSync,mkdirSync,cpSync,existsSync} from 'node:fs';
const c=JSON.parse(readFileSync('contract/art_contract.json'));
const meta=JSON.parse(readFileSync('art/frames/clips.json'));
const derivations=JSON.parse(readFileSync('art/frames/derivations.json'));
const getupPaths={roll:'art/production-candidates/hero_getup-roll-key-r01.png',prep:'art/production-candidates/hero_getup-prep-key-r02.png',supported:'art/production-candidates/hero_getup-supported-key-r04.png',rise:'art/production-candidates/hero_getup-rise-key-r01.png'};
const requestedClip=process.argv[2];
if(requestedClip && !c.clips[requestedClip])throw Error('Unknown clip: '+requestedClip);
const paths={neutral:'art/frames/style_hero_neutral/f000.png',turn:'art/production-candidates/hero_turn-neck-repair-key-r05.png',hurt:'art/review-hero-keys-r05/key_3.png',rise:'art/review-hero-keys-r05/key_4.png',apex:'art/review-hero-keys-r05/key_5.png',fall:'art/review-hero-keys-r05/key_6.png',halfdown:'art/review-hero-keys-r05/key_7.png',settled:'art/review-hero-keys-r05/key_8.png',down:'art/review-hero-keys-r04/key_6.png',compression:'art/frames/hero_crouch_enter/f001.png'};
const keys=Object.fromEntries(Object.entries(paths).map(([id,p])=>[id,readPNG(p)]));
const old={turn0:readPNG('art/frames/hero_turn/f000.png'),hurt0:readPNG('art/frames/hero_hurt_recoil/f000.png'),hurt3:readPNG('art/frames/hero_hurt_recoil/f003.png'),knock0:readPNG('art/frames/hero_knockback/f000.png'),stop0:readPNG('art/frames/hero_stop_move/f000.png'),stop2:readPNG('art/frames/hero_stop_move/f002.png')};
const deform=(im,fn)=>registerFoot(meshWarp(im,heroGrid.xs,heroGrid.ys,fn));
const clone=im=>({...im,data:new Uint8Array(im.data)});
function registerX(src,dx){
 const out=blank(src.width,src.height);
 for(let y=0;y<src.height;y++)for(let x=0;x<src.width;x++)if(x+dx>=0&&x+dx<src.width)out.data.set(src.data.subarray((y*src.width+x)*4,(y*src.width+x)*4+4),(y*src.width+x+dx)*4);
 return out;
}
function emit(id,images,method,kind='scripted_fallback'){
 if(requestedClip && id!==requestedClip)return;
 const root='art/frames/'+id;if(existsSync(root)){const archive=`art/rejected/motion-${Date.now()}-${id}`;mkdirSync(archive,{recursive:true});cpSync(root,archive+'/'+id,{recursive:true});}
 mkdirSync(root,{recursive:true});images.forEach((src,i)=>{const im=clone(src);for(let j=0;j<im.data.length;j+=4)if(im.data[j+3]<=4)im.data.fill(0,j,j+4);writePNG(`${root}/f${String(i).padStart(3,'0')}.png`,im);});
 const used={hero_stop_move:['art/production-candidates/hero_walk-key-edge-clean.png','art/production-candidates/hero_brake-grounded-key-r03.png',paths.neutral],hero_turn:[paths.turn,paths.neutral],hero_jump_takeoff:[paths.neutral,paths.compression,paths.rise],hero_jump_rise:[paths.rise,paths.apex],hero_jump_apex:[paths.apex,paths.rise,paths.fall],hero_fall:[paths.fall],hero_land:[paths.rise,paths.compression,paths.neutral],hero_hurt_recoil:[paths.neutral,paths.hurt],hero_knockback:[paths.neutral,paths.hurt],hero_knockdown:[paths.hurt,paths.halfdown,paths.down],hero_get_up:[paths.down,...Object.values(getupPaths),paths.neutral],hero_death:[paths.hurt,paths.halfdown,paths.down,paths.settled]};
 const derivation={kind,source:used[id],method,reason:id==='hero_get_up'?'The reverse-fall experiment failed supported recovery. Direct painted in-between poses replace held and unsupported frames; fresh independent motion review is required.':'Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.'};
 meta[id]={ms:c.clips[id].ms,loop:c.clips[id].loop,derivation};derivations[id]=derivation;
}
const braking=readPNG('art/production-candidates/hero_brake-grounded-portrait-r05.png');
emit('hero_stop_move',[old.stop0,braking,old.stop2],'Contact, direct painted grounded knee compression with rear boot drawing inward, then neutral settle. Middle body normalized once at 0.973214; approved neutral portrait reused rigidly 6 px down with feathered neck join after two generated portraits failed head tolerance. No limb deformation.','reused');
emit('hero_turn',[old.turn0,keys.turn,keys.neutral],'Planted weight anticipation, a painted hip/shoulder twist with pivot foot loaded, then a neutral settling stance; direct AI-painted neck repair retains the compact portrait and articulated twist.','scripted_fallback');
emit('hero_jump_takeoff',[keys.neutral,keys.compression,keys.rise],'Neutral load, planted compression, then articulated airborne push-off.','reused');
const tucked=deform(keys.rise,(x,y)=>{const w=(1-clamp((x-255)/25))*clamp((y-375)/20),a=25*Math.PI/180,dx=x-238,dy=y-390;return[x+w*(dx*Math.cos(a)-dy*Math.sin(a)-dx),y+w*(dx*Math.sin(a)+dy*Math.cos(a)-dy)];});
const apexSettle=deform(keys.apex,(x,y)=>[x-2*clamp((y-330)/60)*clamp((265-x)/60),y]);
emit('hero_jump_rise',[keys.rise,tucked,keys.apex,apexSettle],'A rising one-knee pose folds the trailing leg, progresses to a painted two-knee tuck, and settles the cape. Authored horizontal origin retained.');
emit('hero_jump_apex',[apexSettle,keys.rise,keys.fall],'Two-knee suspension releases to one-knee balance and finally the painted extended-leg descent posture.','reused');
const fallPose=a=>deform(keys.fall,(x,y)=>{const w=(1-clamp((x-265)/20))*clamp((y-365)/20),angle=a*Math.PI/180,dx=x-239,dy=y-390,cloth=clamp((y-320)/55)*(1-clamp((y-390)/20))*clamp((255-x)/55),arm=clamp((x-285)/35)*clamp((y-285)/20)*(1-clamp((y-340)/20));return[x+w*(dx*Math.cos(angle)-dy*Math.sin(angle)-dx)-a*cloth*.15,y+w*(dx*Math.sin(angle)+dy*Math.cos(angle)-dy)+a*arm*.1];});
emit('hero_fall',[fallPose(0),fallPose(-8),fallPose(-16),fallPose(-7)],'Distinct downward-leg key with rear calf rotating about its knee, lifted cloak flutter, and forward arm response; returns continuously to the loop start.');
const landingRelease=deform(keys.compression,(x,y)=>[x,y-5*clamp((430-y)/65)]);
emit('hero_land',[keys.rise,keys.compression,landingRelease,keys.neutral],'Airborne contact, planted knee/hip compression, a small articulated release, then upright recovery.');
const recovering=deform(keys.hurt,(x,y)=>[x+5*clamp((430-y)/150),y+2*clamp((x-245)/50)*clamp((y-300)/30)*(1-clamp((y-350)/15))]);
emit('hero_hurt_recoil',[old.hurt0,keys.hurt,recovering,old.hurt3],'Painted torso/head flinch with defensive arm and knee articulation, followed by guarded release and recovery. Original endpoints retained.');
const knocked=a=>deform(keys.hurt,(x,y)=>{const body=clamp((430-y)/150),arm=clamp((x-245)/50)*clamp((y-285)/25)*(1-clamp((y-340)/20));return[x-a*body-a*arm*.3,y+a*clamp((y-370)/40)*(1-clamp((y-430)/18))*.15];});
emit('hero_knockback',[old.knock0,keys.hurt,knocked(4),knocked(8)],'Impact changes the neutral stance into a painted defensive backward lean, then knees/arms/cloth sustain that response during physical displacement.');
const halfSettle=deform(keys.halfdown,(x,y)=>[x,y+1.5*clamp((280-x)/75)*(1-clamp((y-420)/20))]);
const downSettle=a=>deform(keys.down,(x,y)=>[x+a*clamp((y-380)/35)*(1-clamp((y-435)/10)),y]);
const knockdown=[keys.hurt,keys.halfdown,halfSettle,keys.down,downSettle(1),downSettle(2)];
emit('hero_knockdown',knockdown,'Backward painted flinch, bracing mid-fall, hip/elbow ground contact, then clothing settle.');
const getupPainted=Object.values(getupPaths).map(readPNG);
emit('hero_get_up',[readPNG('art/frames/hero_get_up/f000.png'),...getupPainted,keys.neutral],'Initial floor-contact frame retained, then direct painted supported torso roll/leg draw-in, low recovery preparation, planted-palm/foot half-kneel, rising half-kneel, and stable neutral recovery. Each new painted pose individually normalized once with authored horizontal origin retained.','reused');
const deathSettle=a=>deform(keys.settled,(x,y)=>{const cloth=clamp((x-190)/45)*(1-clamp((x-320)/35))*clamp((425-y)/35);return[x+a*cloth,y+a*cloth*.5];});
emit('hero_death',[keys.hurt,keys.halfdown,halfSettle,keys.down,downSettle(2),keys.settled,deathSettle(2),deathSettle(1.5),deathSettle(.75),keys.settled],'Full flinch and backward collapse through hip support into a painted resting body, followed by quiet fabric settle and a final hold. No get-up route.');
writeFileSync('art/frames/clips.json',JSON.stringify(meta,null,2));writeFileSync('art/frames/derivations.json',JSON.stringify(derivations,null,2));
