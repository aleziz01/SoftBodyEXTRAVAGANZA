shader_type canvas_item;
uniform sampler2D ScreenTexture: hint_screen_texture, filter_linear_mipmap;
void fragment() {
	vec4 screenColor=texture(ScreenTexture,SCREEN_UV);
	float brightness = (screenColor.r+50.0 + screenColor.g+50.0 + screenColor.b+50.0)/3.0;
	vec4 redColor = vec4(brightness,0,0,screenColor.a);
	redColor+=vec4(255,0,0,0);
	COLOR=redColor;
}