// PRIVATE FUNCTIONS

/**
 * Checks whether the surface does not exist or its dimensions are not equal to the elements dimensions then it creates or resizes accordingly and triggers a redraw.
 * @ignore
 */
function validate_surface() {
	if(!surface_exists(surface)) {
		surface = surface_create(max(1, round(width)), max(1, round(height)));
		redraw_in_next_frame = true;
	} 
	
	if(surface_get_width(surface) != round(width) or surface_get_height(surface) != round(height)) {
		surface_resize(surface, max(1, round(width)), max(1,round(height)));
		redraw_in_next_frame = true;
	}
}

/**
 * Returns whether adding the width to the current elements width would exceed the maximum width specified. If no maximum width is specified the functions always returns false.
 * @param {real} _width The width in pixels to add for the check
 * @returns {bool} Whether the maximum width has been exceeded
 * @ignore
 */
function check_max_width_exceeded(_current_row_width, _width) {
	if(max_width != undefined) {
		return (_current_row_width + _width > max_width);	
	} else {
		return false;	
	}
}

/**
 * Creates rows with line breaks and then calls 'justify_rows' using the created rows in this function to horizontally position them
 * @ignore
 */
function layout_children() {
	var _y = padding_top;
	var _current_row_heighest = 0;
	var _current_row_width = 0;
	var _current_row = 0;
	var _rows = ds_list_create();
	
	for(var _i = 0; _i < ds_list_size(children); _i++) {
		var _children_in_current_row = ds_list_find_value(_rows, _current_row);
		
		var _child = ds_list_find_value(children, _i);
		_child.update();
		var _child_w = _child.margin_left + _child.width + _child.margin_right;
		var _child_h = _child.margin_top + _child.height + _child.margin_bottom;
	
		// Check whether adding a child to this element would exceed to maximum width
		if(check_max_width_exceeded(_current_row_width, _child_w)) {
			// Check wther the child in general is wider than the allowed width
			if(_child_w < max_width - padding_left - padding_right) {
				// If not, then break to the next line and repeat the layouting for this child
				_y += _current_row_heighest;
				height += _current_row_heighest;
				_current_row_width = 0;
				_current_row_heighest = 0;
				_current_row++;
				_children_in_current_row = ds_list_find_value(_rows, _current_row);
			}
		}
		
		_current_row_heighest = max(_current_row_heighest, _child_h);
		_current_row_width += _child_w;
		width = max(width, _current_row_width - (padding_left + padding_right));
		if(max_width) width = clamp(width, width, max_width);
		
		//_child.x = _x + _child.margin_left;
		_child.y = _y + _child.margin_top;
		
		// Add the child to the current row
		if(is_undefined(_children_in_current_row)) {
			_children_in_current_row = ds_list_create();
			ds_list_add(_children_in_current_row, _child);
			ds_list_add(_rows, _children_in_current_row);
		} else {
			ds_list_add(_children_in_current_row, _child);
			ds_list_replace(_rows, _current_row, _children_in_current_row);
		}
		
		// When this element has a vertical layout, then go the next line after every element
		if(flex_direction == UI_FLEX_DIRECTION.VERTICAL) {
			_y += _current_row_heighest;
			height += _current_row_heighest;
			_current_row_width = 0;
			_current_row_heighest = 0;
			_current_row++;
		}
	}
	height += _current_row_heighest;
	justify_rows(_rows);
}


/**
 * Justifies or resizes all children horizontally according to the chosen justification method
 * @param {id.dslist} _rows A list of lists containing each child element in a row
 * @ignore
 */
function justify_rows(_rows) {
	for(var _i = 0; _i < ds_list_size(_rows); _i++) {
		var _children_in_row = ds_list_find_value(_rows, _i);
		var _width_sum = 0;

		
		// Get width of all children in the current row
		for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
			var _child = ds_list_find_value(_children_in_row, _j);
			_width_sum +=  _child.margin_left + _child.width + _child.margin_right;
		}
		
		var _empty_space = width - padding_left - padding_right - _width_sum;
		// Excecute the justification of space using the emtpy space
		switch(justify_content) {
			
			case UI_JUSTIFY_CONTENT.START: 
				var _x = padding_left;
				for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
					var _child = ds_list_find_value(_children_in_row, _j);
					_child.x = _x + _child.margin_left;
					_x += _child.margin_left + _child.width + _child.margin_right;
				}
			break;
			
			case UI_JUSTIFY_CONTENT.CENTER:
				var _x = padding_left + _empty_space/2;
				for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
					var _child = ds_list_find_value(_children_in_row, _j);
					_child.x = _x + _child.margin_left;
					_x += _child.margin_left + _child.width + _child.margin_right;
				}
			break;
			
			case UI_JUSTIFY_CONTENT.SPACE_BETWEEN:
				if(ds_list_size(_children_in_row) <= 1) continue;
				var _x = padding_left;
				var _spacing = _empty_space / (ds_list_size(_children_in_row) - 1);
				for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
					var _child = ds_list_find_value(_children_in_row, _j);
					_child.x = _x + _child.margin_left;
					_x += _child.margin_left + _child.width + _child.margin_right + _spacing;
				}
			break;
			
			case UI_JUSTIFY_CONTENT.SPACE_EVENLY:
				if(ds_list_size(_children_in_row) <= 1) continue;
				var _spacing = _empty_space / (ds_list_size(_children_in_row) + 1);
				var _x = padding_left + _spacing;
				for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
					var _child = ds_list_find_value(_children_in_row, _j);
					_child.x = _x + _child.margin_left;
					_x += _child.margin_left + _child.width + _child.margin_right + _spacing;
				}
			break;
			
			case UI_JUSTIFY_CONTENT.FILL_WIDTH:			
				// Distribute the empty space among all children
				while(_empty_space > 0) {
						var _max_width_reached = true;
						for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
						if(_empty_space <= 0) continue;
						var _child = ds_list_find_value(_children_in_row, _j);
						if(_child.max_width != undefined) {
							if(_child.width < _child.max_width) {
								_child.width++;
								_max_width_reached = false;
								_empty_space--;
							}
						} else {
							_child.width++;
							_max_width_reached = false;
							_empty_space--;
						}
						
					}
					// If no child can be widened, then just break the loop
					if(_max_width_reached) {
						break;
					}
				}
				// Place all widened children next to each other
				var _x = padding_left;
				for(var _j = 0; _j < ds_list_size(_children_in_row); _j++) {
					var _child = ds_list_find_value(_children_in_row, _j);
					_child.x = _x + _child.margin_left;
					_child.update();
					_x += _child.margin_left + _child.width + _child.margin_right;
				}
				
			break;
		}
	}
	ds_list_destroy(_rows);
	
}

/**
 * Layouts the text according to the set text variables in the element
 * @ignore
 */
function layout_text() {
	if(string_length(text_content) <= 0) return;
	draw_set_font(text_font);
	text_width = string_width(text_content);
	text_height = string_height(text_content);
	
	if(text_overflow == UI_TEXT_OVERFLOW.EXTEND) {	
		if(max_width != undefined) {
			// Break text on maximum width
			text_content = break_text(text_content, max_width - padding_left - padding_right);
			text_width = string_width(text_content);
			text_height = string_height(text_content);
		}
		
		// Extend the dimensions by the text width and height
		var _text_w = 0;
		if(text_halign == fa_left or text_halign == fa_right) {
			_text_w = text_x_offset + padding_left + text_width + padding_right
		} else if(text_halign == fa_center) {
			_text_w = padding_left + text_width + padding_right;
		}
		width = max(width, _text_w);
		height = max(height, text_y_offset + padding_top + text_height + padding_bottom);
	}
}

/** 
* Automatically offsets the text to the correct position with the given horizontal alignment
*/
function draw_text_aligned_on_box(_text) {
	var _y = 0;
	var _x = 0;
	draw_set_halign(text_halign);
	draw_set_valign(text_valign);
	
	switch(text_valign) {
		case fa_top: _y += 0 + padding_top; break;
		case fa_middle : _y += height/2; break;
		case fa_bottom : _y += height - padding_bottom; break;
	}
	
	switch(text_halign) {
		case fa_left:
			draw_text_transformed(_x + padding_left, _y, _text, 1, 1, 0);
			break;
			
		case fa_center:
			draw_text_transformed(width/2, _y, _text, 1, 1, 0);
			break;
			
		case fa_right:
			draw_text_transformed(_x + width - padding_right, _y, _text, 1, 1, 0);
			break;
	}
}

/**
 * Paints self and all children
 */
function paint() {
	if(!redraw_in_next_frame) return;
	surface_set_target(surface);
		
		draw_clear_alpha(c_white, 0);
		if(!hidden) {
			gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one);
			
			//	Draw Background
			draw_set_colour(bg_color);
			draw_set_alpha(bg_alpha);
			draw_rectangle(0, 0, width, height, false);
			draw_set_alpha(1);
		
			//	Draw Background Image
			draw_sprite_fitted(bg_image, image_index, 0, 0, width, height, image_fit);
			
			// Draw Text
			draw_set_colour(text_color);
			draw_set_font(text_font);
			draw_text_aligned_on_box(text_content);
			// Draw outlines
			draw_set_colour(outline_color);
			// Drawing rectangles seems to behave differently whether or not the target is a browser-canvas
			// We need to add offsets to the draw process to properly account for that
			
			if(os_browser == browser_not_a_browser) {
				// Left
				if(outline_left_strength) draw_rectangle(0, 0, outline_left_strength - 1, height, false);
				// Right
				if(outline_right_strength) draw_rectangle(width, 0, width - outline_right_strength-1, height, false);
				// Top
				if(outline_top_strength) draw_rectangle(0, 0, width, outline_top_strength - 1, false);
				// Bottom
				if(outline_bottom_strength) draw_rectangle(0, height, width, height-outline_bottom_strength-1, false);
			} else {
				// Left
				if(outline_left_strength) draw_rectangle(0, 0, outline_left_strength, height, false);
				// Right
				if(outline_right_strength) draw_rectangle(width, 0, width - outline_right_strength, height, false);
				// Top
				if(outline_top_strength) draw_rectangle(0, 0, width, outline_top_strength, false);
				// Bottom
				if(outline_bottom_strength) draw_rectangle(0, height, width, height-outline_bottom_strength, false);
			}
		}
		gpu_set_blendmode(bm_normal)
	surface_reset_target();

	// Draw all children first
	for(var _i = 0; _i < ds_list_size(children); _i++) {
		with(ds_list_find_value(children, _i)) {
			event_perform(ev_draw, ev_gui);
		}
	}
	draw_set_colour(c_white);
	redraw_in_next_frame = false;
}

// PUBLIC FUNCTIONS

/**
 * Layouts the children and text, updates the dimension and triggers a redraw.
 */
function update() {
	
	var _minimal_width = max(padding_left + padding_right, min_width);
	if(parent != noone) {
		if(parent.justify_content == UI_JUSTIFY_CONTENT.FILL_WIDTH) {
			width = max(_minimal_width, width);
		} else {
			width = _minimal_width;	
		}
	} else {
		width = _minimal_width;	
	}
	


	height = max(padding_top + padding_bottom, min_height);
	layout_children();
	layout_text();	
	
	if(max_width != undefined) {
		width = min(width, max_width);
	}
	if(max_height != undefined) {
		height = min(height, max_height);	
	}
	redraw_in_next_frame = true;
}

/**
 * Declares an element as a child of this element. Updates this element and all its children.
 * @param {id.instance} _ui_element  obj_gm_ui_element or descendant of obj_gm_ui_element
 */
function add_child(_ui_element) {
	if(!object_is_ancestor(_ui_element.object_index, obj_gm_ui_element) and _ui_element.object_index != obj_gm_ui_element) {
		throw (NOT_AN_UI_ELEMENT_ERROR);
	} else {
		ds_list_add(children, _ui_element);
		_ui_element.parent = self;
		update();
	}
}

/**
 * Declares each entry of an array of elements as a child of this element. Updates this element and all its children.
 * @param {Array} _ui_elements  Array of obj_gm_ui_element or descendant of obj_gm_ui_element
 */
function add_childs(_ui_elements) {
	for(var _i = 0; _i < array_length(_ui_elements); _i++) {
		var _ui_element = array_get(_ui_elements, _i);
		add_child(_ui_element);
	}
}
	
/**
 * Adds a function to the event-map, which will get executed when the defined event is triggered.
 * @param {Constant.Enum} _event_type Enum of UI_EVENT
 * @param {Function} _func Function with an obj_gm_ui_element or descendant of obj_gm_ui_element as the first parameter
 */
function add_event_callback(_event_type, _func) {
	var _list = ds_map_find_value(event_callbacks, _event_type);
	if(is_undefined(_list)) {
		_list = ds_list_create();
	}
	ds_list_add(_list, _func);
	ds_map_replace(event_callbacks, _event_type, _list);
}

/**
 * Executes all functions in the event-map for the defined event and gives itself as the first parameter.
 * @param {Constant.Enum} _event_type Enum of UI_EVENT
 */
function execute_event_callbacks(_event_type) {
	var _list = ds_map_find_value(event_callbacks, _event_type);
	if(!is_undefined(_list)) {
		for(var _i = 0; _i < ds_list_size(_list); _i++) {
			ds_list_find_value(_list, _i)(self);
		}
	}
}

/**
 * Checks whether the mouse is inside the current element and all of its parents and returns the result
 * @returns {bool} 
 */
function mouse_in_element() {
	var _parent = parent;
	var _in_rectangle = true;
	while(_parent != noone) {
		with(_parent) {
			if(!point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), room_x, room_y, room_x + width, room_y + height)) {
				_in_rectangle = false;	
			}
		}
		_parent = _parent.parent;
	}
	if(!point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), room_x, room_y, room_x + width, room_y + height)) {
		_in_rectangle = false;	
	}
	return _in_rectangle;
}

/**
 * Sets the margin for all sides of this element
 * @param {real} _amount The margin on all sides of this element
 */
function set_margin(_amount) {
	margin_top = _amount;
	margin_right = _amount;
	margin_bottom = _amount;
	margin_left = _amount;
}

/**
 * Sets the padding for all sides of this element
 * @param {real} _amount The padding on all sides of this element
 */
function set_padding(_amount) {
	padding_top = _amount;
	padding_right = _amount;
	padding_bottom = _amount;
	padding_left = _amount;
}

/**
 * Sets whether the element is hidden or not. Triggers a redraw in the next frame for self and all children
 * @param {bool} _visible The visibility of the element
 */
function set_visibility(_visible) {
	hidden = _visible;
	redraw_in_next_frame = true;
	for(var _i = 0; _i < array_length(children); _i++) {
		var _ui_element = array_get(children, _i);
		_ui_element.set_visibility(_visible);
	}
}

/**
 * Sets whether the element and all its children are disabled or not. Triggers a redraw in the next frame for self and all children
 * @param {bool} _disabled Wheter the element is disabled
 */
function set_disabled(_disabled) {
	disabled = _disabled;
	if(disabled) {
		execute_event_callbacks(UI_EVENT.ON_DISABLE);	
	} else {
		execute_event_callbacks(UI_EVENT.ON_ENABLE);	
	}
	redraw_in_next_frame = true;
	for(var _i = 0; _i < array_length(children); _i++) {
		var _ui_element = array_get(children, _i);
		_ui_element.set_disabled(_disabled);
	}
}