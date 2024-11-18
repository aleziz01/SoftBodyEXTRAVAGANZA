shader_type canvas_item;
uniform sampler2D ScreenTexture:hint_screen_texture,filter_linear_mipmap;
void fragment() {
	vec2 distortedUV=SCREEN_UV + texture(TEXTURE,UV).a;
	vec4 screenColor=texture(ScreenTexture,distortedUV);
	COLOR=screenColor;
}