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
	if (playerImageIndex > 7) && (!hitboxCreated) {
		if key_attack_rmb_time_held_down > 0 {
			obj_skill_tree.ritualOfImperfectionCurrentCastTime = key_attack_rmb_time_held_down;
		}
		else {
			obj_skill_tree.ritualOfImperfectionFinalCastTime = obj_skill_tree.ritualOfImperfectionCurrentCastTime;
			obj_skill_tree.ritualOfImperfectionCurrentCastTime = 0;
		}
	}
	var final_cast_time_ = obj_skill_tree.ritualOfImperfectionFinalCastTime;
	if final_cast_time_ > 0 {
		if final_cast_time_ >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForThirdDemon {
			if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionThirdDemonStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionThirdDemonManaCost) {
				playerCurrentStamina -= obj_skill_tree.ritualOfImperfectionThirdDemonStaminaCost;
				playerCurrentStamina += obj_skill_tree.ritualOfImperfectionThirdDemonStaminaRegen;
				playerCurrentMana -= obj_skill_tree.ritualOfImperfectionThirdDemonManaCost;
				playerCurrentMana += obj_skill_tree.ritualOfImperfectionThirdDemonManaRegen;
				if instance_exists(obj_skill_tree.ritualOfImperfectionThirdDemonActive) {
					var existing_demon_ = obj_skill_tree.ritualOfImperfectionThirdDemonActive;
					existing_demon_.enemyCurrentHP = -1;
				}
				obj_skill_tree.ritualOfImperfectionThirdDemonActive = noone;
				var random_direction_1_, random_direction_2_, random_x_, random_y_;
				// Create a random direction to create the minion in
				random_direction_1_ = 270//irandom_range(0, 359);
				random_direction_2_ = 270//irandom_range(0, 359);
				// Set the variables now equal to a location in the direction I just previously set
				random_x_ = lengthdir_x((32 * 1.5), random_direction_1_);
				random_y_ = lengthdir_y((32 * 1.5), random_direction_2_);
				// Create the minion object in that random direction, close to the player
				obj_skill_tree.ritualOfImperfectionThirdDemonActive = instance_create_depth(x + random_x_, y + random_y_, obj_player.depth, obj_enemy);
				var instance_created_ = obj_skill_tree.ritualOfImperfectionThirdDemonActive;
				// Set the new object's location to an empty location in case it spawned inside a
				// non-eligible location, and create the new object.s
				with instance_created_ {
					event_perform(ev_create, 0);
					enemyName = "Healer";
					combatFriendlyStatus = "Minion";
					objectArchetype = "Healer";
					event_perform(ev_step, ev_step_normal);
					with enemyGroundHurtbox {
						teleport_to_nearest_empty_location(x, y, obj_player.x, obj_player.y, obj_wall, obj_ground_hurtbox);
					}
				}
			}
		}
	}
	// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further,
	// and only return once the player has released the casting button
	if (key_attack_rmb_time_held_down == 0) && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
		obj_skill_tree.ritualOfImperfectionCurrentCastTime = 0;
		obj_skill_tree.ritualOfImperfectionFinalCastTime = 0;
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


