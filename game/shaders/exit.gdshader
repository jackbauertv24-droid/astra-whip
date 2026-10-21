shader_type canvas_item;
uniform bool unlocked = false;
void fragment() {
 vec4 paint = texture(TEXTURE, UV);
 if (unlocked) {
  float value = max(paint.r, max(paint.g, paint.b));
  vec3 ember = vec3(227.0, 163.0, 74.0) / 255.0;
  paint.rgb = mix(paint.rgb, min(ember * (0.22 + 1.2 * value), vec3(1.0)), 0.85);
 }
 COLOR = paint;
}
