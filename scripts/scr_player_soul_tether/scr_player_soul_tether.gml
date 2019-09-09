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
		if ds_exists(objectIDsInBattle, ds_type_list) {
			// Determine eligible targets
			var i, first_target_, second_target_, third_target_;
			first_target_ = noone;
			second_target_ = noone;
			third_target_ = noone;
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				if instance_exists(instance_to_reference_) {
					if instance_to_reference_.combatFriendlyStatus == "Enemy" {
						if !collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_wall, true, true) {
							if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.soulTetherRange {
								if instance_exists(first_target_) {
									if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < point_distance(x, y, first_target_.x, first_target_.y) {
										third_target_ = second_target_;
										second_target_ = first_target_;
										first_target_ = instance_to_reference_;
									}
									else if instance_exists(second_target_) {
										if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < point_distance(x, y, second_target_.x, second_target_.y) {
											third_target_ = second_target_;
											second_target_ = instance_to_reference_;
										}
										else if instance_exists(third_target_) {
											if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < point_distance(x, y, third_target_.x, third_target_.y) {
												third_target_ = instance_to_reference_;
											}
										}
										else {
											third_target_ = instance_to_reference_;
										}
									}
									else {
										second_target_ = instance_to_reference_;
									}
								}
								else {
									first_target_ = instance_to_reference_;
								}
							}
						}
					}
				}
			}
			// Remove Soul Tether from all current Soul Tether targets
			with obj_skill_tree {
				if is_array(soulTetherTargetArray) {
					for (i = 0; i <= array_length_1d(soulTetherTargetArray) - 1; i++) {
						if instance_exists(soulTetherTargetArray[i]) {
							instance_to_reference_ = soulTetherTargetArray[i];
							instance_to_reference_.soulTetherTimer = -1;
							instance_to_reference_.soulTetherActive = false;
						}
					}
					soulTetherTargetArray = noone;
				}
				if !is_array(soulTetherTargetArray) {
					soulTetherTargetArray = array_create(3, noone);
				}
				if instance_exists(first_target_) {
					soulTetherTargetArray[0] = first_target_;
					if instance_exists(second_target_) {
						soulTetherTargetArray[1] = second_target_;
						if instance_exists(third_target_) {
							soulTetherTargetArray[2] = third_target_;
						}
					}
				}
			}
			// Apply the Soul Tether debuff to each enemy
			for (i = 0; i <= array_length_1d(obj_skill_tree.soulTetherTargetArray) - 1; i++) {
				with obj_skill_tree {
					instance_to_reference_ = soulTetherTargetArray[i];
				}
				if instance_exists(instance_to_reference_) {
					var owner_ = self;
					playerHitbox = instance_create_depth(instance_to_reference_.x, instance_to_reference_.y, -999, obj_hitbox);
					playerHitbox.sprite_index = spr_single_hit;
					playerHitbox.mask_index = spr_single_hit;
					playerHitbox.owner = owner_;
					playerHitbox.playerHitboxAttackType = "AoE Damage";
					playerHitbox.playerHitboxDamageType = "Ability";
					playerHitbox.playerHitboxAbilityOrigin = "Soul Tether";
					playerHitbox.playerHitboxHeal = false;
					playerHitbox.playerHitboxValue = 0;
					playerHitbox.playerHitboxCollisionFound = false;
					playerHitbox.playerHitboxLifetime = 1;
					playerHitbox.playerHitboxCollidedWithWall = false;
					playerHitbox.playerHitboxPersistAfterCollision = false;
					// The next variable is the timer that determines when an object will apply damage again to
					// an object its colliding with repeatedly. This only takes effect if the hitbox's
					// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
					// destroyed upon colliding with the first object it can and no chance will be given for the
					// hitbox to deal damage repeatedly to the object.
					playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
					playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = false;
					// This is the variable which will be an array of all objects the hitbox has collided with
					// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
					// it has collided with in the first place
					playerHitbox.playerHitboxTargetArray = noone;
					// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
					// that unless that hitbox collides with the exact object its meant for, it won't interact
					// with that object. If the hitbox has no specific target, this is set to noone.
					playerHitbox.playerHitboxSpecificTarget = instance_to_reference_.id;
					
					if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
						ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
					}
					else {
						obj_combat_controller.playerHitboxList = ds_list_create();
						ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
					}
				}
			}
			hitboxCreated = true;
		}
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


