shader_type canvas_item;

uniform sampler2D noise_img: repeat_enable;

void fragment() {
	vec4 noiseColor=texture(noise_img,UV);
	vec4 screenColor=texture(TEXTURE,UV);
	vec2 uvB=vec2(UV.x,UV.y+TIME/2.0);
	COLOR=vec4(0,0,texture(noise_img,uvB).b+0.1,screenColor.a);
	if (screenColor.a!=0.0 && (texture(TEXTURE,UV+vec2(0.01,0.01)).a==0.0 || texture(TEXTURE,UV-vec2(0.01,0.01)).a==0.0))
		COLOR=vec4(255,255,255,255);
}