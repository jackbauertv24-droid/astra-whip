// Piecewise affine sprite deformation for declared ART_CONTRACT §11 fallbacks.
// Input geometry is kept in source pixels; no global scale normalization occurs.
import {blank} from './png.mjs';

function sample(src,x,y,out,j) {
  const ix=Math.floor(x),iy=Math.floor(y),fx=x-ix,fy=y-iy;
  let alpha=0,r=0,g=0,b=0;
  for(let dy=0;dy<2;dy++)for(let dx=0;dx<2;dx++) {
    const xx=ix+dx,yy=iy+dy;
    if(xx<0||xx>=src.width||yy<0||yy>=src.height)continue;
    const k=(yy*src.width+xx)*4,w=(dx?fx:1-fx)*(dy?fy:1-fy),a=src.data[k+3]/255*w;
    alpha+=a;r+=src.data[k]*a;g+=src.data[k+1]*a;b+=src.data[k+2]*a;
  }
  out[j]=alpha?Math.round(r/alpha):0;out[j+1]=alpha?Math.round(g/alpha):0;out[j+2]=alpha?Math.round(b/alpha):0;out[j+3]=Math.round(alpha*255);
}

export function meshWarp(src,xs,ys,transform) {
  const result=blank(src.width,src.height),points=[];
  for(const y of ys)for(const x of xs)points.push({source:[x,y],target:transform(x,y)});
  const tri=(a,b,c)=>{
    const p=[points[a],points[b],points[c]],[[ax,ay],[bx,by],[cx,cy]]=p.map(v=>v.target);
    const den=(by-cy)*(ax-cx)+(cx-bx)*(ay-cy);
    if(Math.abs(den)<1e-8)return;
    const x0=Math.max(0,Math.floor(Math.min(ax,bx,cx))),x1=Math.min(src.width-1,Math.ceil(Math.max(ax,bx,cx)));
    const y0=Math.max(0,Math.floor(Math.min(ay,by,cy))),y1=Math.min(src.height-1,Math.ceil(Math.max(ay,by,cy)));
    for(let y=y0;y<=y1;y++)for(let x=x0;x<=x1;x++){
      const u=((by-cy)*(x-cx)+(cx-bx)*(y-cy))/den;
      const v=((cy-ay)*(x-cx)+(ax-cx)*(y-cy))/den,w=1-u-v;
      if(u<-.00001||v<-.00001||w<-.00001)continue;
      sample(src,u*p[0].source[0]+v*p[1].source[0]+w*p[2].source[0],u*p[0].source[1]+v*p[1].source[1]+w*p[2].source[1],result.data,(y*src.width+x)*4);
    }
  };
  for(let y=0;y<ys.length-1;y++)for(let x=0;x<xs.length-1;x++){
    const a=y*xs.length+x,b=a+1,c=a+xs.length,d=c+1;
    tri(a,b,d);tri(a,d,c);
  }
  return result;
}

export const heroGrid={xs:[0,170,195,215,235,255,275,295,320,370,420,512],ys:[0,210,225,265,280,300,325,345,365,390,410,430,448,470,512]};
export const clamp=(v,lo=0,hi=1)=>Math.max(lo,Math.min(hi,v));

export function registerFoot(src,baseline=448) {
  let bottom=-1;
  for(let y=0;y<src.height;y++)for(let x=0;x<src.width;x++)if(src.data[(y*src.width+x)*4+3]>=40)bottom=y;
  const dy=baseline-bottom,result=blank(src.width,src.height);
  for(let y=0;y<src.height;y++)if(y+dy>=0&&y+dy<src.height)result.data.set(src.data.subarray(y*src.width*4,(y+1)*src.width*4),(y+dy)*src.width*4);
  return result;
}
