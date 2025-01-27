shader_type canvas_item;

uniform sampler2D noise_img: repeat_enable;

void fragment() {
	vec4 noiseColor=texture(noise_img,UV);
	vec4 screenColor=texture(TEXTURE,UV);

	vec2 uvR=vec2(UV.x+cos(TIME),UV.y+sin(TIME));
	float noiseR=screenColor.r;
	if (texture(noise_img,uvR).r>0.2)
		noiseR=(texture(noise_img,uvR).r + screenColor.r)/5.0;

	vec3 finalColor=vec3(noiseR,0,0);
	COLOR.rgb=finalColor.rgb;
	COLOR.a=screenColor.a;
}