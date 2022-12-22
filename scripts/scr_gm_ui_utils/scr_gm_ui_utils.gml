/** 
* Automatically offsets the text to the correct position with the given horizontal alignment
* @param {real} _x x of the box
* @param {real} _y y of the box
* @param {real} _width width of the box
* @param {real} _height height of the box
* @param {string} _text text string
* @param {constant.halign} _halign horizontal alignment of the text
* @param {constant.valign} _valign vertical alignment of the text
*/
function draw_text_aligned_on_box(_x, _y, _width, _height, _text, _halign, _valign) {
	draw_set_halign(_halign);
	draw_set_valign(_valign);
	
	switch(_valign) {
		case fa_top: _y += 0; break;
		case fa_middle : _y += height/2; break;
		case fa_bottom : _y += height; break;
	}
	
	switch(_halign) {
		case fa_left:
			draw_text_transformed(_x, _y, _text, 1, 1, 0);
			break;
			
		case fa_center:
			draw_text_transformed(_width/2, _y, _text, 1, 1, 0);
			break;
			
		case fa_right:
			draw_text_transformed(_x + _width, _y, _text, 1, 1, 0);
			break;
	}
}

/**
 * Breaks the given text when exceeding the maximum width
 * Taken from: https://www.gmlscripts.com/script/string_wordwrap_width
 * @param {string} _text The text to break
 * @param {real} _max_width The maximal width at which to break the text
 * @returns {string} The wrapped the text
 */
function break_text(_text, _max_width) {
	var _pos_space, _pos_current, _text_current, _text_output;
	var _line_break = "\n"
    _pos_space = -1;
    _pos_current = 1;
    _text_current = _text;
    _text_output = "";
	
    while (string_length(_text_current) >= _pos_current) {
        if (string_width(string_copy(_text_current, 1, _pos_current)) > _max_width) {
            // If there is a space in this line then we can break there
            if (_pos_space != -1) {
                _text_output += string_copy(_text_current, 1, _pos_space) + _line_break;
                // Remove the text we just looked at from the current text string
                _text_current = string_copy(_text_current, _pos_space + 1, string_length(_text_current) - (_pos_space));
                _pos_current = 1;
                _pos_space = -1;
            } else {
                // If not, we can force line breaks
                _text_output += string_copy(_text_current, 1, _pos_current - 1) + _line_break;
                // Remove the text we just looked at from the current text string
                _text_current = string_copy(_text_current, _pos_current, string_length(_text_current) - (_pos_current - 1));
                _pos_current = 1;
                _pos_space = -1;
            }
        }
		if (string_char_at(_text_current, _pos_current) == " ") _pos_space = _pos_current;
        _pos_current += 1;
    }
    if (string_length(_text_current) > 0) _text_output += _text_current;
    return _text_output;
}

/**
 * Resizes and draws an image with the given fitting method
 * @param {asset.gmsprite} _image Image to draw
 * @param {real} _image_index Image index for animation
 * @param {real} _x Horizontal position of the box to fit the image to
 * @param {real} _y Vertical position of the box to fit the image to
 * @param {real} _width Width of the box to fit the image to
 * @param {real} _height Height of the box to fit the image to
 * @param {UI_IMAGE_FIT} _fitting_style Enum: ImageFit
 */
function draw_sprite_fitted(_image, _image_index, _x, _y, _width, _height, _fitting_style) {
	if(!sprite_exists(_image)) return;
	
	switch(_fitting_style) {
		case UI_IMAGE_FIT.STATIC:
			draw_sprite(_image, _image_index, _x, _y);
			break;
				
		case UI_IMAGE_FIT.KEEP_ASPECT:
			var _w = sprite_get_width(_image);
			var _h = sprite_get_height(_image);
			var _w_factor = _width / _w;
			var _h_factor = _height / _h;
			draw_sprite_stretched(_image, _image_index, _x, _x, _w * min(_w_factor, _h_factor), _h * min(_w_factor, _h_factor));
			break;
				
		case UI_IMAGE_FIT.SCALED:
			draw_sprite_stretched(_image, _image_index, _x, _y, _width, _height);
			break;
	}
}