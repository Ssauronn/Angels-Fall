// Sets the following variables if the given keys are not pressed
if !key_right && !key_left {
	xinput = 0;
	rightMovementKeyTimer = 0;
	leftMovementKeyTimer = 0;
}
if !key_up && !key_down {
	yinput = 0;
	upMovementKeyTimer = 0;
	downMovementKeyTimer = 0;
}
// Sets the following variables if the given keys are not pressed
if !key_right {
	rightMovementKeyTimer = 0;
}
if !key_up {
	upMovementKeyTimer = 0;
}
if !key_left {
	leftMovementKeyTimer = 0;
}
if !key_down {
	downMovementKeyTimer = 0;
}
// Sets the following variables if the given keys are pressed
if key_up {
	yinput = -1;
	upMovementKeyTimer += 1;
}
if key_down {
	yinput = 1;
	downMovementKeyTimer += 1;
}
if key_right {
	xinput = 1;
	rightMovementKeyTimer += 1;
}
if key_left {
	xinput = -1;
	leftMovementKeyTimer += 1;
}
// Sets the following variables if the given keys are pressed
if key_right && key_left {
	xinput = 0;
}
if key_up && key_down {
	yinput = 0;
}
// Sets the following variables if no key is pressed
if key_nokey {
	xinput = 0;
	yinput = 0;
	rightMovementKeyTimer = 0;
	upMovementKeyTimer = 0;
	leftMovementKeyTimer = 0;
	downMovementKeyTimer = 0;
}
// Sets the variable longestMoveKeyPress, which is the variable determining the player's direction facing
// This if statement prevents longestMoveKeyPress defaulting to 0 when no keys are being pressed and setting the direction to 0, which is incidentally facing right
if !key_nokey {
	longestMoveKeyPress = max(rightMovementKeyTimer, upMovementKeyTimer, leftMovementKeyTimer, downMovementKeyTimer);
}


