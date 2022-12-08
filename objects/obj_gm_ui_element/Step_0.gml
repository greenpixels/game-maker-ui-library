if(parent != noone) {
	room_x = parent.room_x + x;
	room_y = parent.room_y + y;
} else {
	room_x = x;
	room_y = y;
}

if(mouse_in_element()) {
	if(disabled) return;
	
	if(!hovered) {
		hovered = true;
		execute_event_callbacks(UI_EVENT.ON_MOUSE_ENTER);
		redraw_in_next_frame = true;
	}
	
	if(mouse_check_button_pressed(mb_left)) {
		execute_event_callbacks(UI_EVENT.ON_MOUSE_PRESSED);	
		redraw_in_next_frame = true;
	}
	
	if(mouse_check_button_released(mb_left)) {
		execute_event_callbacks(UI_EVENT.ON_MOUSE_RELEASED);	
		redraw_in_next_frame = true;
	}
	
} else {
	if(hovered) {
		hovered = false;
		execute_event_callbacks(UI_EVENT.ON_MOUSE_EXIT);
		redraw_in_next_frame = true;
	}
	
}