shader_type canvas_item;
render_mode unshaded;
void fragment() {
 vec4 paint=texture(TEXTURE,UV);
 // Opaque authored panels fade only behind the play plane, joining the sky.
 float join=smoothstep(0.0,0.12,UV.y)*(1.0-smoothstep(0.86,1.0,UV.y));
 COLOR=vec4(paint.rgb,paint.a*join);
}
