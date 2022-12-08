list1 = instance_create_depth(50, 50, depth, obj_gm_ui_vertical_list);
button1 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary );
button1.text_content = "Hide   ->";
button2 = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
button2.text_content = "Button 2";
button3 = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
button3.text_content = "Button 3";
list1.add_childs([button1, button2, button3])

button2.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	show_message("You clicked the second button!");
});

button3.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	show_message("You clicked the third button!");
});

list2 = instance_create_depth(250, 50, depth, obj_gm_ui_vertical_list);
title = instance_create_depth(0, 0, depth, obj_gm_ui_textbox);
title.text_content = "A HEADING TITLE";
title.text_font = fnt_title;
title.set_margin(5);
title.margin_bottom = 20;
textbox1 = instance_create_depth(0, 0, depth, obj_gm_ui_textbox);
textbox1.text_content = "It is pretty easy to create a good-looking UI with game-maker-ui-library!";
textbox1.set_margin(5);
textbox2 = instance_create_depth(0, 0, depth, obj_gm_ui_textbox);
textbox2.set_margin(5);
textbox2.text_content = "This is a vertical list with text-elements. But rows also exist:";
row = instance_create_depth(0, 0, depth, obj_gm_ui_row);
row.set_margin(5);
row.set_padding(0);
button_in_row = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
button_in_row.set_padding(10);
button_in_row.set_margin(0);
button_in_row.margin_right = 10;
button_in_row.text_content = "Disable";
other_button_in_row = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
other_button_in_row.text_content = "Some Button That Can Be Disabled";
other_button_in_row.set_padding(10);
other_button_in_row.set_margin(0);
button_in_row.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	other_button_in_row.set_disabled(!other_button_in_row.disabled);
});
button1.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	list2.set_visibility(!list2.hidden);
});
row.add_childs([button_in_row, other_button_in_row]);
textbox3 = instance_create_depth(0, 0, depth, obj_gm_ui_textbox);
textbox3.set_margin(5);
textbox3.text_content = "Take a look at the code for this demo over at GitHub to find out more.";
button4 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
button4.text_content = "Okay! (Opens GitHub.com)";
button4.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	url_open_ext("https://github.com/greenpixels/game-maker-ui-library", "_blank");
});
button4.set_margin(5);
button4.margin_top = 20;
list2.add_childs([title, textbox1, textbox2, row, textbox3, button4]);


