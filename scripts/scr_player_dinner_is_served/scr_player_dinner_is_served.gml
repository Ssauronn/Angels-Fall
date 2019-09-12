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
	if (playerImageIndex > 5) && (!hitboxCreated) {
		if instance_exists(obj_dead_body) {
			var nearest_dead_body_ = instance_nearest(x, y, obj_dead_body);
			if point_distance(x, y, nearest_dead_body_.x, nearest_dead_body_.y) <= obj_skill_tree.dinnerIsServedRange {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					var i;
					var target_found_ = false;
					for (i = 0; i <= ds_list_size(objectIDsInBattle) -1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						if instance_exists(instance_to_reference_) {
							if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.dinnerIsServedRange {
								target_found_ = true;
							}
						}
					}
					if target_found_ {
						hitboxCreated = true;
						instance_destroy(nearest_dead_body_);
						var increment_ = -1;
						var i;
						var potential_target_;
						obj_skill_tree.dinnerIsServedTargetArray = noone;
						for (i = 0; i <= ds_list_size(objectIDsInBattle) -1; i++) {
							potential_target_ = ds_list_find_value(objectIDsInBattle, i);
							if instance_exists(potential_target_) {
								if point_distance(x, y, potential_target_.x, potential_target_.y) <= obj_skill_tree.dinnerIsServedRange {
									increment_++;
									with obj_skill_tree {
										dinnerIsServedTargetArray[increment_] = potential_target_;
									}
								}
							}
						}
						if is_array(obj_skill_tree.dinnerIsServedTargetArray) {
							for (i = 0; i <= array_length_1d(obj_skill_tree.dinnerIsServedTargetArray) -1; i++) {
								var target_;
								with obj_skill_tree {
									target_ = dinnerIsServedTargetArray[i];
								}
								// Create Actual Hitbox
								var owner_ = self;
								playerHitbox = instance_create_depth(target_.x, target_.y, -999, obj_hitbox);
								playerHitbox.sprite_index = spr_single_hit;
								playerHitbox.mask_index = spr_single_hit;
								playerHitbox.owner = owner_;
								playerHitbox.playerHitboxAttackType = "AoE Damage";
								playerHitbox.playerHitboxDamageType = "Ability";
								playerHitbox.playerHitboxAbilityOrigin = "Dinner is Served";
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
								playerHitbox.playerHitboxSpecificTarget = target_.id;
								if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
									ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
								}
								else {
									obj_combat_controller.playerHitboxList = ds_list_create();
									ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
								}
							}
							obj_skill_tree.dinnerIsServedTargetArray = noone;
						}
					}
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


