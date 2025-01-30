shader_type canvas_item;
uniform sampler2D ScreenTexture: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 screenColor=texture(ScreenTexture,SCREEN_UV);
	COLOR=screenColor;
}