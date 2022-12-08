// PRIVATE FUNCTIONS

/**
 * Checks whether the surface does not exist or its dimensions are not equal to the elements dimensions then it creates or resizes accordingly and triggers a redraw.
 * @ignore
 */
function validate_surface() {
	if(!surface_exists(surface)) {
		surface = surface_create(max(1, width), max(1, height));
		redraw_in_next_frame = true;
	} 
	
	if(surface_get_width(surface) != width or surface_get_height(surface) != height) {
		surface_resize(surface, max(1, width), max(1,height));
		redraw_in_next_frame = true;
	}
}

/**
 * Returns whether adding the width to the current elements width would exceed the maximum width specified. If no maximum width is specified the functions always returns false.
 * @param {real} _width The width in pixels to add for the check
 * @returns {bool} Whether the maximum width has been exceeded
 * @ignore
 */
function check_max_width_exceeded(_width) {
	if(max_width != undefined) {
		return (width + _width > max_width);	
	} else {
		return false;	
	}
}

/**
 * Layouts the children of this element and extends its width and height when necessary
 * @ignore
 */
function layout_children() {
	var _x = padding_left;
	var _y = padding_top;
	var _current_row_heighest = 0;
	var _current_row_width = 0;
	
	for(var _i = 0; _i < ds_list_size(children); _i++) {
		var _child = ds_list_find_value(children, _i);
		_child.update();
		var _child_w = _child.margin_left + _child.width + _child.margin_right;
		var _child_h = _child.margin_top + _child.height + _child.margin_bottom;
	
		if(check_max_width_exceeded(_child_w) || flex_direction == UI_FLEX_DIRECTION.VERTICAL) {
			// Layout children vertically
			_x = padding_left;
			_y += _current_row_heighest;
			height += _current_row_heighest;
			_current_row_heighest = 0;
			_current_row_width = _child_w;
		} else {
			// Layout children horizontally
			_current_row_width += _child_w;
		}
	
		_child.x = _x + _child.margin_left;
		_child.y = _y + _child.margin_top;
		_x += _child_w;
		
		if(_child_h > _current_row_heighest) {
			_current_row_heighest = _child_h;	
		}
	
		// Determine the width of this element by the sum of the width of all childrens
		if(_current_row_width > width) {
			width = _current_row_width + padding_left + padding_right;
		}
	}
	height += _current_row_heighest;
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
 * Paints self and all children
 */
function paint() {
	if(!redraw_in_next_frame) return;
	
	surface_set_target(surface);
		draw_clear_alpha(c_white, 0);
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
		draw_text_aligned_on_box(text_x_offset + padding_left, text_y_offset + padding_top, width, height, text_content, text_halign, text_valign);
		// Draw outlines
		draw_set_colour(outline_color);
		// Left
		draw_rectangle(0, 0, outline_left_strength - 1, height, false);
		// Right
		draw_rectangle(width, 0, width - outline_right_strength-1, height, false);
		// Top
		draw_rectangle(0, 0, width, outline_top_strength - 1, false);
		// Bottom
		draw_rectangle(0, height, width, height-outline_bottom_strength-1, false);
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
	width = max(padding_left + padding_right, min_width);
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
			if(!point_in_rectangle(mouse_x, mouse_y, room_x, room_y, room_x + width, room_y + height)) {
				_in_rectangle = false;	
			}
		}
		_parent = _parent.parent;
	}
	if(!point_in_rectangle(mouse_x, mouse_y, room_x, room_y, room_x + width, room_y + height)) {
		_in_rectangle = false;	
	}
	return _in_rectangle;
}