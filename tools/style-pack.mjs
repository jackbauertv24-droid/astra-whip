import {readPNG,writePNG} from './lib/png.mjs';
import {canvas,paste,rect,cross,hline,vline,text} from './lib/draw.mjs';
import {mkdirSync,copyFileSync,writeFileSync,appendFileSync} from 'node:fs';
const out=process.argv[2]||'art/review-style-v3';mkdirSync(out,{recursive:true});
const hero=readPNG('art/frames/style_hero_neutral/f000.png');
const attack=readPNG('art/candidates/style_hero_attack_key.png');
const enemy=readPNG('art/candidates/style_enemy_pursuer.png');
const terrain=readPNG('art/candidates/style_terrain_patch_3x3.png');
copyFileSync('art/candidates/style_hero_attack_key.png',out+'/style_hero_attack_key.png');
copyFileSync('art/candidates/style_enemy_pursuer.png',out+'/style_enemy_pursuer.png');
copyFileSync('art/candidates/style_terrain_patch_3x3.png',out+'/style_terrain_patch_3x3.png');
const lineup=canvas(1344,512);paste(lineup,hero,0,0);paste(lineup,attack,512,0);paste(lineup,enemy,1024,224);
hline(lineup,0,1343,448,[235,64,52,255]);hline(lineup,0,1023,224,[64,200,235,255]);
writePNG(out+'/calibration_lineup.png',lineup);
const repeat=canvas(1152,384);for(let i=0;i<3;i++)paste(repeat,terrain,384*i,0);writePNG(out+'/terrain_repeat.png',repeat);
const scene=readPNG('art/candidates/environment-background.png');
for(let x=0;x<2560;x+=384)paste(scene,terrain,x,1120);
paste(scene,hero,800-256,1120-448);
// Schematic interactable accent for calibration only; not a production prop.
for(let y=1024;y<1120;y++)for(let x=1832;x<1864;x++)scene.data.set([76,88,102,255],(y*2560+x)*4);
for(let y=1004;y<1038;y++)for(let x=1834;x<1862;x++)if(Math.abs(x-1848)+Math.abs(y-1021)<16)scene.data.set([227,163,74,255],(y*2560+x)*4);
writePNG(out+'/style_env_mockup.png',scene);
copyFileSync('art/candidates/environment-background.png',out+'/layer_background.png');
copyFileSync('art/candidates/style_terrain_patch_3x3.png',out+'/layer_terrain.png');
copyFileSync('art/frames/style_hero_neutral/f000.png',out+'/layer_hero.png');
const overlay=canvas(768,512);paste(overlay,attack,0,0);
// Socket measured from the delivered fist, schematic weapon for style gate.
const socket=[355,288];cross(overlay,...socket,6,[0,255,255,255]);
const path=[];
for(let x=socket[0];x<=592;x++) {
 const y=Math.round(socket[1]+40*Math.min(1,(x-socket[0])/70));
 path.push([x,y]);
 for(let dy=-1;dy<=1;dy++)overlay.data.set([160,133,96,255],((y+dy)*overlay.width+x)*4);
}
text(overlay,18,20,'SOCKET SOURCE (355,288); GAME (+49.5,-80)',[255,255,255,255],1);
rect(overlay,336,284,592,356,[255,230,0,255]);writePNG(out+'/attack_socket_overlay.png',overlay);
writeFileSync(out+'/style-scope.md',`# Style calibration scope\n\nReview only the five ART_BIBLE section 8 calibration pieces at this gate.\nHero neutral: strip_style_hero_neutral.png / layer_hero.png.\nAttack key: style_hero_attack_key.png and schematic attack_socket_overlay.png.\nPursuer alert: style_enemy_pursuer.png.\nTerrain: style_terrain_patch_3x3.png and terrain_repeat.png.\nEnvironment: style_env_mockup.png, style_env_mockup_phone.png, style_env_mockup_grayscale.png.\n\nBackground, terrain and hero sources are retained separately. The checkpoint-like amber accent is schematic calibration geometry, not final production art.\nNo production animation clips have been delivered at this gate.\n`);

const neutralOverlay=canvas(512,512);paste(neutralOverlay,hero,0,0);
rect(neutralOverlay,216,240,296,448,[255,230,0,255]);
cross(neutralOverlay,233,337,6,[0,255,255,255]);
text(neutralOverlay,16,16,'CONTACT 40X104 U; PIVOT (256,448)',[255,255,255,255],1);
text(neutralOverlay,16,30,'HAND SOURCE (233,337); GAME (-11.5,-55.5)',[255,255,255,255],1);
writePNG(out+'/neutral_contact_socket.png',neutralOverlay);
const mirrored=canvas(512,512);
for(let y=0;y<512;y++)for(let x=0;x<512;x++) {
 const i=(y*512+x)*4,j=(y*512+511-x)*4,a=hero.data[j+3]/255;
 for(let c=0;c<3;c++)mirrored.data[i+c]=Math.round(hero.data[j+c]*a+118*(1-a));
}
writePNG(out+'/neutral_mirrored.png',mirrored);
const creatureOverlay=canvas(320,256);paste(creatureOverlay,enemy,0,0);
rect(creatureOverlay,32,120,224,224,[255,230,0,255]);cross(creatureOverlay,128,224,6,[255,64,200,255]);
text(creatureOverlay,8,8,'CONTACT 96X52 U; PIVOT (128,224)',[255,255,255,255],1);
writePNG(out+'/pursuer_contact.png',creatureOverlay);
const grid=canvas(384,384);paste(grid,terrain,0,0);
for(let t=0;t<=384;t+=128){vline(grid,Math.min(383,t),0,383,[64,200,235,255]);hline(grid,0,383,Math.min(383,t),[64,200,235,255]);}
hline(grid,0,383,0,[255,230,0,255]);text(grid,6,16,'64 U GRID; Y=0 WALKABLE COLLISION TOP',[255,230,0,255],1);
writePNG(out+'/terrain_collision_grid.png',grid);
const attackScene=readPNG('art/candidates/environment-background.png');
for(let x=0;x<2560;x+=384)paste(attackScene,terrain,x,1120);
paste(attackScene,attack,800-256,1120-448);
for(const [x,y] of path)for(let dy=-1;dy<=1;dy++)attackScene.data.set([160,133,96,255],((y+1120-448+dy)*2560+x+800-256)*4);
writePNG(out+'/attack_scene.png',attackScene);
const creatureScene=readPNG('art/candidates/environment-background.png');
for(let x=0;x<2560;x+=384)paste(creatureScene,terrain,x,1120);
paste(creatureScene,enemy,800-128,1120-224);paste(creatureScene,hero,1100-256,1120-448);
writePNG(out+'/pursuer_scene.png',creatureScene);

appendFileSync(out+'/style-scope.md','\nAdditional evidence: neutral_contact_socket.png, neutral_mirrored.png, attack_scene.png, attack_scene_phone.png, attack_scene_grayscale.png, pursuer_contact.png, pursuer_scene.png, pursuer_scene_phone.png, pursuer_scene_grayscale.png, terrain_collision_grid.png.\n');
