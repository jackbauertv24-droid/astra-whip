export function auditBackgrounds(images,specs){
 const findings=[];const defect=(id,rule,message)=>findings.push({id,rule,severity:'DEFECT',message});
 for(const[id,s]of Object.entries(specs)){
  const im=images[id];if(!im){defect(id,'BG-MISSING','missing asset');continue;}
  if(im.width!==s.canvas[0]||im.height!==s.canvas[1])defect(id,'BG-CANVAS','wrong brief canvas');
  if(s.collision!=='none')defect(id,'BG-COLLISION','background must not collide');
  let opaque=0,transparent=0,central=0,bottom=0;for(let y=0;y<im.height;y++)for(let x=0;x<im.width;x++){const a=im.data[(y*im.width+x)*4+3];if(a===255)opaque++;if(a===0)transparent++;if(a>8&&x>=im.width*.2&&x<im.width*.8)central++;if(a>8&&y>=im.height*.75)bottom++;}
  if(s.opaque&&opaque!==im.width*im.height)defect(id,'BG-OPAQUE','opaque panel contains alpha');
  if(!s.opaque&&transparent<im.width*im.height*.5)defect(id,'BG-ALPHA','sparse foreground must have real substantial transparency');
  if(!s.opaque&&(central||bottom))findings.push({id,rule:'BG-FRAMING',severity:'FLAG',message:`${central} central and ${bottom} bottom-quarter ink pixels; inspect against actual landing/tell geometry`});
  if(s.tiling==='x'){let maximum=0;for(let y=0;y<im.height;y++)for(let c=0;c<4;c++)maximum=Math.max(maximum,Math.abs(im.data[(y*im.width)*4+c]-im.data[(y*im.width+im.width-1)*4+c]));if(maximum)defect(id,'BG-SEAM',`declared reflected wrap edge differs by ${maximum}`);}
 }
 return{defects:findings.filter(f=>f.severity==='DEFECT').length,flags:findings.filter(f=>f.severity==='FLAG').length,findings,visual_approval:false};
}
