shader_type canvas_item;

uniform vec4 outline_color: hint_color;

void fragment() {
	vec2 ps = TEXTURE_PIXEL_SIZE;
	float a = texture(TEXTURE, UV + vec2(0.0, -1.0) * ps).a;

	a += texture(TEXTURE, UV + vec2(0.0, 1.0) * ps).a;

	a += texture(TEXTURE, UV + vec2(-1.0, 0.0) * ps).a;

	a += texture(TEXTURE, UV + vec2(1.0, 0.0) * ps).a;
	
	a /= 4.0;
	
	vec4 col = texture(TEXTURE, UV);
	COLOR = col.a >= a ? col : outline_color;
}
