for(var _i = 0; _i < ds_list_size(children); _i++) {
	var _child = ds_list_find_value(children, _i);	
	with(_child) {
		instance_destroy();	
	}
}

ds_list_destroy(children);
ds_map_destroy(event_callbacks);