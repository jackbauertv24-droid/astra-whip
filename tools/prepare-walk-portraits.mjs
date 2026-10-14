// Explicit approved-portrait reuse after painted heads failed A08.
// No body/limb geometry changes. Preserve pre-cleanup sources and record reuse.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
const n=readPNG('art/frames/style_hero_neutral/f000.png'),clamp=x=>Math.max(0,Math.min(1,x));
const sources={4:'art/production-candidates/hero_walk-f4-key-r08.png',5:'art/production-candidates/hero_walk-f5-key-r10.png',6:'art/production-candidates/hero_walk-f6-boot-key-r09.png'};
for(const [index,path]of Object.entries(sources)){
 const out=readPNG(path),top=index==='6'?228:231,h=blank(512,512),dy=top-225;
 for(let y=top;y<top+45;y++)for(let x=220;x<299;x++){const j=(y*512+x)*4;out.data[j+3]=Math.round(out.data[j+3]*clamp((y-top-37)/8));}
 for(let y=225;y<280;y++)for(let x=232;x<286;x++){const j=((y+dy)*512+x)*4,k=(y*512+x)*4;h.data.set(n.data.subarray(k,k+4),j);h.data[j+3]=Math.round(h.data[j+3]*(1-clamp((y-270)/10)));}
 for(let j=0;j<h.data.length;j+=4){const a=h.data[j+3]/255,b=out.data[j+3]/255,v=a+b*(1-a);if(!a)continue;for(let k=0;k<3;k++)out.data[j+k]=Math.round((h.data[j+k]*a+out.data[j+k]*b*(1-a))/v);out.data[j+3]=Math.round(v*255);}
 writePNG(`art/production-candidates/hero_walk-f${index}-portrait-r10.png`,out);
 for(let j=0;j<out.data.length;j+=4)if(out.data[j+3]<=4)out.data.fill(0,j,j+4);
 writePNG(`art/frames/hero_walk/f00${index}.png`,out);writePNG(`game/assets/hero/hero_walk/f00${index}.png`,out);
}
