/// @function initialize_movement_entity(maxSpeed, currentSpeed, acceleration, currentDirection, frictionAmount, bouncePercent, collisionObject(s)...);
/// @param {real} maxSpeed
/// @param {real} currentSpeed
/// @param {real} acceleration
/// @param {real} currentDirection
/// @param {real} frictionAmount
/// @param {real} bouncePercent
/// @param {real} collisionObjects
function initialize_movement_entity() {
	var max_speed_ = argument[0];
	var current_speed_ = argument[1];
	var player_acceleration_ = argument[2];
	var current_direction_ = argument[3];
	var friction_ = argument[4];
	var bounce_percent_ = argument[5];


	baseMaxSpeed = max_speed_;
	maxSpeed = max_speed_ * playerTotalSpeed;
	currentSpeed = current_speed_;
	baseAcceleration = player_acceleration_;
	acceleration = player_acceleration_ * playerTotalSpeed;
	currentDirection = current_direction_;
	baseFrictionAmount = friction_;
	frictionAmount = friction_ * playerTotalSpeed;
	bouncePercent = bounce_percent_;
	globalvar collisionObjects//, collisionFound;
	var i = 0;
	var iteration_ = 0;
	if (argument_count > 6) {
		collisionObjects = array_create(argument_count - 6, noone);
		for (i = 0; i < (argument_count - 6); i++) {
			collisionObjects[iteration_] = argument[i + 6];
			iteration_ += 1;
		}
	}
	collisionFound = -1;

	// Last movement key pressed
	longestMoveKeyPress = -1;
	rightMovementKeyTimer = 0;
	upMovementKeyTimer = 0;
	leftMovementKeyTimer = 0;
	downMovementKeyTimer = 0;
}


