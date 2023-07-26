// RENDER COLOR, NORMAL & DEPTH
shader_set(sh_ndc);
surface_set_target_ext(0, gColour);
surface_set_target_ext(1, gNormal);
surface_set_target_ext(2, gDepth);
draw_clear_alpha(0, 0);
camera_apply(view_camera[0]);

	matrix_set(matrix_world, mat);
	vertex_submit(mesh, pr_trianglelist, tex);

shader_reset();
surface_reset_target();
matrix_set(matrix_world, matrix_build_identity());
