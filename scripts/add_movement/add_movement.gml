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

#region Adding to: Player Movement
if self.object_index == obj_player {
	#region X Axis Movement
	// If the object movement in the x axis is positive and the right button is not held down, 
	// apply friction
	if (sign(x_speed_) == 1) && !key_right {
		x_speed_ = approach_number(x_speed_, 0, frictionAmount);
	}
	// Else if the object movement in the x axis is negative and the left button is not held down, 
	// apply friction
	else if (sign(x_speed_) == -1) && !key_left {
		x_speed_ = approach_number(x_speed_, 0, frictionAmount);
	}
	// Else if neither above are true, then the object must be executing movements in a direction 
	// not equal to the current direction, and so apply acceleration to that object.
	else {
		x_speed_ += x_acceleration_;
	}
	#endregion
	#region Y Axis Movement
	// If the object movement in the y axis is positive and the down button is not held down,
	// apply friction
	if (sign(y_speed_) == 1) && !key_down {
		y_speed_ = approach_number(y_speed_, 0, frictionAmount);
	}
	// Else if the object movement in the y axis is negative and the up button is not held down,
	// apply friction
	else if (sign(y_speed_) == -1) && !key_up {
		y_speed_ = approach_number(y_speed_, 0, frictionAmount);
	}
	// Else if neither above are true, then the object must be executing movements in a direction
	// not equal to the current direction, and so apply acceleration to that object.
	else {
		y_speed_ += y_acceleration_;
	}
	#endregion
}
#endregion
#region Adding to: Enemy Movement (obselete, staying in for legacy code purposes)
// If the object calling this script is an enemy or boss
if self.object_index != obj_player {
	// If the object calling this script is not explicitely trying to heal a target
	if weightAtWhichEnemyIsCurrentlyFocusingTargetAt >= weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt {
		var target_ = currentTargetToFocus;
	}
	else {
		var target_ = currentTargetToHeal
	}
	// If the object calling this has a focus target
	if instance_exists(target_) {
		#region X Axis Movement
		// If the object movement in the x axis is positive and the target's x location is not in the
		// positive x direction, apply friction
		if (sign(x_speed_) == 1) && (sign(target_.x - x) != 1) {
			x_speed_ = approach_number(x_speed_, 0, frictionAmount);
		}
		// If the object movement in the x axis is negative and the target's x location is not in the
		// negative x direction, apply friction
		else if (sign(x_speed_) == -1) && (sign(target_.x - x)!= -1) {
			x_speed_ = approach_number(x_speed_, 0, frictionAmount);
		}
		// Else if neither above are true, then the object needs to be executing movements in a direction 
		// not equal to the current direction, and so apply acceleration to that object.
		else {
			x_speed_ += x_acceleration_;
		}
		#endregion
		#region Y Axis Movement
		// If the object movement in the y axis is positive and the down button is not held down,
		// apply friction
		if (sign(y_speed_) == 1) && (sign(target_.y - y) != 1) {
			y_speed_ = approach_number(y_speed_, 0, frictionAmount);
		}
		// Else if the object movement in the y axis is negative and the up button is not held down,
		// apply friction
		else if (sign(y_speed_) == -1) && (sign(target_.y - y) != -1) {
			y_speed_ = approach_number(y_speed_, 0, frictionAmount);
		}
		// Else if neither above are true, then the object must be executing movements in a direction
		// not equal to the current direction, and so apply acceleration to that object.
		else {
			y_speed_ += y_acceleration_;
		}
	}
	#endregion
}
#endregion
// Set new currentSpeed and currentDirection based on the executed inputs for this frame
currentSpeed = point_distance(0, 0, x_speed_, y_speed_);
currentDirection = point_direction(0, 0, x_speed_, y_speed_);
/*
Instead of just setting currentSpeed = min(currentSpeed, max_speed_), I apply a slow down effect
to the player if the object gets above normal movement speed. This is to avoid jerky slowdowns,
instead slowly but surely slowing down to the max movement speed possible.
I subtract currentSpeed by acceleration_ times a multiple. Change the multiple to 1, i.e. 
subtracting currentSpeed by the value being added to it every frame will keep the object at their
current speed for as long as they hold down the movement button. Increasing the multiple above 1
will decrease object currentSpeed while above max_speed_, and decreasing the multiple below 1
will increase object currentSpeed while above max_speed_.
However, if I always subtract acceleration from the current speed, the player object looks jumpy while
moving around. To fix this, I first check to see if there's a movement key held down, and if so, as long
as no other movement key is held that would cancel the movement of the first, then I auto-set the current
speed to the max possible speed.
*/
if self.object_index == obj_player {
	if currentSpeed > max_speed_ {
		if !key_nokey {
			if (key_right && !key_left) || (key_up && !key_down) || (key_left && !key_right) || (key_down && !key_up) {
				currentSpeed = max_speed_;
			}
		}
		else if (playerRecentlyDashed) {
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
}
else {
	if currentSpeed > max_speed_ {
		currentSpeed = max_speed_;
	}
	currentSpeed = min(currentSpeed, max_speed_);
}


