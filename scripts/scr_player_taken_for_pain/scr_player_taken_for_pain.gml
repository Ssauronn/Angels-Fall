function scr_player_taken_for_pain() {
	// Create the playerHitbox after frame 7
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


	if instance_exists(obj_player) {
		if (!hitboxCreated) && (playerImageIndex > 7) {
			hitboxCreated = true;
			if !obj_skill_tree.takenForPainFirstPhaseActive {
				obj_skill_tree.takenForPainFirstPhaseTimer = obj_skill_tree.takenForPainFirstPhaseTimerStartTime;
			}
		}
	
		// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
		if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
			playerState = playerstates.idle;
			playerStateSprite = playerstates.idle;
			hitboxCreated = false;
			obj_skill_tree.hellishLandscapeTargetX = 0;
			obj_skill_tree.hellishLandscapeTargetY = 0;
		}
	}





}
