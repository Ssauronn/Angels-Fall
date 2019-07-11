// Move around if needed
obtain_direction();
if (key_right && key_left && !key_down && !key_up) || (!key_right && !key_left && key_up && key_down) {
	apply_friction_to_movement_entity();
}
else if !key_nokey {
	add_movement(maxSpeed, acceleration, point_direction(0, 0, xinput, yinput));
}
else {
	apply_friction_to_movement_entity();
}
move_movement_entity(false);

// Apply buff after frame 5
if instance_exists(obj_player) {
	if playerImageIndex > 5 {
		obj_skill_tree.allOutAttackActive = true;
		obj_skill_tree.allOutAttackTimer = obj_skill_tree.allOutAttackTimerStartTime;
	}

	// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
	if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
		if currentSpeed == 0 {
			playerState = playerstates.idle;
			playerStateSprite = playerstates.idle;
		}
		else {
			playerState = playerstates.run;
			playerStateSprite = playerstates.run;
		}
	}
}


