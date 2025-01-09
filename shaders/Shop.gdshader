shader_type canvas_item;
uniform sampler2D ScreenTexture: hint_screen_texture, filter_linear_mipmap;
void fragment() {
	vec4 screenColor=texture(ScreenTexture,SCREEN_UV,0);
	float brightness = (screenColor.r + screenColor.g + screenColor.b)/3.0;
	vec4 redColor = vec4(brightness,0,0,screenColor.a);
	COLOR=redColor;
}