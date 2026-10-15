// Tapered raster renderer shared with the approved ground weapon fallback.
export function palette(im,x0,y0,x1,y1){const a=[];for(let y=y0;y<y1;y++)for(let x=x0;x<x1;x++){const j=(y*im.width+x)*4,r=im.data[j],g=im.data[j+1],b=im.data[j+2];if(im.data[j+3]>=200&&r>g*1.15&&g>b*1.1&&r>45&&r<210)a.push([r,g,b]);}if(!a.length)throw Error('No approved leather/handle swatch');return a;}
const mix=(a,b,t)=>a+(b-a)*t;
export function spline(points){const out=[];for(let i=0;i<points.length-1;i++){const a=points[Math.max(0,i-1)],b=points[i],d=points[i+1],e=points[Math.min(points.length-1,i+2)];const steps=Math.max(12,Math.ceil(Math.hypot(d[0]-b[0],d[1]-b[1])*1.5));for(let k=0;k<steps;k++){const t=k/steps,t2=t*t,t3=t2*t;out.push([0,1].map(q=>.5*((2*b[q])+(-a[q]+d[q])*t+(2*a[q]-5*b[q]+4*d[q]-e[q])*t2+(-a[q]+3*b[q]-3*d[q]+e[q])*t3)));}}out.push(points.at(-1));return out;}
export function stroke(im,points,w0,w1,swatch){
 let x0=im.width,y0=im.height,x1=0,y1=0;for(const p of points){x0=Math.min(x0,p[0]);y0=Math.min(y0,p[1]);x1=Math.max(x1,p[0]);y1=Math.max(y1,p[1]);}
 const radius=Math.max(w0,w1)/2+1;
 for(let y=Math.max(0,Math.floor(y0-radius));y<=Math.min(im.height-1,Math.ceil(y1+radius));y++)for(let x=Math.max(0,Math.floor(x0-radius));x<=Math.min(im.width-1,Math.ceil(x1+radius));x++){
  let best=Infinity,at=0,signed=0;
  for(let k=0;k<points.length-1;k++){const a=points[k],b=points[k+1],dx=b[0]-a[0],dy=b[1]-a[1],len2=dx*dx+dy*dy;if(!len2)continue;const t=Math.max(0,Math.min(1,((x+.5-a[0])*dx+(y+.5-a[1])*dy)/len2)),px=a[0]+t*dx,py=a[1]+t*dy,d=Math.hypot(x+.5-px,y+.5-py);if(d<best){best=d;at=(k+t)/(points.length-1);signed=((x+.5-px)*dy-(y+.5-py)*dx)/Math.sqrt(len2);}}
  const width=mix(w0,w1,at),alpha=Math.max(0,Math.min(1,width/2+.5-best));if(!alpha)continue;
  const col=swatch[(Math.floor(at*127)*13+x*3+y*7)%swatch.length],shade=Math.max(.72,Math.min(1.18,.97+signed/Math.max(1,width)*.22));
  const j=(y*im.width+x)*4,old=im.data[j+3]/255,total=alpha+old*(1-alpha);for(let k=0;k<3;k++)im.data[j+k]=Math.round((Math.min(255,col[k]*shade)*alpha+im.data[j+k]*old*(1-alpha))/total);im.data[j+3]=Math.round(total*255);
 }
}
export function coil(end){const[x,y]=end;return[[x,y],[x-8,y+10],[x-8,y+29],[x+5,y+39],[x+19,y+28],[x+17,y+9],[x+1,y+5],[x-3,y+22],[x+7,y+32],[x+13,y+21],[x+8,y+11]];}
