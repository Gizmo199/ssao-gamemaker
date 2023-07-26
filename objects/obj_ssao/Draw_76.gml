// ROTATE CAMERA
if ( mouse_check_button(mb_middle) ) {
	if ( !mouse_check_button_pressed(mb_middle) ) {
		var dis = { x : center.x - window_mouse_get_x(), y : center.y - window_mouse_get_y() }
		angle.z -= dis.x * .1;
		angle.x += dis.y * .1;
	}
	window_mouse_set(center.x, center.y);
}

view = matrix_build_lookat( 
	x + ( dcos(angle.z) * dcos(angle.x) * zoom ),
	y + ( -dsin(angle.z) * dcos(angle.x) * zoom ),
	z + ( dsin(angle.x) * zoom ),
	x, y, z, 0, 0, -1
);

camera_set_proj_mat(view_camera[0], proj);
camera_set_view_mat(view_camera[0], view);

// VERIFY GBUFFERS
if ( !surface_exists(gColour) ) gColour = surface_create(size.x, size.y);
if ( !surface_exists(gNormal) ) gNormal	= surface_create(size.x, size.y, surface_rgba32float);
if ( !surface_exists(gDepth) )	gDepth	= surface_create(size.x, size.y, surface_rgba32float);
if ( !surface_exists(gSsao) )	gSsao	= surface_create(size.x, size.y);
