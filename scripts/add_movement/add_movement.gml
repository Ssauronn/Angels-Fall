///@function Add Movement
///@argument0 MaxSpeed
///@argument1 Acceleration
///@argument2 Direction

var max_speed_ = argument0;
var acceleration_ = argument1;
var direction_ = argument2;

var x_speed_ = lengthdir_x(currentSpeed, currentDirection);
var y_speed_ = lengthdir_y(currentSpeed, currentDirection);
var x_acceleration_ = lengthdir_x(acceleration_, direction_);
var y_acceleration_ = lengthdir_y(acceleration_, direction_);

{
	if (sign(x_speed_) == 1) && !key_right {
		x_speed_ = approach_number(x_speed_, 0, frictionAmount);
	}
	else if (sign(x_speed_) == -1) && !key_left {
		x_speed_ = approach_number(x_speed_, 0, frictionAmount);
	}
	else {
		x_speed_ += x_acceleration_;
	}
}
{
	if (sign(y_speed_) == 1) && !key_down {
		y_speed_ = approach_number(y_speed_, 0, frictionAmount);
	}
	else if (sign(y_speed_) == -1) && !key_up {
		y_speed_ = approach_number(y_speed_, 0, frictionAmount);
	}
	else {
		y_speed_ += y_acceleration_;
	}
}
currentSpeed = point_distance(0, 0, x_speed_, y_speed_);
currentDirection = point_direction(0, 0, x_speed_, y_speed_);
// Instead of just setting currentSpeed = min(currentSpeed, max_speed_), I apply a slow down effect
// to the player if the player gets above normal movement speed. This is to avoid jerky slowdowns,
// instead slowly but surely slowing down to the max movement speed possible.
// I subtract currentSpeed by acceleration_ times a multiple. Change the multiple to 1, i.e. 
// subtracting currentSpeed by the value being added to it every frame will keep the player at their
// current speed for as long as they hold down the movement button. Increasing the multiple above 1
// will decrease player currentSpeed while above max_speed_, and decreasing the multiple below 1
// will increase player currentSpeed while above max_speed_.
if currentSpeed > max_speed_ {
	if playerRecentlyDashed {
		currentSpeed -= acceleration_ * 1.1;
	}
	else {
		currentSpeed = max_speed_;
	}
}
else {
	currentSpeed = min(currentSpeed, max_speed_);
	playerRecentlyDashed = false;
}


