///@argument0 Bounce
var bounce_ = argument0;

for (i = 0; i < array_length_1d(collisionObjects); i++) {
	if (place_meeting(playerGroundHurtbox.x + lengthdir_x(currentSpeed, currentDirection), playerGroundHurtbox.y + lengthdir_y(currentSpeed, currentDirection), collisionObjects[i]) && (!bounce_) && (collisionObjects[i] != self)) {
		currentSpeed = approach_number(currentSpeed, 0, (frictionAmount / 2));
	}
}

var x_speed_ = lengthdir_x(currentSpeed, currentDirection);
var y_speed_ = lengthdir_y(currentSpeed, currentDirection);

if currentSpeed <= 0 {
	exit;
}

with (playerGroundHurtbox) {
	var i = 0;
	for (i = 0; i < array_length_1d(collisionObjects); i++) {
		if (place_meeting(x + x_speed_, y, collisionObjects[i])) && (collisionFound == -1) && (collisionObjects[1] != self) {
			collisionFound = i;
		}
	}
	if collisionFound != -1 {
		while !place_meeting(x + sign(x_speed_), y, collisionObjects[collisionFound]) {
			x += sign(x_speed_);
			obj_player.x += sign(x_speed_);
		}

		if bounce_ {
			x_speed_ = -(x_speed_) * bouncePercent;
		}
		else {
			x_speed_ = 0;
		}
		collisionFound = -1;
	}
}
x += x_speed_ * playerTotalSpeed;
playerGroundHurtbox.x += x_speed_ * playerTotalSpeed;

with (playerGroundHurtbox) {
	for (i = 0; i < array_length_1d(collisionObjects); i++) {
		if (place_meeting(x, y + y_speed_, collisionObjects[i])) && (collisionFound == -1) && (collisionObjects[i] != self) {
			collisionFound = i;
		}
	}
	if collisionFound != -1 {
		while !place_meeting(x, y + sign(y_speed_), collisionObjects[collisionFound]) {
			y += sign(y_speed_);
			obj_player.y += sign(y_speed_);
		}

		if bounce_ {
			y_speed_ = -(y_speed_) * bouncePercent;
		}
		else {
			y_speed_ = 0;
		}
		collisionFound = -1;
	}
}
y += y_speed_ * playerTotalSpeed;
playerGroundHurtbox.y += y_speed_ * playerTotalSpeed;

// Update the current speed and direction after previous manipulations
currentSpeed = point_distance(0, 0, x_speed_, y_speed_);
currentDirection = point_direction(0, 0, x_speed_, y_speed_);


