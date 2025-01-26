shader_type canvas_item;

void fragment() {
	vec4 screenColor=texture(TEXTURE,UV);
	if (screenColor.a==0.0 && (texture(TEXTURE,UV+vec2(0.04,0.04)).a==0.0 || texture(TEXTURE,UV-vec2(0.04,0.04)).a==0.0))
		COLOR=vec4(0,0,0,255);
}