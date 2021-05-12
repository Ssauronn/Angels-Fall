function scr_player_ritual_of_imperfection() {
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
			if key_attack_rmb_time_held_down >= 0 {
				obj_skill_tree.ritualOfImperfectionCurrentCastTime = key_attack_rmb_time_held_down;
			}
			else {
				obj_skill_tree.ritualOfImperfectionFinalCastTime = obj_skill_tree.ritualOfImperfectionCurrentCastTime;
				obj_skill_tree.ritualOfImperfectionCurrentCastTime = -1;
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
							teleport_to_nearest_empty_location(x, y, obj_player.x, obj_player.y, obj_wall, obj_ground_hurtbox, obj_chasm);
						}
					}
				}
			}
			else if final_cast_time_ >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForSecondDemon {
				if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionSecondDemonStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionSecondDemonManaCost) {
					playerCurrentStamina -= obj_skill_tree.ritualOfImperfectionSecondDemonStaminaCost;
					playerCurrentStamina += obj_skill_tree.ritualOfImperfectionSecondDemonStaminaRegen;
					playerCurrentMana -= obj_skill_tree.ritualOfImperfectionSecondDemonManaCost;
					playerCurrentMana += obj_skill_tree.ritualOfImperfectionSecondDemonManaRegen;
					if instance_exists(obj_skill_tree.ritualOfImperfectionSecondDemonActive) {
						var existing_demon_ = obj_skill_tree.ritualOfImperfectionSecondDemonActive;
						existing_demon_.enemyCurrentHP = -1;
					}
					obj_skill_tree.ritualOfImperfectionSecondDemonActive = noone;
					var random_direction_1_, random_direction_2_, random_x_, random_y_;
					// Create a random direction to create the minion in
					random_direction_1_ = 270//irandom_range(0, 359);
					random_direction_2_ = 270//irandom_range(0, 359);
					// Set the variables now equal to a location in the direction I just previously set
					random_x_ = lengthdir_x((32 * 1.5), random_direction_1_);
					random_y_ = lengthdir_y((32 * 1.5), random_direction_2_);
					// Create the minion object in that random direction, close to the player
					obj_skill_tree.ritualOfImperfectionSecondDemonActive = instance_create_depth(x + random_x_, y + random_y_, obj_player.depth, obj_enemy);
					var instance_created_ = obj_skill_tree.ritualOfImperfectionSecondDemonActive;
					// Set the new object's location to an empty location in case it spawned inside a
					// non-eligible location, and create the new object.s
					with instance_created_ {
						event_perform(ev_create, 0);
						enemyName = "Tank";
						combatFriendlyStatus = "Minion";
						objectArchetype = "Tank";
						event_perform(ev_step, ev_step_normal);
						with enemyGroundHurtbox {
							teleport_to_nearest_empty_location(x, y, obj_player.x, obj_player.y, obj_wall, obj_ground_hurtbox, obj_chasm);
						}
					}
				}
			}
			else if final_cast_time_ >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForFirstDemon {
				if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost) {
					playerCurrentStamina -= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost;
					playerCurrentStamina += obj_skill_tree.ritualOfImperfectionFirstDemonStaminaRegen;
					playerCurrentMana -= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost;
					playerCurrentMana += obj_skill_tree.ritualOfImperfectionFirstDemonManaRegen;
					if instance_exists(obj_skill_tree.ritualOfImperfectionFirstDemonActive) {
						var existing_demon_ = obj_skill_tree.ritualOfImperfectionFirstDemonActive;
						existing_demon_.enemyCurrentHP = -1;
					}
					obj_skill_tree.ritualOfImperfectionFirstDemonActive = noone;
					var random_direction_1_, random_direction_2_, random_x_, random_y_;
					// Create a random direction to create the minion in
					random_direction_1_ = 270//irandom_range(0, 359);
					random_direction_2_ = 270//irandom_range(0, 359);
					// Set the variables now equal to a location in the direction I just previously set
					random_x_ = lengthdir_x((32 * 1.5), random_direction_1_);
					random_y_ = lengthdir_y((32 * 1.5), random_direction_2_);
					// Create the minion object in that random direction, close to the player
					obj_skill_tree.ritualOfImperfectionFirstDemonActive = instance_create_depth(x + random_x_, y + random_y_, obj_player.depth, obj_enemy);
					var instance_created_ = obj_skill_tree.ritualOfImperfectionFirstDemonActive;
					// Set the new object's location to an empty location in case it spawned inside a
					// non-eligible location, and create the new object.s
					with instance_created_ {
						event_perform(ev_create, 0);
						enemyName = "Mage";
						combatFriendlyStatus = "Minion";
						objectArchetype = "Ranged DPS";
						event_perform(ev_step, ev_step_normal);
						with enemyGroundHurtbox {
							teleport_to_nearest_empty_location(x, y, obj_player.x, obj_player.y, obj_wall, obj_ground_hurtbox, obj_chasm);
						}
					}
				}
			}
		}
		// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further,
		// and only return once the player has released the casting button
		if (key_attack_rmb_time_held_down == -1) && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
			obj_skill_tree.ritualOfImperfectionCurrentCastTime = -1;
			obj_skill_tree.ritualOfImperfectionFinalCastTime = -1;
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
