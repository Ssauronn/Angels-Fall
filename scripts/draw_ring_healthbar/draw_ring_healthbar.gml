/// @function draw_ring_healthbar(x, y, radius, thickness, maxSegments, segments, startAngle, totalAngle, direction, color);
/// @param {real} x
/// @param {real} y
/// @param {real} radius
/// @param {real} thickness
/// @param {real} maxSegments
/// @param {real} segments
/// @param {real} startAngle
/// @param {real} totalAngle
/// @param {real} direction
/// @param {} color
function draw_ring_healthbar(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9) {

	//draw_ring_healthbar(x, y, radius, thickness, maxSegments, segments, startAngle, totalAngle, direction, color);
	var x_, y_ , radius_, thickness_, max_segments_, segments_, start_angle_, total_angle_, direction_, color_;
	var i, ax, ay, bx, by, cx, cy, dx, dy;
	
	x_ = argument0;
	y_ = argument1;
	radius_ = argument2;
	thickness_ = argument3;
	max_segments_ = argument4;
	segments_ = argument5;
	start_angle_ = argument6;
	total_angle_ = argument7;
	direction_ = argument8;
	color_ = argument9;

	var angle_change_ = (total_angle_ / max_segments_) * (pi / 180)
	i = start_angle_ * (pi / 180);

	ax = x_ + (cos(i) * radius_);
	ay = y_ - (sin(i) * radius_);

	bx = x_ + (cos(i) * (radius_ + thickness_));
	by = y_ - (sin(i) * (radius_ + thickness_));

	repeat(segments_) {
		i += direction_ * angle_change_;

		cx = x_ + (cos(i) * radius_);
		cy = y_ - (sin(i) * radius_);

		dx = x_ + (cos(i) * (radius_ + thickness_));
		dy = y_ - (sin(i) * (radius_ + thickness_));

		draw_triangle_colour(ax, ay, bx, by, dx, dy, color_, color_, color_, 0);
		draw_triangle_colour(ax, ay, cx, cy, dx, dy, color_, color_, color_, 0);

		ax = cx;
		ay = cy;

		bx = dx;
		by = dy;
	}
}


