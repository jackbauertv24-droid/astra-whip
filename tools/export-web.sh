#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
GODOT_BIN="${GODOT_BIN:-godot}"
mkdir -p evidence
# Global lossless compression effort is not a per-file import option. Rebuild
# the nine shipped textures so an existing editor cache cannot retain old data.
node --input-type=module <<'JS'
import fs from 'node:fs';
const atlas=JSON.parse(fs.readFileSync('game/data/atlas.json')),bg=JSON.parse(fs.readFileSync('game/data/background_art.json'));
const paths=[...atlas.pages.map(p=>p.path),...Object.values(bg.assets).map(p=>p.path)],removed=[];
for(const path of paths){const file='game/'+path.slice(6)+'.import';if(!fs.existsSync(file))continue;const match=fs.readFileSync(file,'utf8').match(/^path="(res:\/\/\.godot\/imported\/[^"\n]+\.ctex)"/m);if(!match)throw Error('unexpected texture remap '+path);const dest='game/'+match[1].slice(6);if(dest.includes('..'))throw Error('unsafe generated cache path');for(const p of [dest,dest.replace(/\.ctex$/,'.md5')])if(fs.existsSync(p)){fs.unlinkSync(p);removed.push(p);}}
fs.writeFileSync('evidence/web-reimport.json',JSON.stringify({source_textures:paths,removed_generated_cache_files:removed},null,2)+'\n');
JS
"$GODOT_BIN" --headless --editor --path game --import --quit > evidence/web-import.log 2>&1
"$GODOT_BIN" --headless --path game --export-release Web ../build/web/index.html > evidence/web-export.log 2>&1
node --input-type=module <<'JS'
import fs from'node:fs';for(const p of ['evidence/web-import.log','evidence/web-export.log'])if(/SCRIPT ERROR|Parse Error|ERROR:/.test(fs.readFileSync(p,'utf8')))throw Error('export error; inspect '+p);console.log('Web import/export complete');
JS
