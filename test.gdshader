shader_type canvas_item;

void fragment() {
	vec4 screenColor=texture(TEXTURE,UV);
	if (screenColor.a!=0.0)
		screenColor.a=0.0;
		COLOR=texture(TEXTURE,UV+vec2(sin(TIME),cos(TIME)));
	COLOR=screenColor;
}