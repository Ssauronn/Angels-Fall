function scr_player_ritual_of_death() {
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


	// Resurrect a dead body
	if instance_exists(obj_player) {
		if (playerImageIndex > 7) && (!hitboxCreated) {
			if (playerCurrentStamina >= obj_skill_tree.ritualOfDeathStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfDeathManaCost) {
				var nearest_dead_body_ = instance_nearest(x, y, obj_dead_body);
				if instance_exists(nearest_dead_body_) {
					if point_distance(x, y, nearest_dead_body_.x, nearest_dead_body_.y) <= obj_skill_tree.ritualOfDeathRange {
						playerCurrentStamina -= obj_skill_tree.ritualOfDeathStaminaCost;
						playerCurrentStamina += obj_skill_tree.ritualOfDeathStaminaRegen;
						playerCurrentMana -= obj_skill_tree.ritualOfDeathManaCost;
						playerCurrentMana += obj_skill_tree.ritualOfDeathManaRegen;
						var current_ritual_of_death_minion_ = obj_skill_tree.ritualOfDeathActive;
						// Destroy the existing minion that was raised from the dead before raising a new one
						if instance_exists(current_ritual_of_death_minion_) {
							current_ritual_of_death_minion_.enemyCurrentHP = -1;
							obj_skill_tree.ritualOfDeathActive = noone;
						}
						// Actually creating the new minion object is handled in the obj_dead_body step event
						nearest_dead_body_.deadBodyBeingResurrected = true;
						nearest_dead_body_.deadBodyResurrectedBy = self.id;
					}
				}
			}
		}
		// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further,
		// and only return once the player has released the casting button
		if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
			if currentSpeed == 0 {
				playerState = playerstates.idle;
				playerStateSprite = playerstates.idle;
				hitboxCreated = false;
			}
			else {
				playerState = playerstates.run;
				playerStateSprite = playerstates.run;
				hitboxCreated = false;
			}
		}
	}





}
