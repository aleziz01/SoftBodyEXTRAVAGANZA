shader_type canvas_item;

void fragment() {
	vec4 screenColor=texture(TEXTURE,UV);
	if (screenColor.a!=0.0 && (texture(TEXTURE,UV+vec2(0.01,0.01)).a==0.0))
		COLOR=vec4(255,255,255,255);
	if (screenColor.a!=0.0 && texture(TEXTURE,UV-vec2(0.01,0.01)).a==0.0)
		COLOR=vec4(0,0,0,255);
}