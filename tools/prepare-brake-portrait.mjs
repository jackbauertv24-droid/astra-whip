// Explicit portrait reuse after failed generation; body and limbs remain unchanged.
import{readPNG,writePNG,blank}from'./lib/png.mjs';
const root=new URL('../',import.meta.url).pathname;const out=readPNG(root+'art/production-candidates/hero_brake-grounded-key-r03.png'),n=readPNG(root+'art/frames/style_hero_neutral/f000.png'),h=blank(512,512),clamp=x=>Math.max(0,Math.min(1,x));
for(let y=231;y<276;y++)for(let x=220;x<299;x++){const j=(y*512+x)*4;out.data[j+3]=Math.round(out.data[j+3]*clamp((y-268)/8));}
for(let y=225;y<280;y++)for(let x=232;x<286;x++){const j=((y+6)*512+x)*4,k=(y*512+x)*4;h.data.set(n.data.subarray(k,k+4),j);h.data[j+3]=Math.round(h.data[j+3]*(1-clamp((y-270)/10)));}
for(let j=0;j<h.data.length;j+=4){const a=h.data[j+3]/255,b=out.data[j+3]/255,v=a+b*(1-a);if(!a)continue;for(let k=0;k<3;k++)out.data[j+k]=Math.round((h.data[j+k]*a+out.data[j+k]*b*(1-a))/v);out.data[j+3]=Math.round(v*255);}
writePNG(root+'art/production-candidates/hero_brake-grounded-portrait-r05.png',out);
