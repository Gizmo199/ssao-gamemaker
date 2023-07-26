// CAMERA & RENDERING
angle = {x : 0, y : 0, z : 180}
size  = {x : 1920, y : 1080 }
center= {
	x : window_get_width() * .5,
	y : window_get_height() * .5
}

view_enabled = true;
view_visible[0] = true;
x = room_width * .5;
y = room_height* .5;
z = 0;

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_counterclockwise);
layer_force_draw_depth(true, 0);

zoom	= 256;
mesh	= vertex_buffer_load("model.vbuff");
tex		= sprite_get_texture(sp_texture, 0);
mat		= matrix_build(x, y, z+80, 0, 0, 0, 1, 1, 1);
view	= [];
proj	= matrix_build_projection_perspective_fov(-60, -16/9, 1, 2048);
iproj	= matrix_inverse(proj);

// GEOMETRY BUFFERS (surfaces)
surface_resize(application_surface, size.x, size.y);
gColour		= surface_create(size.x, size.y);
gNormal		= surface_create(size.x, size.y, surface_rgba32float);
gDepth		= surface_create(size.x, size.y, surface_rgba32float);
gSsao		= surface_create(size.x, size.y);

// SHADER UNIFORMS
uni_ssao		= shader_get_sampler_index(sh_composite, "ssao");
uni_normal		= shader_get_sampler_index(sh_ssao, "normal");
uni_proj		= shader_get_uniform(sh_ssao, "projmat");
uni_iproj		= shader_get_uniform(sh_ssao, "projmat_inv");
uni_samp		= shader_get_uniform(sh_ssao, "samples");
uni_radius		= shader_get_uniform(sh_ssao, "radius");
uni_bias		= shader_get_uniform(sh_ssao, "bias");
uni_magnitude	= shader_get_uniform(sh_ssao, "magnitude");
uni_contrast	= shader_get_uniform(sh_ssao, "contrast");

// SETTINGS
ssao_on		= true;
blur_on		= true;

// UNIFORMS
radius		= 1;
bias		= .5;
magnitude	= 1.;
contrast	= 1.5;
samples		= [];
repeat(64) {
	array_push(samples, random_range(0, 1) * 2 - 1 );
	array_push(samples, random_range(0, 1) * 2 - 1 );
	array_push(samples, random_range(0, 1) );
}