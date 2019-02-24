/// Dash Script
if dashTimer <= 0 {
	// If the dash script is over, set the current speed to 0 and the playerState to running. I don't use
	// the script set_movement_variables because I'm not interested in setting the direction. And I
	// set the player to the run playerState instead of the idle playerState, because if the player is holding 
	// down the run keys after the dash ends, and I set the player to idle instead of running, it will
	// take an extra game frame to switch to running script.
	playerState = playerstates.run;
	playerStateSprite = playerstates.run;
	frictionAmount = baseFrictionAmount * playerTotalSpeed;
	playerCurrentMana += dashManaRegen;
}
else {
	// Else if the dash script is not over yet, set the speed to the correct dash speed value and move
	// in the direction of that dash
	currentSpeed = dashSpeed * playerTotalSpeed;
	currentDirection = dashDir;
	frictionAmount = baseFrictionAmount * (dashSpeed / maxSpeed) * playerTotalSpeed;
	move_movement_entity(false);
}


