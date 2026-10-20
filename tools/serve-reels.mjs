#!/usr/bin/env node
import{createServer}from'node:http';
import{readFile,stat}from'node:fs/promises';
import{resolve,extname,sep}from'node:path';
const root=resolve('.'),port=Number(process.env.REEL_PORT||8081);
const types={'.html':'text/html','.mjs':'text/javascript','.json':'application/json','.png':'image/png'};
createServer(async(request,response)=>{try{let path=resolve(root,'.'+decodeURIComponent(new URL(request.url,'http://localhost').pathname));if(path!==root&&!path.startsWith(root+sep)){response.writeHead(403).end();return}if((await stat(path)).isDirectory())path=resolve(path,'index.html');response.writeHead(200,{'Content-Type':types[extname(path)]||'application/octet-stream','Cache-Control':'no-store'});response.end(await readFile(path))}catch{response.writeHead(404).end('Not found')}}).listen(port,'127.0.0.1',()=>console.log(`Timed reels: http://127.0.0.1:${port}/art/reels/`));
