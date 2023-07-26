// RENDER SSAO
surface_set_target(gSsao);
draw_clear(0);
shader_set(sh_ssao);
shader_set_uniform_f_array(uni_proj, proj);
shader_set_uniform_f_array(uni_iproj, iproj);
shader_set_uniform_f_array(uni_samp, samples);
shader_set_uniform_f(uni_radius, radius);
shader_set_uniform_f(uni_bias, bias);
shader_set_uniform_f(uni_magnitude, magnitude);
shader_set_uniform_f(uni_contrast, contrast);
texture_set_stage(uni_normal, surface_get_texture(gNormal));
draw_surface(gDepth, 0, 0);
surface_reset_target();
shader_reset();

// BLUR SSAO 
if ( blur_on ) {
	var hblur = surface_create(size.x, size.y);
	surface_set_target(hblur);
	draw_clear(0);
	shader_set(sh_blur_h);
	draw_surface(gSsao, 0, 0);
	surface_reset_target();
	shader_reset();

	surface_set_target(gSsao);
	shader_set(sh_blur_v);
	draw_surface(hblur, 0, 0);
	surface_reset_target();
	shader_reset();
	surface_free(hblur);
}

// COMBINE SSAO
if ( ssao_on ) {
	shader_set(sh_composite);
	texture_set_stage(uni_ssao, surface_get_texture(gSsao));
	draw_surface(gColour, 0, 0);
	shader_reset();
} else draw_surface(gColour, 0, 0);

// INSTRUCTIONS
draw_text(5, 5, 
	"[MIDDLE-MOUSE-PRESS] - Rotate Scene" + "\n" +
	"[MIDDLE-MOUSE-WHEEL] - Zoom in/out" + "\n" +
	"[SPACE-HOLD] - Turn SSAO off" + "\n" +
	"[B-HOLD] - Turn Blur off" + "\n" +
	"[Q][A] - RADIUS : " + string(radius) + "\n" +
	"[W][S] - BIAS : " + string(bias) + "\n" +
	"[E][D] - MAGNITUDE : " + string(magnitude) + "\n" +
	"[R][F] - CONTRAST : " + string(contrast)
);