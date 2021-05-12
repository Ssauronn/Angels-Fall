function scr_player_bindings_of_the_caelesti() {
	// Create the playerHitbox after frame 7
	if instance_exists(obj_player) {
		if (!hitboxCreated) && (playerImageIndex > 7) {
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if !collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_wall, true, true) {
								if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.bindingsOfTheCaelestiRange {
									hitboxCreated = true;
									var owner_ = self.id;
									playerHitbox = instance_create_depth(instance_to_reference_.x, instance_to_reference_.y, -999, obj_hitbox);
									playerHitbox.sprite_index = spr_single_hit;
									playerHitbox.mask_index = spr_single_hit;
									playerHitbox.owner = owner_;
									playerHitbox.playerHitboxAttackType = "AoE Damage";
									playerHitbox.playerHitboxDamageType = "Ability";
									playerHitbox.playerHitboxAbilityOrigin = "Bindings of the Caelesti";
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
									playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
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
						}
					}
				}
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
