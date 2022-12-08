list = instance_create_depth(20, 20, depth, obj_gm_ui_vertical_list);
button1 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary );
button2 = instance_create_depth(0, 0, depth, obj_gm_ui_button_primary);
button3 = instance_create_depth(0, 0, depth, obj_gm_ui_button_secondary);
list.add_child(button1);
list.add_child(button2);
