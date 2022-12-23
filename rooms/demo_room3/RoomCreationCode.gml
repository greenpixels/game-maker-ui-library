back_button = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
back_button.text_content = "Back";
back_button.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	room_goto(demo_room1);	
});
back_button.update();

list = instance_create_depth(x, y, depth, obj_gm_ui_vertical_list);
list.min_width = window_get_width();
list.min_height = window_get_height();
list.max_width = window_get_width();
list.max_height = window_get_height();
list.padding_top = 150;
list.justify_content = UI_JUSTIFY_CONTENT.FILL_WIDTH;



text_box = instance_create_depth(x, y, depth, obj_gm_ui_textbox);
text_box.text_content = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam";
text_box.outline_top_strength = 1;
text_box.outline_right_strength = 1;
text_box.outline_left_strength = 1;
text_box.outline_bottom_strength = 1;
text_box.set_margin(15);
text_box.set_padding(10);
text_box.min_height = 160;

row_halign = instance_create_depth(x, y, depth, obj_gm_ui_row);
row_halign.justify_content = UI_JUSTIFY_CONTENT.FILL_WIDTH;

button_left = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_left.text_content = "HALIGN LEFT";
button_left.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_halign = fa_left;
	text_box.redraw_in_next_frame = true;
});
button_center = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_center.text_content = "HALIGN CENTER";
button_center.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_halign = fa_center;
	text_box.redraw_in_next_frame = true;
});
button_right = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_right.text_content = "HALIGN RIGHT";
button_right.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_halign = fa_right;
	text_box.redraw_in_next_frame = true;
});

row_halign.add_childs([button_left, button_center, button_right]);

row_valign = instance_create_depth(x, y, depth, obj_gm_ui_row);
row_valign.justify_content = UI_JUSTIFY_CONTENT.FILL_WIDTH;

button_top = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_top.text_content = "VALIGN TOP";
button_top.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_valign = fa_top;
	text_box.redraw_in_next_frame = true;
});
button_middle = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_middle.text_content = "VALIGN MIDDLE";
button_middle.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_valign = fa_middle;
	text_box.redraw_in_next_frame = true;
});
button_bottom = instance_create_depth(x, y, depth, obj_gm_ui_button_primary);
button_bottom.text_content = "VALIGN BOTTOM";
button_bottom.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	text_box.text_valign = fa_bottom;
	text_box.redraw_in_next_frame = true;
});

row_valign.add_childs([button_top, button_middle, button_bottom]);



list.add_childs([row_halign, row_valign, text_box]);


