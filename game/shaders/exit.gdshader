shader_type canvas_item;
uniform bool unlocked = false;
void fragment() {
 // Keep half-scale nearest sampling identical for full canvases and trimmed atlases.
 vec2 centre = (floor(UV / TEXTURE_PIXEL_SIZE + vec2(0.001)) + vec2(0.5)) * TEXTURE_PIXEL_SIZE;
 vec4 paint = texture(TEXTURE, centre);
 if (unlocked) {
  float value = max(paint.r, max(paint.g, paint.b));
  vec3 ember = vec3(227.0, 163.0, 74.0) / 255.0;
  paint.rgb = mix(paint.rgb, min(ember * (0.22 + 1.2 * value), vec3(1.0)), 0.85);
 }
 COLOR = paint;
}
