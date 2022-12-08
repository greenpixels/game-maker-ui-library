validate_surface();
paint();

var _scaled_offset_x = (width * (x_scale - 1))/2
var _scaled_offset_y = (height * (y_scale - 1))/2

if(hidden) return;

if(parent == noone) {
	draw_surface_ext(surface, x - _scaled_offset_x, y - _scaled_offset_y, x_scale, y_scale, rotation, c_white, 1);
} else {
	// Draw on parent surface and then redraw parent in the next frame (Potential problem: Takes 1 frame for every parent. Elements with a lot of children will cause a delay)
	parent.validate_surface();
	surface_set_target(parent.surface);
		shader_set(shd_brightness);
			var _u_brightness = shader_get_uniform(shd_brightness, "brightness");
			shader_set_uniform_f(_u_brightness, brightness);
			draw_surface_ext(surface, x - _scaled_offset_x, y - _scaled_offset_y, x_scale, y_scale, rotation, c_white, 1);
		shader_reset()
	surface_reset_target();
	parent.redraw_in_next_frame = true;
}


