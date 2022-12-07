// Inherit the parent event
event_inherited();

add_event_callback(UI_EVENT.ON_MOUSE_ENTER, function() {
	brightness = 0.1;
})

add_event_callback(UI_EVENT.ON_MOUSE_PRESSED, function() {
	brightness = -0.1;
})

add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	brightness = 0.1;
})


add_event_callback(UI_EVENT.ON_MOUSE_EXIT, function() {
	brightness = 0;
})