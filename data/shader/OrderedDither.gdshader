// Created by HullHound 09/02/2024 - Based on the already present visual shader

shader_type canvas_item;
render_mode blend_mix;

uniform vec4 ColorLight : source_color = vec4(0.780392, 0.941176, 0.847059, 1.000000);
uniform vec4 ColorDark : source_color = vec4(0.262745, 0.321569, 0.239216, 1.000000);
uniform bool invert = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float luminosity = max(max(color.r, color.g), color.b);
	//float luminosity = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
	//COLOR.rgb = luminosity > 0.0 ? ColorLight.rgb : ColorDark.rgb;//
	
	float invertModifier = invert ? -1.0 : 1.0;
	COLOR.rgb = ((luminosity - 0.5) * invertModifier > 0.0) ? ColorLight.rgb : ColorDark.rgb;
}
