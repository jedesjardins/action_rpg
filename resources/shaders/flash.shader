shader_type canvas_item;

uniform vec4 fill_color: hint_color;
uniform float elapsed_time;
uniform float flash_per_s;

void fragment() {
	float a = texture(TEXTURE, UV).a;
	
	vec4 col = (int(elapsed_time*flash_per_s) % 2 == 1) ? texture(TEXTURE, UV) : fill_color;
	col.a = a;
	COLOR = col;
}
