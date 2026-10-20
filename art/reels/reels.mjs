const $=id=>document.getElementById(id),canvas=$('canvas'),ctx=canvas.getContext('2d'),images=new Map();
const data=await fetch('./inventory.json').then(r=>{if(!r.ok)throw Error('inventory unavailable');return r.json()});
let entry,playing=true,elapsed=0,last=performance.now(),generation=0,ready=false;
function image(path){if(!path)return Promise.resolve(null);if(!images.has(path))images.set(path,new Promise((resolve,reject)=>{const im=new Image();im.onload=()=>resolve(im);im.onerror=()=>reject(Error('missing image '+path));im.src=path}));return images.get(path)}
function frameAt(time){let start=0;for(let i=0;i<entry.ms.length;i++){if(time<start+entry.ms[i])return i;start+=entry.ms[i]}return entry.ms.length-1}
function rate(){return $('cadence').value==='runtime'?entry.runtime_rate:1}
function total(){return entry.ms.reduce((a,b)=>a+b,0)}
function setPlaying(value){playing=value;$('play').textContent=value?'Pause':'Play';$('play').setAttribute('aria-pressed',String(value));last=performance.now()}
async function select(){
 const own=++generation;entry=data.entries.find(e=>e.id===$('clip').value);elapsed=0;ready=false;canvas.dataset.ready='false';
 $('missing').textContent=entry.frames.every(Boolean)&&(!entry.weapon||entry.weapon.every(Boolean))?'Delivered source frames'+(entry.supplemental?' · supplemental hurt context':''):'NOT-TESTED: missing source frames; a highlighted rectangle replaces missing paint.';
 $('durations').textContent=total()===0?'Static style reference · timing not applicable':`Durations: ${entry.ms.join(' / ')} ms · ${total()} ms total · ${entry.loop?'loop':'hold final frame'}`;
 $('time').max=Math.max(0,total()-1);
 try{entry.bodyImages=await Promise.all(entry.frames.map(image));entry.weaponImages=entry.weapon?await Promise.all(entry.weapon.map(image)):null;if(own!==generation)return;if(entry.weaponImages)entry.weaponImages.forEach((im,i)=>{const key=entry.id+':'+i;if(!weaponLayers.has(key))weaponLayers.set(key,paintWeapon(im,entry.sockets?.[i]))});ready=true;last=performance.now();draw()}catch(error){$('missing').textContent='NOT-TESTED: '+error.message;throw error}
}
function paintWeapon(im,socket){
 if(!im)return;
 const layer=document.createElement('canvas');layer.width=im.width;layer.height=im.height;const lc=layer.getContext('2d');lc.drawImage(im,0,0);
 if(socket){const pixels=lc.getImageData(0,0,im.width,im.height);const [sx,sy]=socket;for(let y=Math.max(0,Math.floor(sy-9));y<Math.min(im.height,Math.ceil(sy+9));y++)for(let x=Math.max(0,Math.floor(sx-9));x<Math.min(im.width,Math.ceil(sx+9));x++){const t=Math.max(0,Math.min(1,(Math.hypot(x+.5-sx,y+.5-sy)-7.5)));pixels.data[(y*im.width+x)*4+3]*=t*t*(3-2*t)}lc.putImageData(pixels,0,0)}
 return layer;
}
const weaponLayers=new Map();
function draw(){
 if(!ready)return;const frame=frameAt(elapsed),im=entry.bodyImages[frame];ctx.clearRect(0,0,1024,576);ctx.save();if($('facing').value==='-1'){ctx.translate(1024,0);ctx.scale(-1,1)}
 const x=512-entry.pivot[0],y=512-entry.pivot[1];
 if(im)ctx.drawImage(im,x,y);else{ctx.fillStyle='#984e63';ctx.fillRect(x,y,entry.canvas[0],entry.canvas[1]);ctx.strokeStyle='#ffd6c9';ctx.strokeRect(x+.5,y+.5,entry.canvas[0]-1,entry.canvas[1]-1)}
 if(entry.weaponImages){const key=entry.id+':'+frame;if(!weaponLayers.has(key))weaponLayers.set(key,paintWeapon(entry.weaponImages[frame],entry.sockets?.[frame]));const layer=weaponLayers.get(key);if(layer)ctx.drawImage(layer,256,64)}
 if($('overlays').checked){ctx.strokeStyle='#85efd4';ctx.lineWidth=1;ctx.beginPath();ctx.moveTo(502,512);ctx.lineTo(522,512);ctx.moveTo(512,502);ctx.lineTo(512,522);ctx.stroke();if(entry.sockets?.[frame]){const socket=entry.sockets[frame];ctx.strokeStyle='#ffcb78';ctx.beginPath();ctx.arc(256+socket[0],64+socket[1],8,0,Math.PI*2);ctx.stroke()}}
 ctx.restore();$('time').value=Math.floor(elapsed);$('readout').value=`${entry.id} · frame ${frame+1}/${entry.ms.length} · ${Math.floor(elapsed)}/${total()} contract ms · ${rate().toFixed(3)}× cadence`;
 canvas.dataset.clip=entry.id;canvas.dataset.frame=frame;canvas.dataset.time=elapsed;canvas.dataset.ready='true';
}
for(const e of data.entries){const option=document.createElement('option');option.value=e.id;option.textContent=e.id+(e.frames.every(Boolean)?'':' · NOT-TESTED');$('clip').append(option)}
$('inventory').textContent=`${data.entries.length} clip entries. ${data.entries.filter(e=>e.frames.every(Boolean)&&(!e.weapon||e.weapon.every(Boolean))).length} have complete delivered source sequences. All other entries remain NOT-TESTED.`;
$('clip').onchange=select;$('facing').onchange=draw;$('cadence').onchange=()=>{last=performance.now();draw()};$('overlays').onchange=draw;function setScale(){const value=$('scale').value;$('stage').className=value;let scale=value==='native'?1:value==='game'?data.preview.source_scale:value==='phone'||value==='compact'?data.preview.source_scale*data.preview[value][1]/data.preview.viewport_height:null;canvas.style.width=scale?canvas.width*scale+'px':'100%'}$('scale').onchange=setScale;setScale();
$('play').onclick=()=>setPlaying(!playing);$('replay').onclick=()=>{elapsed=0;setPlaying(true);draw()};
$('time').oninput=()=>{setPlaying(false);elapsed=Number($('time').value);draw()};
function step(direction){setPlaying(false);const frame=Math.max(0,Math.min(entry.ms.length-1,frameAt(elapsed)+direction));elapsed=entry.ms.slice(0,frame).reduce((a,b)=>a+b,0);draw()}
$('previous').onclick=()=>step(-1);$('next').onclick=()=>step(1);
document.addEventListener('visibilitychange',()=>{last=performance.now()});
await select();
function tick(now){if(ready&&playing&&!document.hidden){elapsed+=(now-last)*rate();if(entry.loop)elapsed%=total();else if(elapsed>=total()){elapsed=Math.max(0,total()-1);setPlaying(false)}draw()}last=now;requestAnimationFrame(tick)}requestAnimationFrame(tick);
