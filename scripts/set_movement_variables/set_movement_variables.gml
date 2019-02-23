///argument0 NewSpeed
///argument1 NewDirection
///argument2 MaxSpeed

var new_speed_ = argument0;
var new_direction_ = argument1;
var max_speed_ = argument2;

if new_speed_ > max_speed_ {
	new_speed_ = max_speed_;
}

currentSpeed = new_speed_;
currentDirection = new_direction_;


