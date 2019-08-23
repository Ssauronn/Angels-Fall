///@description Teleport to the location that's closest to the desired location, that won't cause a
// collision with another object. At the end, the script returns a value of 0 if teleportation could
// be successfully achieved without editing the given target location. Otherwise, it returns a value
// between 0 and 3 inclusive: 0 if the target location wasn't changed between preset 90 degree angle
// sections (up right, up left, down left, and bottom right), and an additional digit added for each
// individual new preset 90 degree angle section the new target was moved to, rotating counter
// clockwise.
///@argument0 TargetX
///@argument1 TargetY
///@argument2 OriginOfCircleX - the origin of the circle this function will work around, starting
// at the TargetX and TargetY, and alternating between above and below along that circle until a 
// free point is found
///@argument3 OriginOfCircleY - the origin of the circle this function will work around, starting
// at the TargetX and TargetY, and alternating between above and below along that circle until a 
// free point is found
///@argument4 CollisionObject(s)...


/// SET UP VARIABLES
var target_x_ = argument[0];
var target_y_ = argument[1];
var circle_x_ = argument[2];
var circle_y_ = argument[3];
// If there's collision objects listed, set up the collision object list and get ready to check
// for alternate safe locations to teleport to.
var collision_objects_ = noone;
if argument_count > 4 {
	var radius_of_target_circle_ = point_distance(target_x_, target_y_, circle_x_, circle_y_);
	var current_target_x_ = target_x_;
	var current_target_y_ = target_y_;
	var point_direction_to_target_ = point_direction(circle_x_, circle_y_, target_x_, target_y_);
	var point_direction_to_current_target_ = point_direction(circle_x_, circle_y_, current_target_x_, current_target_y_);
	var j;
	collision_objects_ = ds_list_create();
	for (j = 0; j < (argument_count - 4); j++) {
		ds_list_add(collision_objects_, argument[j + 4]);
	}
}
// Else if there are no collision objects listed, this means there's nothing to worry about and I
// can directly teleport the object calling this script to the target location.
else {
	x = target_x_;
	y = target_y_;
	return 0;
}


/// TELEPORT OBJECT
var i;
var original_target_quadrant_;
var current_target_quadrant_;
if (point_direction_to_target_ <= 45 && point_direction_to_target_ >= 0) || (point_direction_to_target_ > 315 && point_direction_to_target_ < 360) {
	original_target_quadrant_ = 0;
}
else if point_direction_to_target_ > 45 && point_direction_to_target_ <= 135 {
	original_target_quadrant_ = 1;
}
else if point_direction_to_target_ > 135 && point_direction_to_target_ <= 225 {
	original_target_quadrant_ = 2;
}
else if point_direction_to_target_ > 225 && point_direction_to_target_ <= 315 {
	original_target_quadrant_ = 3;
}
var collision_found_;
for (i = 0; i < 360; i++) {
	collision_found_ = false;
	var k;
	for (k = 0; k <= ds_list_size(collision_objects_) - 1; k++) {
		var object_colliding_with_ = ds_list_find_value(collision_objects_, k);
		if place_meeting(current_target_x_, current_target_y_, object_colliding_with_) {
			collision_found_ = true;
		}
		if collision_line(x, y, current_target_x_, current_target_y_, obj_wall, true, true) {
			collision_found_ = true;
		}
	}
	if collision_found_ {
		point_direction_to_current_target_++;
		if point_direction_to_current_target_ >= 360 {
			point_direction_to_current_target_ = point_direction_to_current_target_ - 360;
		}
		current_target_x_ = circle_x_ + lengthdir_x(radius_of_target_circle_, point_direction_to_current_target_);
		current_target_y_ = circle_y_ + lengthdir_y(radius_of_target_circle_, point_direction_to_current_target_);
		collision_found_ = false;
	}
	else {
		// Destroy the list before I do anything else to avoid a memory leak
		if ds_exists(collision_objects_, ds_type_list) {
			ds_list_destroy(collision_objects_);
			collision_objects_ = noone;
		}
		// This is built specifically for my game. If the object I'm teleporting is a ground hurtbox, then
		// I should teleport the owner instead. Otherwise, I should just teleport the object itself.
		if variable_instance_exists(self, "owner") {
			if instance_exists(owner) {
				owner.x = current_target_x_;
				owner.y = current_target_y_ - 13;
			}
			else {
				x = current_target_x_;
				y = current_target_y_;
			}
		}
		else {
			x = current_target_x_;
			y = current_target_y_;
		}
		// Set the new current target quadrant, which will be compared against the original
		if (point_direction_to_current_target_ <= 45 && point_direction_to_current_target_ >= 0) || (point_direction_to_current_target_ > 315 && point_direction_to_current_target_ < 360) {
			current_target_quadrant_ = 0;
		}
		else if point_direction_to_current_target_ > 45 && point_direction_to_current_target_ <= 135 {
			current_target_quadrant_ = 1;
		}
		else if point_direction_to_current_target_ > 135 && point_direction_to_current_target_ <= 225 {
			current_target_quadrant_ = 2;
		}
		else if point_direction_to_current_target_ > 225 && point_direction_to_current_target_ <= 315 {
			current_target_quadrant_ = 3;
		}
		// Return the original target quadrant minus the current target quadrant, which will give us a 
		// positive or negative value which can then be added to player or enemy direction to properly
		// move the player/enemy
		return (current_target_quadrant_ - original_target_quadrant_);
		break;
	}
}
if ds_exists(collision_objects_, ds_type_list) {
	ds_list_destroy(collision_objects_);
}


