///@argument0 topLeftX
///@argument1 topLeftY
///@argument2 height
///@argument3 width
///@argument4 thickness
///@argument5 maxSegments
///@argument6 segments
///@argument7 startAngle
///@argument8 direction
///@argument9 color
///@argument10 alpha
function draw_rectangle_healthbar(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {

	//draw_rectangle_healthbar(x, y, radius, thickness, maxSegments, segments, startAngle, totalAngle, direction, color);
	/*
	This script draws a rectangle perimeter, with as many or as little segments as you'd like. The more
	segments you have, the more segments will appear on each side, although you won't notice that until
	segments doesn't match maxSegments. The script will remove each segment, at whatever speed you give it
	(entirely depending on how fast you count segments down), starting at whatever angle you give it (0 is
	on the right, counting up counterclockwise). It'll also remove the segments in the direction you instruct
	it to remove in.
	*/

	// Set up variables I'll use for most of the script.
	var x_, y_, height_, width_, thickness_, max_segments_, segments_, start_angle_, direction_, color_, alpha_;
	var segment_count_for_verticals_, segment_count_for_horizontals_;
	var original_max_segments_, original_segments_;

	x_ = argument0;
	y_ = argument1;
	height_ = argument2;
	width_ = argument3;
	thickness_ = argument4;
	max_segments_ = argument5;
	original_max_segments_ = max_segments_;
	segments_ = argument6;
	original_segments_ = segments_;
	if max_segments_ < 4 {
		max_segments_ = 4;
	}
	if max_segments_ % 4 != 3 {
		segments_ += 3 - (max_segments_ % 4);
		max_segments_ += 3 - (max_segments_ % 4);
	}
	if segments_ > max_segments_ {
		segments_ = max_segments_;
	}
	// This adds the perfect amount of segments in case the current segment count is short.
	if height_ != width_ {
		segments_ += 2;
	}
	start_angle_ = argument7;
	while start_angle_ >= 360 {
		start_angle_ -= 360;
	}
	while start_angle_ < 0 {
		start_angle_ += 360;
	}
	direction_ = argument8;
	color_ = argument9;
	alpha_ = argument10;

	if (original_max_segments_ > 0) && (segments_ > 0) {
		// The amount of rectangles on each side. verticals are the right and left sides, and horizontals are the
		// top and bottom sides.
		segment_count_for_verticals_ = floor(height_ * (max_segments_ / ((height_ * 2) + (width_ * 2)))) + 1;
		if segment_count_for_verticals_ == 0 {
			segment_count_for_verticals_ = 1;
		}
		segment_count_for_horizontals_ = floor(width_ * (max_segments_ / ((height_ * 2) + (width_ * 2)))) + 1;
		if segment_count_for_horizontals_ <= 0 {
			segment_count_for_horizontals_ = 1;
		}

		// Get temporary variables used to determine which rectangle to start on.
		var temp_angle_, amount_to_add_, segment_angles_, starting_side_;
		if ((start_angle_ >= 0) && (start_angle_ < 45)) || ((start_angle_ >= 315) && (start_angle_ < 360)) {
			amount_to_add_ = 45;
			segment_angles_ = 90 / segment_count_for_verticals_;
			starting_side_ = 0;
		}
		else if (start_angle_ >= 45) && (start_angle_ < 135) {
			amount_to_add_ = -45;
			segment_angles_ = 90 / segment_count_for_horizontals_;
			starting_side_ = 1;
		}
		else if (start_angle_ >= 135) && (start_angle_ < 225) {
			amount_to_add_ = -135;
			segment_angles_ = 90 / segment_count_for_verticals_;
			starting_side_ = 2;
		}
		else if (start_angle_ >= 225) && (start_angle_ < 315) {
			amount_to_add_ = -225;
			segment_angles_ = 90 / segment_count_for_horizontals_;
			starting_side_ = 3;
		}

		// The angle the player inputted to start out with that we'll work with. temp_angle_ is just that starting
		// angle, modified to be easier to work with.
		temp_angle_ = start_angle_ + amount_to_add_;
		var i, iteration_;
		iteration_ = 0;
		for (i = 90; i > 0; i -= segment_angles_;) {
			// If I've passed the point where the temp_angle_ is at, I know I've found the slot the beginning
			// rectangle should sit in, so immediately break. The variable iteration_ is the rectangle start 
			// on the count, moving clockwise from the starting point on that specific side. 
			if temp_angle_ > i {
				break;
			}
			// I count iteration_ only after I verify that I haven't passed the slot where the beginning rectangle
			// should appear, because if I put this before, I might start the rectangle on the slot/segment after
			// the correct one.
			iteration_++;
		}


		// Actually draw the rectangle healthbar as long as one should be drawn
		var starting_for_i_ = iteration_;
		for (i = starting_for_i_; i <= segments_ + starting_for_i_; i++) {
			// Determine whether to move counterclockwise or clockwise, respectively, based on the 
			// direction_ given.
			switch direction_ {
				case 0: iteration_++;
					break;
				case 1: iteration_--;
					break;
			}
			// Make sure the iteration_ doesn't exceed the amount of segments on one side and if it does,
			// rotate the variables that control where to draw the next rectangle. The way the sides and 
			// iteration_ works: iteration_ counts up to move the rectangles right on the top, counts up
			// to move the rectangles down on the right, counts up to move the rectangles left on the bottom,
			// and counts up to move the rectangles up on the left.
	
			// START SETTING ALL OF THE VARIABLES BELOW CORRECTLY USING ALL NEW VARIABLES.
			switch starting_side_ {
				case 0:
					if iteration_ > segment_count_for_verticals_ {
						iteration_ = 0;
						starting_side_ = 3;
					}
					else if iteration_ < 0 {
						iteration_ = segment_count_for_horizontals_;
						starting_side_ = 1;
					}
					break;
				case 1:
					if iteration_ > segment_count_for_horizontals_ {
						iteration_ = 0;
						starting_side_ = 0;
					}
					else if iteration_ < 0 {
						iteration_ = segment_count_for_verticals_;
						starting_side_ = 2;
					}
					break;
				case 2:
					if iteration_ > segment_count_for_verticals_ {
						iteration_ = 0;
						starting_side_ = 1;
					}
					else if iteration_ < 0 {
						iteration_ = segment_count_for_horizontals_;
						starting_side_ = 3;
					}
					break;
				case 3:
					if iteration_ > segment_count_for_horizontals_ {
						iteration_ = 0;
						starting_side_ = 2;
					}
					else if iteration_ < 0 {
						iteration_ = segment_count_for_verticals_;
						starting_side_ = 0;
					}
					break;
			}
			// Finally, after rotating all the correct variables and setting the new iteration_, draw
			// the next rectangle.
			var segment_left_x_, segment_top_y_, segment_right_x_, segment_bottom_y_, previous_value_;
			switch (starting_side_) {
				// The right side, a vertical set of rectangle segments. Starting at the top moving down.
				case 0: 
					// Assign starting variables
					segment_left_x_ = x_ + width_ - thickness_;
					segment_top_y_ = y_ + ((iteration_ / segment_count_for_verticals_) * height_);
					segment_right_x_ = x_ + width_;
					segment_bottom_y_ = y_ + (((iteration_ + 1) / segment_count_for_verticals_) * height_);
					// Stop boxes from being drawn out of bounds by editting the size if needed.
					if segment_top_y_ < y_ {
						segment_top_y_ = y_;
					}
					if segment_bottom_y_ > (y_ + height_) {
						segment_bottom_y_ = (y_ + height_);
					}
					// Stop boxes that don't need to be drawn from drawing
					while segment_bottom_y_ == y_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_verticals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + width_ - thickness_;
						segment_top_y_ = y_ + ((iteration_ / segment_count_for_verticals_) * height_);
						segment_right_x_ = x_ + width_;
						segment_bottom_y_ = y_ + (((iteration_ + 1) / segment_count_for_verticals_) * height_);
					}
					while segment_top_y_ == y_ + height_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_verticals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + width_ - thickness_;
						segment_top_y_ = y_ + ((iteration_ / segment_count_for_verticals_) * height_);
						segment_right_x_ = x_ + width_;
						segment_bottom_y_ = y_ + (((iteration_ + 1) / segment_count_for_verticals_) * height_);
					}
					// As long as the boxes are within bounds, draw the boxes.
					if (segment_top_y_ <= (y_ + height_)) && (segment_bottom_y_ >= y_) {
						draw_primitive_begin(pr_trianglestrip);
						// Set value
						previous_value_ = segment_top_y_;
						// Here, I set the top to the inner corner if I'm currently drawing behind the top or bottom corners.
						if segment_top_y_ < y_ + thickness_ {
							segment_top_y_ = y_ + thickness_;
						}
						else if segment_top_y_ > y_ + height_ - thickness_{
							segment_top_y_ = y_ + height_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_left_x_, segment_top_y_, color_, alpha_);
						// Reset value
						segment_top_y_ = previous_value_;
						// Set new value
						previous_value_ = segment_bottom_y_;
						// Now, I set the bottom to the inner corner if I'm currently drawing behind the top or bottom corners.
						if segment_bottom_y_ < y_ + thickness_ {
							segment_bottom_y_ = y_ + thickness_;
						}
						else if segment_bottom_y_ > y_ + height_ - thickness_ {
							segment_bottom_y_ = y_ + height_ - thickness_;
						}
						// Draw vertex in question
						draw_vertex_color(segment_left_x_, segment_bottom_y_, color_, alpha_);
						// Reset value
						segment_bottom_y_ = previous_value_;
						// Draw vertexes not on the inner line.
						draw_vertex_color(segment_right_x_, segment_top_y_, color_, alpha_);
						draw_vertex_color(segment_right_x_, segment_bottom_y_, color_, alpha_);
						draw_primitive_end();
					}
					break;
				// The top side, a horizontal set of rectangle segments. Starting at the top left moving
				// right.
				case 1: 
					segment_left_x_ = x_ + ((iteration_ / segment_count_for_horizontals_) * width_);
					segment_top_y_ = y_;
					segment_right_x_ = x_ + (((iteration_ + 1) / segment_count_for_horizontals_) * width_);
					segment_bottom_y_ = (y_ + thickness_);
					// Stop boxes from being drawn out of bounds by editting the size if needed.
					if segment_left_x_ < x_ {
						segment_left_x_ = x_;
					}
					if segment_right_x_ > x_ + width_ {
						segment_right_x_ = x_ + width_;
					}
					// Stop boxes that don't need to be drawn from drawing
					while segment_left_x_ == x_ + width_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_horizontals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + ((iteration_ / segment_count_for_horizontals_) * width_);
						segment_top_y_ = y_;
						segment_right_x_ = x_ + (((iteration_ + 1) / segment_count_for_horizontals_) * width_);
						segment_bottom_y_ = (y_ + thickness_);
					}
					while segment_right_x_ == x_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_horizontals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + ((iteration_ / segment_count_for_horizontals_) * width_);
						segment_top_y_ = y_;
						segment_right_x_ = x_ + (((iteration_ + 1) / segment_count_for_horizontals_) * width_);
						segment_bottom_y_ = (y_ + thickness_);
					}
					// As long as the boxes are within bounds, draw the boxes.
					if (segment_left_x_ <= x_ + width_) && (segment_right_x_ >= x_) {
						draw_primitive_begin(pr_trianglestrip);
						// Draw first vertex
						draw_vertex_color(segment_left_x_, segment_top_y_, color_, alpha_);
						// Set the value
						previous_value_ = segment_left_x_;
						// Set the left value to the inner corner if I'm currently drawing behind the left or right corners.
						if segment_left_x_ < x_ + thickness_ {
							segment_left_x_ = x_ + thickness_;
						}
						if segment_left_x_ > x_ + width_ - thickness_ {
							segment_left_x_ = x_ + width_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_left_x_, segment_bottom_y_, color_, alpha_);
						// Reset value
						segment_left_x_ = previous_value_;
						// Unrelated vertex being drawn
						draw_vertex_color(segment_right_x_, segment_top_y_, color_, alpha_);
						// Set new value
						previous_value_ = segment_right_x_;
						// Set the right value to the inner corner if I'm currently drawing behind the left or right corners.
						if segment_right_x_ < x_ + thickness_ {
							segment_right_x_ = x_ + thickness_;
						}
						if segment_right_x_ > x_ + width_ - thickness_ {
							segment_right_x_ = x_ + width_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_right_x_, segment_bottom_y_, color_, alpha_);
						// Reset value
						segment_right_x_ = previous_value_;
						draw_primitive_end();
					}
					break;
				// The left side, a vertical set of rectangle segments. Starting at the bottom moving up.
				case 2: 
					// Assign starting variables
					segment_left_x_ = x_;
					segment_top_y_ = y_ + (((segment_count_for_verticals_ - iteration_) / segment_count_for_verticals_) * height_);
					segment_right_x_ = x_ + thickness_;
					segment_bottom_y_ = y_ + ((((segment_count_for_verticals_ - iteration_) + 1) / segment_count_for_verticals_) * height_);
					// Stop boxes from being drawn out of bounds by editting the size if needed.
					if segment_top_y_ < y_ {
						segment_top_y_ = y_;
					}
					if segment_bottom_y_ > (y_ + height_) {
						segment_bottom_y_ = (y_ + height_);
					}
					// Stop boxes that don't need to be drawn from drawing
					while segment_bottom_y_ == y_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_verticals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_;
						segment_top_y_ = y_ + (((segment_count_for_verticals_ - iteration_) / segment_count_for_verticals_) * height_);
						segment_right_x_ = x_ + thickness_;
						segment_bottom_y_ = y_ + ((((segment_count_for_verticals_ - iteration_) + 1) / segment_count_for_verticals_) * height_);
					}
					while segment_top_y_ == y_ + height_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_verticals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_;
						segment_top_y_ = y_ + (((segment_count_for_verticals_ - iteration_) / segment_count_for_verticals_) * height_);
						segment_right_x_ = x_ + thickness_;
						segment_bottom_y_ = y_ + ((((segment_count_for_verticals_ - iteration_) + 1) / segment_count_for_verticals_) * height_);
					}
					// As long as the boxes are within bounds, draw the boxes.
					if (segment_top_y_ <= (y_ + height_)) && (segment_bottom_y_ >= y_) {
						draw_primitive_begin(pr_trianglestrip);
						draw_vertex_color(segment_left_x_, segment_top_y_, color_, alpha_);
						draw_vertex_color(segment_left_x_, segment_bottom_y_, color_, alpha_);
						// Set the value
						previous_value_ = segment_top_y_;
						// Set the top value to the inner corner if I'm currently drawing behind the top or bottom corners.
						if segment_top_y_ < y_ + thickness_ {
							segment_top_y_ = y_ + thickness_;
						}
						if segment_top_y_ > y_ + height_ - thickness_ {
							segment_top_y_ = y_ + height_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_right_x_, segment_top_y_, color_, alpha_);
						// Reset value
						segment_top_y_ = previous_value_;
						// Set new value
						previous_value_ = segment_bottom_y_;
						// Set the bottom value to the inner corner if I'm currently drawing behind the top or bottom corners.
						if segment_bottom_y_ < y_ + thickness_ {
							segment_bottom_y_ = y_ + thickness_;
						}
						if segment_bottom_y_ > y_ + height_ - thickness_ {
							segment_bottom_y_ = y_ + height_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_right_x_, segment_bottom_y_, color_, alpha_);
						// Reset value
						segment_bottom_y_ = previous_value_;
						draw_primitive_end();
					}
					break;
				// The bottom side, a horizontal set of rectangle segments. Starting at the bottom right moving
				// left.
				case 3: 
					segment_left_x_ = x_ + (((segment_count_for_horizontals_ - iteration_) / segment_count_for_horizontals_) * width_);
					segment_top_y_ = y_ + height_ - thickness_;
					segment_right_x_ = x_ + ((((segment_count_for_horizontals_ - iteration_) + 1) / segment_count_for_horizontals_) * width_);
					segment_bottom_y_ = y_ + height_;
					// Stop boxes from being drawn out of bounds by editting the size if needed.
					if segment_left_x_ < x_ {
						segment_left_x_ = x_;
					}
					if segment_right_x_ > x_ + width_ {
						segment_right_x_ = x_ + width_;
					}
			
					while segment_left_x_ == x_ + width_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_horizontals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + (((segment_count_for_horizontals_ - iteration_) / segment_count_for_horizontals_) * width_);
						segment_top_y_ = y_ + height_ - thickness_;
						segment_right_x_ = x_ + ((((segment_count_for_horizontals_ - iteration_) + 1) / segment_count_for_horizontals_) * width_);
						segment_bottom_y_ = y_ + height_;
					}
					while segment_right_x_ == x_ {
						if direction_ == 0 {
							iteration_++;
						}
						else if direction_ == 1 {
							iteration_--;
						}
						// If iteration_ has passed the bounds of the line I'm drawing on, move onto drawing a new line
						if (iteration_ > segment_count_for_horizontals_) || (iteration_ < 0) {
							i--;
							break;
						}
						segment_left_x_ = x_ + (((segment_count_for_horizontals_ - iteration_) / segment_count_for_horizontals_) * width_);
						segment_top_y_ = y_ + height_ - thickness_;
						segment_right_x_ = x_ + ((((segment_count_for_horizontals_ - iteration_) + 1) / segment_count_for_horizontals_) * width_);
						segment_bottom_y_ = y_ + height_;
					}
					// As long as the boxes are within bounds, draw the boxes.
					if (segment_left_x_ <= x_ + width_) && (segment_right_x_ >= x_) {
						draw_primitive_begin(pr_trianglestrip);
						// Set the value
						previous_value_ = segment_left_x_;
						// Set the left value to the inner corner if I'm currently drawing behind the left or right corners.
						if segment_left_x_ < x_ + thickness_ {
							segment_left_x_ = x_ + thickness_;
						}
						else if segment_left_x_ > x_ + width_ - thickness_ {
							segment_left_x_ = x_ + width_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_left_x_, segment_top_y_, color_, alpha_);
						// Reset value
						segment_left_x_ = previous_value_;
						// Draw unrelated vertex
						draw_vertex_color(segment_left_x_, segment_bottom_y_, color_, alpha_);
						// Set the new value
						previous_value_ = segment_right_x_;
						// Set the right value to the inner corner if I'm currently drawing behind the left or right corners.
						if segment_right_x_ < x_ + thickness_ {
							segment_right_x_ = x_ + thickness_;
						}
						else if segment_right_x_ > x_ + width_ - thickness_ {
							segment_right_x_ = x_ + width_ - thickness_;
						}
						// Draw the vertex in question
						draw_vertex_color(segment_right_x_, segment_top_y_, color_, alpha_);
						// Reset value
						segment_right_x_ = previous_value_;
						// Draw unrelated Vertex
						draw_vertex_color(segment_right_x_, segment_bottom_y_, color_, alpha_);
						draw_primitive_end();
					}
					break;
			}
		}
	}
	else {
		exit;
	}





}
