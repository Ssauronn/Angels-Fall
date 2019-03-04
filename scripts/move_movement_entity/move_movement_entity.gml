///@argument0 Bounce
var bounce_ = argument0;

#region Moving the Player and the Player's Hurtboxes
if object_index == obj_player {
	// If there's an object within range of the next step of the movement in current speed, reduce
	// current speed.
	for (i = 0; i < array_length_1d(collisionObjects); i++) {
		if (place_meeting(playerGroundHurtbox.x + lengthdir_x(currentSpeed, currentDirection), playerGroundHurtbox.y + lengthdir_y(currentSpeed, currentDirection), collisionObjects[i]) && (!bounce_) && (collisionObjects[i] != self)) {
			currentSpeed = approach_number(currentSpeed, 0, (frictionAmount / 2));
		}
	}

	// Storing the current speeds in the current directions the object is traveling at
	var x_speed_ = lengthdir_x(currentSpeed, currentDirection);
	var y_speed_ = lengthdir_y(currentSpeed, currentDirection);

	// This checks to see if movement is being applied. If not, then we need to exit the script
	// so we don't waste processing power. This currentSpeed is edited in add_movement script before
	// this script is executed, so it'll always correctly determine whether to exit or not.
	if currentSpeed <= 0 {
		exit;
	}

	with (playerGroundHurtbox) {
		var i = 0;
		// Determine if there's a collision with any collision object in the x direction within the next
		// frame, mark it as such.
	
		for (i = 0; i < array_length_1d(collisionObjects); i++) {
			if (place_meeting(x + x_speed_, y, collisionObjects[i])) && (obj_player.collisionFound == -1) && (collisionObjects[1] != self) {
				obj_player.collisionFound = i;
			}
		}
		if obj_player.collisionFound != -1 {
			while !place_meeting(x + sign(x_speed_), y, collisionObjects[obj_player.collisionFound]) {
				x += sign(x_speed_);
				obj_player.x += sign(x_speed_);
			}

			if bounce_ {
				x_speed_ = -(x_speed_) * bouncePercent;
			}
			else {
				x_speed_ = 0;
			}
			obj_player.collisionFound = -1;
		}
	}
	x += x_speed_ * playerTotalSpeed;
	playerGroundHurtbox.x += x_speed_ * playerTotalSpeed;

	with (playerGroundHurtbox) {
		for (i = 0; i < array_length_1d(collisionObjects); i++) {
			if (place_meeting(x, y + y_speed_, collisionObjects[i])) && (obj_player.collisionFound == -1) && (collisionObjects[i] != self) {
				obj_player.collisionFound = i;
			}
		}
		if obj_player.collisionFound != -1 {
			while !place_meeting(x, y + sign(y_speed_), collisionObjects[obj_player.collisionFound]) {
				y += sign(y_speed_);
				obj_player.y += sign(y_speed_);
			}

			if bounce_ {
				y_speed_ = -(y_speed_) * bouncePercent;
			}
			else {
				y_speed_ = 0;
			}
			obj_player.collisionFound = -1;
		}
	}
	y += y_speed_ * playerTotalSpeed;
	playerGroundHurtbox.y += y_speed_ * playerTotalSpeed;

	// Update the current speed and direction after previous manipulations
	currentSpeed = point_distance(0, 0, x_speed_, y_speed_);
	currentDirection = point_direction(0, 0, x_speed_, y_speed_);
}
#endregion


