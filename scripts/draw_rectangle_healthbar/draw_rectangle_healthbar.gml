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

//draw_rectangle_healthbar(x, y, radius, thickness, maxSegments, segments, startAngle, totalAngle, direction, color);

var x_, y_, height_, width_, thickness_, max_segments_, segments_, start_angle_, direction_, color_;
var segment_count_for_verticals_, segment_count_for_horizontals_, segment_width_for_verticals_, segment_height_for_verticals_, segment_width_for_horizontals_, segment_height_for_horizontals_;

x_ = argument0;
y_ = argument1;
height_ = argument2;
width_ = argument3;
thickness_ = argument4;
max_segments_ = argument5;
if max_segments_ < 4 {
	max_segments_ = 4;
}
segments_ = argument6;
if segments_ > max_segments_ {
	segments_ = max_segments_;
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

// The amount of rectangles on each side. verticals are the right and left sides, and horizontals are the
// top and bottom sides.
segment_count_for_verticals_ = round(height_ * (max_segments_ / ((height_ * 2) + (width_ * 2))));
if segment_count_for_verticals_ == 0 {
	segment_count_for_verticals_ = 1;
}
segment_count_for_horizontals_ = round(width_ * (max_segments_ / ((height_ * 2) + (width_ * 2))));
if segment_count_for_horizontals_ <= 0 {
	segment_count_for_horizontals_ = 1;
}

// The dimensions of all the rectangles on each side.
segment_height_for_horizontals_ = thickness_;
segment_width_for_horizontals_ = floor(width_ / segment_count_for_horizontals_);
segment_height_for_verticals_ = floor(height_ / segment_count_for_verticals_);
segment_width_for_verticals_ = thickness_;

// The amount of segments on vertical lines that would overlap with segments on vertical lines
// if I didn't exclude them.
var amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
var k;
for (k = 0; k <= segment_count_for_horizontals_; k++) {
	if (k * (width_ / segment_count_for_horizontals_)) > thickness_ {
		amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_ = k;
		// If it isn't an even number, then reduce it to an even number, so that each side has equal
		// parts missing.
		if amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_ % 2 != 0 {
			amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_--;
		}
		break;
	}
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
	iteration_++;
}

// Actually draw the rectangle healthbar as long as one should be drawn
if segments_ > 0 {
	for (i = 0; i <= segments_; i++) {
		// Determine whether to move counterclockwise or clockwise, respectively, based on the 
		// direction_ given.
		switch direction_ {
			case 0: iteration_--;
				break;
			case 1: iteration_++;
				break;
		}
		// Make sure the iteration_ doesn't exceed the amount of segments on one side and if it does,
		// rotate the variables that control where to draw the next rectangle. The way the sides and 
		// iteration_ works: iteration_ counts up to move the rectangles drawn down on vertical sides,
		// and counts up to move the rectangles drawn right on horizontal sides.
		if starting_side_ == 0 {
			if iteration_ >= segment_count_for_verticals_ {
				iteration_ = 0;
				starting_side_ = 3;
			}
			else if iteration_ <= 0 {
				iteration_ = segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 1;
			}
		}
		else if starting_side_ == 1 {
			if iteration_ >= (segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
				iteration_ = 0;
				starting_side_ = 0;
			}
			else if iteration_ <= 0 {
				iteration_ = segment_count_for_verticals_;
				starting_side_ = 2;
			}
		}
		else if starting_side_ == 2 {
			if iteration_ >= segment_count_for_verticals_ {
				iteration_ = amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 1;
			}
			else if iteration_ <= 0 {
				iteration_ = segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 3;
			}
		}
		else if starting_side_ == 3 {
			if iteration_ >= (segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
				iteration_ = 0;
				starting_side_ = 2;
			}
			else if iteration_ <= 0 {
				iteration_ = segment_count_for_verticals_;
				starting_side_ = 0;
			}
		}
		
		// Finally, after rotating all the correct variables and setting the new iteration_, draw
		// the next rectangle.
		var segment_left_x_, segment_top_y_, segment_right_x_, segment_bottom_y_;
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
					segment_bottom_y_ = y_ + height_;
				}
				// Stop awkward boxes from being drawn if they don't match correct dimensions.
				if (segment_top_y_ > y_) && ((iteration_ == 0) || (iteration_ == segment_count_for_verticals_)) {
					segment_top_y_ = y_;
				}
				if (segment_bottom_y_ < (y_ + height_)) && ((iteration_ == 0) || (iteration_ == segment_count_for_verticals_)) {
					segment_bottom_y_ = y_ + height_;
				}
				// As long as the boxes are within bounds, draw the boxes.
				if (segment_top_y_ < (y_ + height_ - thickness_)) && (segment_bottom_y_ > y_ + thickness_) {
					draw_primitive_begin(pr_trianglestrip);
					draw_vertex(segment_left_x_, segment_top_y_);
					draw_vertex(segment_left_x_, segment_bottom_y_);
					draw_vertex(segment_right_x_, segment_top_y_);
					draw_vertex(segment_right_x_, segment_bottom_y_);
					draw_primitive_end();
				}
				break;
			// The top side, a horizontal set of rectangle segments. Starting at the top left moving
			// right.
			/*case 1: 
				segment_left_x_ = x_ + ((iteration_ / segment_count_for_horizontals_) * width_);
				segment_top_y_ = y_;
				segment_right_x_ = x_ + (((iteration_ + 1) / segment_count_for_horizontals_) * width_);
				segment_bottom_y_ = y_ + thickness_;
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex(segment_left_x_, segment_top_y_);
				draw_vertex(segment_left_x_, segment_bottom_y_);
				draw_vertex(segment_right_x_, segment_top_y_);
				draw_vertex(segment_right_x_, segment_bottom_y_);
				draw_primitive_end();
				break;*/
			// The left side, a vertical set of rectangle segments. Starting at the bottom moving up.
			case 2: 
				segment_left_x_ = x_;
				segment_top_y_ = y_ + (((segment_count_for_verticals_ - iteration_) / segment_count_for_verticals_) * height_);
				segment_right_x_ = x_ + thickness_;
				segment_bottom_y_ = y_ + ((((segment_count_for_verticals_ - iteration_) + 1) / segment_count_for_verticals_) * height_);
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex(segment_left_x_, segment_top_y_);
				draw_vertex(segment_left_x_, segment_bottom_y_);
				draw_vertex(segment_right_x_, segment_top_y_);
				draw_vertex(segment_right_x_, segment_bottom_y_);
				draw_primitive_end();
				break;
			// The bottom side, a horizontal set of rectangle segments. Starting at the bottom right moving
			// left.
			/*case 3: 
				segment_left_x_ = x_ + (((segment_count_for_horizontals_ - iteration_) / segment_count_for_horizontals_) * width_);
				segment_top_y_ = y_ + height_ - thickness_;
				segment_right_x_ = x_ + ((((segment_count_for_horizontals_ - iteration_) + 1) / segment_count_for_horizontals_) * width_);
				segment_bottom_y_ = y_ + height_;
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex(segment_left_x_, segment_top_y_);
				draw_vertex(segment_left_x_, segment_bottom_y_);
				draw_vertex(segment_right_x_, segment_top_y_);
				draw_vertex(segment_right_x_, segment_bottom_y_);
				draw_primitive_end();
				break;*/
		}
	}
}


