// Contact registration after independent world-space motion review.
// The lower boot translates as a unit; the knee/cloth transition follows above it.
import{readPNG,writePNG}from'./lib/png.mjs';
import{meshWarp,heroGrid,clamp}from'./lib/deform.mjs';
const source='art/production-candidates/hero_walk-contact-key-r17.png';
const im=meshWarp(readPNG(source),heroGrid.xs,heroGrid.ys,(x,y)=>[x-17*clamp((y-365)/40)*clamp((x-245)/15),y]);
writePNG('art/production-candidates/hero_walk-contact-registered-r19.png',im);
