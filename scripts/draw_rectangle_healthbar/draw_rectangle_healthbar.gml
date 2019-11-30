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
/*
This script draws a rectangle perimeter, with as many or as little segments as you'd like. The more
segments you have, the more segments will appear on each side, although you won't notice that until
segments doesn't match maxSegments. The script will remove each segment, at whatever speed you give it
(entirely depending on how fast you count segments down), starting at whatever angle you give it (0 is
on the right, counting up counterclockwise). It'll also remove the segments in the direction you instruct
it to remove in.
*/

// Set up variables I'll use for most of the script.
var x_, y_, height_, width_, thickness_, max_segments_, segments_, start_angle_, direction_, color_;
var segment_count_for_verticals_, segment_count_for_horizontals_;

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


// The amount of segments on vertical lines that would overlap with segments on vertical lines
// if I didn't exclude them. Think of it like this - if I drew a full line of rectangles on all sides,
// you would have some overlap on the corners, and counting your segments down would cause a hangup on
// the corners. This avoids that problem.
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
// Just like amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_ variable,
// the script may need to completely exclude certain vertical segments. This determines
// what segments to ignore. This only happens because with varying amount of segments,
// and the way my code works, sometimes segments might try to appear when they shouldn't,
// and this variable prevents that.
var amount_of_segments_to_ignore_on_top_of_vertical_lines_, amount_of_segments_to_ignore_on_bottom_of_vertical_lines_;
amount_of_segments_to_ignore_on_top_of_vertical_lines_ = 0;
amount_of_segments_to_ignore_on_bottom_of_vertical_lines_ = 0;
var j, segment_top_y_, segment_bottom_y_;
for (j = 0; j <= segment_count_for_verticals_; j++) {
	segment_top_y_ = y_ + ((j / segment_count_for_verticals_) * height_);
	segment_bottom_y_ = y_ + (((j + 1) / segment_count_for_verticals_) * height_);
	if segment_top_y_ > (y_ + height_ - thickness_) {
		/* I only assign amount_of_segments_to_ignore_on_bottom_of_vertical_lines_ if its currently set to 
		0, because that means it hasn't yet been assigned to a different value. This means I only set it 
		once, and I only set it once because if I keep counting up further and re-setting it, the correct
		value will just get passed over.
		
		Note: When I reference the "bottom" of a line, I'm referencing when iteration_ reaches max value.
		In other words, the "bottom" of side 0 is at the bottom, but the "bottom" of side 2 is at the top.
		Bottom has to do with iteration_, not physical placement.
		*/
		if amount_of_segments_to_ignore_on_bottom_of_vertical_lines_ == 0 {
			// I add 1 to the count, because by the time the above code is activated, its already too late
			// and the segments has passed out of bounds.
			amount_of_segments_to_ignore_on_bottom_of_vertical_lines_ = segment_count_for_verticals_ - j + 1;
		}
	}
	if segment_bottom_y_ < (y_ + thickness_) {
		amount_of_segments_to_ignore_on_top_of_vertical_lines_ = j + 1;
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
	// I count iteration_ only after I verify that I haven't passed the slot where the beginning rectangle
	// should appear, because if I put this before, I might start the rectangle on the slot/segment after
	// the correct one.
	iteration_++;
}


// Actually draw the rectangle healthbar as long as one should be drawn
var starting_for_i_ = iteration_;
if segments_ > 0 {
	for (i = starting_for_i_; i <= segments_; i++) {
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
		// iteration_ works: iteration_ counts up to move the rectangles right on the top, counts up
		// to move the rectangles down on the right, counts up to move the rectangles left on the bottom,
		// and counts up to move the rectangles up on the left.
		
		// START SETTING ALL OF THE VARIABLES BELOW CORRECTLY USING ALL NEW VARIABLES.
		
		if starting_side_ == 0 {
			if iteration_ > (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_) {
				iteration_ = amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 3;
			}
			else if iteration_ < (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_) {
				iteration_ = segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 1;
			}
		}
		else if starting_side_ == 1 {
			if iteration_ > (segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
				iteration_ = (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_);
				starting_side_ = 0;
			}
			else if iteration_ < amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_ {
				iteration_ = (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_);
				starting_side_ = 2;
			}
		}
		else if starting_side_ == 2 {
			if iteration_ > (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_) {
				iteration_ = amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 1;
			}
			else if iteration_ < (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_) {
				iteration_ = segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_;
				starting_side_ = 3;
			}
		}
		else if starting_side_ == 3 {
			if iteration_ > (segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
				iteration_ = (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_);
				starting_side_ = 2;
			}
			else if iteration_ < amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_ {
				iteration_ = (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_);
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
				if (segment_top_y_ > y_) && (iteration_ == (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_)) {
					segment_top_y_ = y_;
				}
				if (segment_bottom_y_ < (y_ + height_)) && (iteration_ == (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_)) {
					segment_bottom_y_ = y_ + height_;
				}
				// As long as the boxes are within bounds, draw the boxes.
				if (segment_top_y_ < (y_ + height_)) && (segment_bottom_y_ > y_) {
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
			case 1: 
				segment_left_x_ = x_ + ((iteration_ / segment_count_for_horizontals_) * width_);
				segment_top_y_ = y_;
				segment_right_x_ = x_ + (((iteration_ + 1) / segment_count_for_horizontals_) * width_);
				segment_bottom_y_ = (y_ + thickness_);
				// Stop boxes from being drawn out of bounds by editting the size if needed.
				if segment_left_x_ < (x_ + thickness_) {
					segment_left_x_ = (x_ + thickness_);
				}
				if segment_right_x_ > (x_ + width_ - thickness_) {
					segment_right_x_ = (x_ + width_ - thickness_);
				}
				// Stop awkward boxes from being drawn if they don't match correct dimensions.
				if (segment_left_x_ > (x_ + thickness_)) && (iteration_ == amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
					segment_left_x_ = (x_ + thickness_);
				}
				if (segment_right_x_ < (x_ + width_ - thickness_)) && (iteration_ == segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
					segment_right_x_ = (x_ + width_ - thickness_);
				}
				// As long as the boxes are within bounds, draw the boxes.
				if (segment_left_x_ < (x_ + width_)) && (segment_right_x_ >= x_) {
					draw_primitive_begin(pr_trianglestrip);
					draw_vertex(segment_left_x_, segment_top_y_);
					draw_vertex(segment_left_x_, segment_bottom_y_);
					draw_vertex(segment_right_x_, segment_top_y_);
					draw_vertex(segment_right_x_, segment_bottom_y_);
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
				// Stop awkward boxes from being drawn if they don't match correct dimensions.
				if (segment_top_y_ >= y_) && (iteration_ == (segment_count_for_verticals_ - amount_of_segments_to_ignore_on_bottom_of_vertical_lines_)) {
					segment_top_y_ = y_;
				}
				if (segment_bottom_y_ <= (y_ + height_)) && (iteration_ == (0 + amount_of_segments_to_ignore_on_top_of_vertical_lines_)) {
					segment_bottom_y_ = y_ + height_;
				}
				// As long as the boxes are within bounds, draw the boxes.
				if (segment_top_y_ < (y_ + height_)) && (segment_bottom_y_ > y_) {
					draw_primitive_begin(pr_trianglestrip);
					draw_vertex(segment_left_x_, segment_top_y_);
					draw_vertex(segment_left_x_, segment_bottom_y_);
					draw_vertex(segment_right_x_, segment_top_y_);
					draw_vertex(segment_right_x_, segment_bottom_y_);
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
				if segment_left_x_ < (x_ + thickness_) {
					segment_left_x_ = (x_ + thickness_);
				}
				if segment_right_x_ > (x_ + width_ - thickness_) {
					segment_right_x_ = (x_ + width_ - thickness_);
				}
				// Stop awkward boxes from being drawn if they don't match correct dimensions.
				if (segment_left_x_ > (x_ + thickness_)) && (iteration_ == segment_count_for_horizontals_ - amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
					segment_left_x_ = (x_ + thickness_);
				}
				if (segment_right_x_ < (x_ + width_ - thickness_)) && (iteration_ == amount_of_segments_to_ignore_on_each_side_of_horizontal_lines_) {
					segment_right_x_ = (x_ + width_ - thickness_);
				}
				// As long as the boxes are within bounds, draw the boxes.
				if (segment_left_x_ <= (x_ + width_ - thickness_)) && (segment_right_x_ > (x_ + thickness_)) {
					draw_primitive_begin(pr_trianglestrip);
					draw_vertex(segment_left_x_, segment_top_y_);
					draw_vertex(segment_left_x_, segment_bottom_y_);
					draw_vertex(segment_right_x_, segment_top_y_);
					draw_vertex(segment_right_x_, segment_bottom_y_);
					draw_primitive_end();
				}
				break;
		}
	}
}


