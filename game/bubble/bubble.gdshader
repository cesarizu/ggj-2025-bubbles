shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture; 
uniform sampler2D noise : repeat_enable;
uniform vec4 bubble_color : source_color = vec4(1, 1, 1, 1);

vec2 rotate(vec2 uv, float angle) {
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	return uv * rotation;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float inside = distance(vec2(0.5), UV) < 0.47 ? 1.0 : 0.0;
	
	vec2 screen_uv = SCREEN_UV;
	vec2 l = UV - vec2(0.5);
	screen_uv += l * pow(length(l), 3) * SCREEN_PIXEL_SIZE * 4000.0;

	vec2 time_mov = vec2(mod(TIME / 10.0, 1.0) - 0.5);
	vec2 noise_uv = rotate(vec2(0, UV.x), UV.y * 2.0 * PI);

	COLOR = inside * (texture(screen_texture , screen_uv) +      // Screen deformation
	                  0.5 * texture(noise, noise_uv + time_mov)) // Iridescent colors
		  + color * bubble_color;                                               // Texture color
}

