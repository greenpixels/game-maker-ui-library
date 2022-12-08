// Inherit the parent event
event_inherited();


add_event_callback(UI_EVENT.ON_MOUSE_ENTER, function() {
	bg_color = global.color_theme.button_primary.hover;
	text_color = global.color_theme.button_primary.text_color.hover;
})


add_event_callback(UI_EVENT.ON_MOUSE_EXIT, function() {
	bg_color = global.color_theme.button_primary.standard;
	text_color = global.color_theme.button_primary.text_color.standard;
	brightness = 0;	
})

add_event_callback(UI_EVENT.ON_MOUSE_PRESSED, function() {
	brightness = -0.1;	
})

add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	brightness = 0;	
})

add_event_callback(UI_EVENT.ON_DISABLE, function() {
	brightness = -0.2;
})

add_event_callback(UI_EVENT.ON_ENABLE, function() {
	brightness = 0;	
})