back_button = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
back_button.text_content = "Back";
back_button.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	room_goto(demo_room1);	
});
back_button.update();

row = instance_create_depth(0, 300, depth, obj_gm_ui_row);
row.min_width = window_get_width();
button1 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
button1.text_content = "Start";
button1.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	row.justify_content = UI_JUSTIFY_CONTENT.START;
	row.update();
});
button2 = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
button2.text_content = "Space Between";
button2.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	row.justify_content = UI_JUSTIFY_CONTENT.SPACE_BETWEEN;
	row.update();
});
button3 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
button3.text_content = "Space Evenly";
button3.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	row.justify_content = UI_JUSTIFY_CONTENT.SPACE_EVENLY;
	row.update();
});
button4 = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
button4.text_content = "Fill Width";
button4.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	row.justify_content = UI_JUSTIFY_CONTENT.FILL_WIDTH;
	row.update();
});
row.add_childs([button1, button2, button3, button4]);