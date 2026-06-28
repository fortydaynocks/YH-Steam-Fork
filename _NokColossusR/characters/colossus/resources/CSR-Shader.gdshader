shader_type canvas_item;

const vec4 replacement_color = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 blade_color = vec4(0.41, 0.44, 0.6, 1.0);
const vec4 smear_color_1 = vec4(0.75, 0.8, 0.86, 1.0);
const vec4 smear_color_2 = vec4(0.55, 0.61, 0.71, 1.0);

const vec4 flame_color_white = vec4(1.0, 0.96, 0.89, 1.0);
const vec4 flame_color_yellow = vec4(0.98, 0.95, 0.21, 1.0);
const vec4 flame_color_orange = vec4(1.0, 0.54, 0.2, 1.0);
const vec4 flame_color_orange_dark = vec4(0.9, 0.27, 0.22, 1.0);

uniform bool astaroth_mode = false;
const vec4 as_blade_color = vec4(0.15, 0.15, 0.18, 1.0);
const vec4 as_soul_color = vec4(0.0, 1.0, 0.58, 1.0);
uniform int as_counter = 0;

const float super_dim_amount = 0.35;

uniform bool use_extra_color_1 = false;
uniform bool use_extra_color_2 = false;
uniform vec4 extra_replace_color_1 : hint_color  = vec4(1.0, 0.0, 1.0, 1.0);
uniform vec4 extra_replace_color_2 : hint_color  = vec4(1.0, 0.0, 1.0, 1.0);
uniform bool use_fire_shader = false;


uniform vec4 color: hint_color = vec4(1.0);
uniform vec4 extra_color_1: hint_color = vec4(1.0);
uniform vec4 extra_color_2: hint_color = vec4(1.0);

uniform float max_color_distance = 0.01;

uniform bool super_dim = false;
uniform bool use_outline = false;

uniform vec4 outline_color : hint_color = vec4(0.0, 0.0, 0.0, 1.0);

bool same_color(vec3 color1, vec3 color2) {
	return distance(color1, color2) < max_color_distance;
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = col;
	if (same_color(col.rgb, replacement_color.rgb)) {
		COLOR.rgb = color.rgb;
		COLOR.a = texture(TEXTURE, UV).a;
	}
	if (use_outline && COLOR.a == 0.0) {
		
		//	NORMAL OUTLINE
		float size_x = 1.0/float(textureSize(TEXTURE, 0).x);
		float size_y = 1.0/float(textureSize(TEXTURE, 0).y);
		vec4 sprite_color = texture(TEXTURE, UV);
		float alpha = -8.0 * sprite_color.a;
		alpha += texture(TEXTURE, UV + vec2(size_x, 0)).a * float(same_color(texture(TEXTURE, UV + vec2(size_x, 0)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(-size_x, 0)).a * float(same_color(texture(TEXTURE, UV + vec2(-size_x, 0)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(0, size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(0, size_y)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(0, -size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(0, -size_y)).rgb, replacement_color.rgb));
		
		//For outlining corners
		//Change the -4.0 to -8.0 in alpa if adding these lines
		alpha += texture(TEXTURE, UV + vec2(size_x, size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(size_x, size_y)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(-size_x, size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(-size_x, size_y)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(-size_x, -size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(-size_x, -size_y)).rgb, replacement_color.rgb));
		alpha += texture(TEXTURE, UV + vec2(size_x, -size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(size_x, -size_y)).rgb, replacement_color.rgb));
		vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
		COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
	}
	
	if (astaroth_mode) {
		
		//	ASTAROTH BLADE COLOR
		if (use_extra_color_1 && same_color(col.rgb, as_blade_color.rgb)) {
		COLOR.rgb = extra_color_1.rgb;
		COLOR.a = texture(TEXTURE, UV).a;
		}
		
		//	ASTAROTH SMEAR COLORS
		if (use_extra_color_2) {
			if (same_color(col.rgb, smear_color_1.rgb)) {
				COLOR.rgb = mix(smear_color_1.rgb, extra_color_2.rgb, 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, smear_color_2.rgb)) {
				COLOR.rgb = mix(smear_color_2.rgb, extra_color_2.rgb, 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
		}
		
		//	ASTAROTH SOUL COLORS
		if (use_extra_color_2) {
			if (same_color(col.rgb, as_soul_color.rgb)) {
				if (as_counter >= 7) {
					COLOR.rgb = mix(extra_color_2.rgb, vec3(1, 1, 1), 0.5);
					COLOR.a = texture(TEXTURE, UV).a;
				}
				else if (as_counter >= 4) {
					COLOR.rgb = extra_color_2.rgb;
					COLOR.a = texture(TEXTURE, UV).a;
				}
				else if (as_counter >= 1) {
					COLOR.rgb = extra_color_2.rgb;
					COLOR.a = texture(TEXTURE, UV).a - 0.5;
				}
				else {
					COLOR.rgb = extra_color_2.rgb;
					COLOR.a = texture(TEXTURE, UV).a - 1.0;
				}
			}
			
			//	FLAME COLORS
			if (same_color(col.rgb, flame_color_white.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(1, 1, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_yellow.rgb)) {
				COLOR.rgb = extra_color_2.rgb;
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(0, 0, 0.5), 0.2);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange_dark.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(0, 0, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
		
		} else {
			//	FLAME COLORS (NO EXISTENT EXTRA 2)
			if (same_color(col.rgb, flame_color_white.rgb)) {
				COLOR.rgb = mix(as_soul_color.rgb, vec3(1, 1, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_yellow.rgb)) {
				COLOR.rgb = as_soul_color.rgb;
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange.rgb)) {
				COLOR.rgb = mix(as_soul_color.rgb, vec3(0, 0, 0.5), 0.2);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange_dark.rgb)) {
				COLOR.rgb = mix(as_soul_color.rgb, vec3(0, 0, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
		}
	} else {
		
		//	BLADE COLOR
		if (use_extra_color_1 && same_color(col.rgb, extra_replace_color_1.rgb)) {
		COLOR.rgb = extra_color_1.rgb;
		COLOR.a = texture(TEXTURE, UV).a;
		}
		
		//	SMEAR COLORS
		if (use_extra_color_1) {
			if (same_color(col.rgb, smear_color_1.rgb)) {
				COLOR.rgb = mix(smear_color_1.rgb, extra_color_1.rgb, 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, smear_color_2.rgb)) {
				COLOR.rgb = mix(smear_color_2.rgb, extra_color_1.rgb, 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
		}
		
		//	FLAME COLORS
		if (use_extra_color_2 && use_fire_shader) {
			if (same_color(col.rgb, flame_color_white.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(1, 1, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_yellow.rgb)) {
				COLOR.rgb = extra_color_2.rgb;
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(0, 0, 0.5), 0.2);
				COLOR.a = texture(TEXTURE, UV).a;
			}
			if (same_color(col.rgb, flame_color_orange_dark.rgb)) {
				COLOR.rgb = mix(extra_color_2.rgb, vec3(0, 0, 1), 0.4);
				COLOR.a = texture(TEXTURE, UV).a;
			}
		}

		//	SWORD OUTLINE
		if (use_extra_color_2 && use_outline && COLOR.a == 0.0) {
			float size_x = 1.0/float(textureSize(TEXTURE, 0).x);
			float size_y = 1.0/float(textureSize(TEXTURE, 0).y);
			vec4 sprite_color = texture(TEXTURE, UV);
			float alpha = -8.0 * sprite_color.a;
			alpha += texture(TEXTURE, UV + vec2(size_x, 0)).a * float(same_color(texture(TEXTURE, UV + vec2(size_x, 0)).rgb, extra_replace_color_1.rgb));
			alpha += texture(TEXTURE, UV + vec2(-size_x, 0)).a * float(same_color(texture(TEXTURE, UV + vec2(-size_x, 0)).rgb, extra_replace_color_1.rgb));
			alpha += texture(TEXTURE, UV + vec2(0, size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(0, size_y)).rgb, extra_replace_color_1.rgb));
			alpha += texture(TEXTURE, UV + vec2(0, -size_y)).a * float(same_color(texture(TEXTURE, UV + vec2(0, -size_y)).rgb, extra_replace_color_1.rgb));

			
			vec4 final_color = mix(sprite_color, extra_color_2, clamp(alpha, 0.0, 1.0));
			COLOR = vec4(final_color.rgb, clamp(abs(alpha) - COLOR.a, 0.0, 1.0));
		}
	}
}