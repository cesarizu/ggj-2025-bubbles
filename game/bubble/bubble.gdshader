shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture; 
uniform sampler2D noise;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float inside = length(UV - vec2(0.5)) < 0.47 ? 1.0 : 0.0;
	
	vec2 screen_uv = SCREEN_UV;
	vec2 l = UV - vec2(0.5);
	screen_uv += l * pow(length(l), 3) * SCREEN_PIXEL_SIZE * 4000.0;
	COLOR = inside * (texture(screen_texture , screen_uv) + 0.5 * texture(noise, UV / 4.0 + vec2(mod(TIME / 50.0, 1.0) - 0.5))) + color;
}

