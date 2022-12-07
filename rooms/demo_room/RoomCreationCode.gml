list = instance_create_depth(20, 20, depth, obj_gm_ui_list);
button1 = instance_create_depth(0, 0, depth, obj_gm_ui_button);
button2 = instance_create_depth(0, 0, depth, obj_gm_ui_button);
button1.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	show_message("You have clicked this button!");
});
button2.add_event_callback(UI_EVENT.ON_MOUSE_RELEASED, function() {
	show_message("You have the other button!");
});
list.add_child(button1);
list.add_child(button2);

text_example1 = instance_create_depth(400, 20, depth, obj_gm_ui_element);
text_example1.text_color = c_black;
text_example1.padding_left = 10;
text_example1.padding_right = 10;
text_example1.bg_color = c_orange;
text_example1.text_color = c_maroon;
text_example1.bg_alpha = 1;
text_example1.text_content = "This element has text content that extends the width of this element.";
text_example1.update();

text_example2 = instance_create_depth(400, 60, depth, obj_gm_ui_element);
text_example2.text_color = c_black;
text_example2.padding_left = 10;
text_example2.padding_right = 10;
text_example2.padding_top = 10;
text_example2.padding_bottom = 10;
text_example2.bg_color = c_orange;
text_example2.text_color = c_maroon;
text_example2.bg_alpha = 1;
text_example2.max_width = 200;
text_example2.text_content = "This element has text content that extends the width of this element until it reaches the maximum width. After reaching that maximum width it breaks line and extends downwards.";
text_example2.update();

label = instance_create_depth(50, 350, depth, obj_gm_ui_element);
label.text_color = c_black;
label.padding_left = 10;
label.padding_right = 10
label.bg_alpha = 1;
label.text_content = "Adding children will by default add them in a row.\nThe heighest element determines the height of the element/row. Just like text, they will go to the next line when reaching the maximum width!";
label.update();

container = instance_create_depth(50, 400, depth, obj_gm_ui_element);
container.bg_alpha = 1;
container.padding_top = 10;
container.padding_right = 10;
container.padding_left = 10;
container.padding_bottom = 10;
child1 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child1.bg_color = c_red;
child1.bg_alpha = 1;
child1.min_width = 50;
child1.min_height = 50;
child2 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child2.bg_color = c_yellow;
child2.bg_alpha = 1;
child2.min_width = 30;
child2.min_height = 50;
child3 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child3.bg_color = c_green;
child3.bg_alpha = 1;
child3.min_width = 50;
child3.min_height = 20;
child4 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child4.bg_color = c_blue;
child4.bg_alpha = 1;
child4.min_width = 50;
child4.min_height = 70;
container.add_childs([child1, child2, child3, child4]);
container.update();

container2 = instance_create_depth(500, 400, depth, obj_gm_ui_element);
container2.bg_alpha = 1;
container2.padding_top = 10;
container2.padding_right = 10;
container2.padding_left = 10;
container2.padding_bottom = 10;
container2.maximum_width = 100;
container2.max_width = 170;

child5 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child5.bg_color = c_maroon;
child5.bg_alpha = 1;
child5.min_width = 50;
child5.min_height = 70;

child6 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child6.bg_color = c_purple;
child6.bg_alpha = 1;
child6.min_width = 40;
child6.min_height = 60;

child7 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child7.bg_color = c_green;
child7.bg_alpha = 1;
child7.min_width = 50;
child7.min_height = 90;

child8 = instance_create_depth(0, 0, depth, obj_gm_ui_element);
child8.bg_color = c_yellow;
child8.bg_alpha = 1;
child8.min_width = 30;
child8.min_height = 50;

container2.add_childs([child5, child6, child7, child8]);
container2.update();