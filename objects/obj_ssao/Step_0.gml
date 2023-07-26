// ALTER SETTINGS
zoom		-= ( mouse_wheel_up() - mouse_wheel_down() ) * 10;
ssao_on		= !keyboard_check(vk_space);
blur_on		= !keyboard_check(ord("B"));
radius		-= ( keyboard_check_pressed(ord("A")) - keyboard_check_pressed(ord("Q")) ) * .1;
bias		-= ( keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W")) ) * .1;
magnitude	-= ( keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("E")) ) * .1;
contrast	-= ( keyboard_check_pressed(ord("F")) - keyboard_check_pressed(ord("R")) ) * .1;