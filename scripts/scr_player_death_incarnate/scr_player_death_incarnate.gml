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

// If Death Incarnate is already active but only in first phase, move to second phase
if obj_skill_tree.deathIncarnateFirstPhaseActive {
	if instance_exists(obj_player) {
		if (!hitboxCreated) && (playerImageIndex > 7) {
			hitboxCreated = true;
			obj_skill_tree.deathIncarnateFirstPhaseActive = false;
			obj_skill_tree.deathIncarnateSecondPhaseActive = true;
			obj_skill_tree.deathIncarnateSecondPhaseCurrentTarget = noone;
			obj_skill_tree.deathIncarnateFirstPhaseReachedTarget = false;
			if !is_undefined(obj_skill_tree.deathIncarnateSecondPhaseTargetList) {
				if ds_exists(obj_skill_tree.deathIncarnateSecondPhaseTargetList, ds_type_list) {
					if !ds_list_empty(obj_skill_tree.deathIncarnateSecondPhaseTargetList) {
						ds_list_clear(obj_skill_tree.deathIncarnateSecondPhaseTargetList);
					}
				}
				else {
					obj_skill_tree.deathIncarnateSecondPhaseTargetList = ds_list_create();
				}
			}
			else {
				obj_skill_tree.deathIncarnateSecondPhaseTargetList = ds_list_create();
			}
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i, target_exists_;
				target_exists_ = false;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							target_exists_ = true;
							ds_list_add(obj_skill_tree.deathIncarnateSecondPhaseTargetList, instance_to_reference_.id);
						}
					}
				}
				if target_exists_ {
					obj_skill_tree.deathIncarnateFirstPhaseActive = false;
					obj_skill_tree.deathIncarnateSecondPhaseActive = true;
					obj_skill_tree.deathIncarnateSecondPhaseCurrentDamage = obj_skill_tree.deathIncarnateSecondPhaseStartDamage;
				}
				else {
					if ds_exists(obj_skill_tree.deathIncarnateSecondPhaseTargetList, ds_type_list) {
						ds_list_destroy(obj_skill_tree.deathIncarnateSecondPhaseTargetList);
						obj_skill_tree.deathIncarnateSecondPhaseTargetList = noone;
					}
					exit;
				}
			}
			else {
				if ds_exists(obj_skill_tree.deathIncarnateSecondPhaseTargetList, ds_type_list) {
					ds_list_destroy(obj_skill_tree.deathIncarnateSecondPhaseTargetList);
					obj_skill_tree.deathIncarnateSecondPhaseTargetList = noone;
				}
				exit;
			}
		}
	}
}
// Else if Death Incarnate's first and second phases are not active, create Death Incarnate in the
// first place. I don't check for if the second phase is active because I don't want to move out of
// the second phase, because cancelling it would make mashing the key unviable. Essentially, if someone
// wants to immediately start second phase so they start mashing the Death Incarnate button, and then
// they mash one too many times, I don't want to stop the second phase and screw the player.
else if !obj_skill_tree.deathIncarnateSecondPhaseActive {
	if instance_exists(obj_player) {
		if (!hitboxCreated) && (playerImageIndex > 7) {
			hitboxCreated = true;
			obj_skill_tree.deathIncarnateFirstPhaseActive = true;
			obj_skill_tree.deathIncarnateFirstPhaseReachedTarget = false;
			obj_skill_tree.deathIncarnateSecondPhaseCurrentTarget = noone;
			var owner_ = self;
			switch (playerDirectionFacing) {
				case playerdirection.right:
					playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
					break;
				case playerdirection.up:
					playerHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
					break;
				case playerdirection.left:
					playerHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
					break;
				case playerdirection.down:
					playerHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
					break;
			}
			obj_skill_tree.deathIncarnateFirstPhaseWalkDirection = point_direction(x, y, obj_skill_tree.deathIncarnateFirstPhaseTargetXPos, obj_skill_tree.deathIncarnateFirstPhaseTargetYPos);
			if ((obj_skill_tree.deathIncarnateFirstPhaseWalkDirection >= 0) && (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection < 45)) || ((obj_skill_tree.deathIncarnateFirstPhaseWalkDirection >= 315) && (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection < 360)) {
				playerHitbox.sprite_index = spr_death_incarnate_walking_right;
				playerHitbox.mask_index = spr_death_incarnate_walking_right;
			}
			else if (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection >= 45) && (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection < 135) {
				playerHitbox.sprite_index = spr_death_incarnate_walking_up;
				playerHitbox.mask_index = spr_death_incarnate_walking_up;
			}
			else if (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection >= 135) && (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection < 225) {
				playerHitbox.sprite_index = spr_death_incarnate_walking_left;
				playerHitbox.mask_index = spr_death_incarnate_walking_left;
			}
			else if (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection >= 225) && (obj_skill_tree.deathIncarnateFirstPhaseWalkDirection < 315) {
				playerHitbox.sprite_index = spr_death_incarnate_walking_down;
				playerHitbox.mask_index = spr_death_incarnate_walking_down;
			}
			playerHitbox.owner = owner_;
			playerHitbox.playerProjectileHitboxSpeed = obj_skill_tree.deathIncarnateFirstPhaseMovementSpeed;
			playerHitbox.playerProjectileHitboxDirection = obj_skill_tree.deathIncarnateFirstPhaseWalkDirection;
			playerHitbox.visible = true;
			playerHitbox.playerHitboxAttackType = "Projectile";
			playerHitbox.playerHitboxDamageType = "Ability";
			playerHitbox.playerHitboxAbilityOrigin = "Death Incarnate";
			playerHitbox.playerHitboxHeal = false;
			playerHitbox.playerHitboxValue = obj_skill_tree.deathIncarnateFirstPhaseDamage;
			playerHitbox.playerHitboxCollisionFound = false;
			playerHitbox.playerHitboxLifetime = 600;
			playerHitbox.playerHitboxCollidedWithWall = false;
			playerHitbox.playerHitboxPersistAfterCollision = true;
			// The next variable is the timer that determines when an object will apply damage again to
			// an object its colliding with repeatedly. This only takes effect if the hitbox's
			// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
			// destroyed upon colliding with the first object it can and no chance will be given for the
			// hitbox to deal damage repeatedly to the object.
			playerHitbox.playerHitboxTicTimer = room_speed * 0.5;
			playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
			// This is the variable which will be an array of all objects the hitbox has collided with
			// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
			// it has collided with in the first place
			playerHitbox.playerHitboxTargetArray = noone;
			// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
			// that unless that hitbox collides with the exact object its meant for, it won't interact
			// with that object. If the hitbox has no specific target, this is set to noone.
			playerHitbox.playerHitboxSpecificTarget = noone;

			if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
				ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
			}
			else {
				obj_combat_controller.playerHitboxList = ds_list_create();
				ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
			}
		}
		#region If Attack Button is Pressed
		// I don't actually set lastAttackButtonPressed, because if I did, it would immediately send 
		// us to the next attack script. I set comboTrue to what lastAttackButtonPressed should be, and
		// after the script is up, i.e. the attack has finished its animation, I then call
		// prepare_to_execute_melle_attacks script to set lastAttackButtonPressed to what I need it to be,
		// which will then send the player to the next attack script (via calling execute_attacks script
		// every step in the obj_player Step event.
		if (key_attack_lmb != "") {
			if playerCurrentStamina >= meleeStaminaCost {
				if (key_attack_lmb == "right") {
					comboTrue = "Attack Right 1";
					comboPlayerDirectionFacing = playerdirection.right;
				}
				else if (key_attack_lmb == "up") {
					comboTrue = "Attack Up 1";
					comboPlayerDirectionFacing = playerdirection.up;
				}
				else if (key_attack_lmb == "left") {
					comboTrue = "Attack Left 1";
					comboPlayerDirectionFacing = playerdirection.left;
				}
				else if (key_attack_lmb == "down") {
					comboTrue = "Attack Down 1";
					comboPlayerDirectionFacing = playerdirection.down;
				}
			}
		}
		#endregion
		#region If Ability Button is Pressed
		if key_bar_ability_one || key_bar_ability_two || key_bar_ability_three || key_bar_ability_four {
			if key_bar_ability_one {
				comboAbilityButton = 1;
			}
			else if key_bar_ability_two {
				comboAbilityButton = 2;
			}
			else if key_bar_ability_three {
				comboAbilityButton = 3;
			}
			else if key_bar_ability_four {
				comboAbilityButton = 4;
			}
			var point_direction_ = point_direction(x, y, mouse_x, mouse_y);
			if point_direction_ >= 45 && point_direction_ < 135 {
				comboPlayerDirectionFacing = playerdirection.up;
			}
			else if point_direction_ >= 315 && point_direction_ < 360 {
				comboPlayerDirectionFacing = playerdirection.right;
			}
			else if point_direction_ >= 0 && point_direction_ < 45 {
				comboPlayerDirectionFacing = playerdirection.right;
			}
			else if point_direction_ >= 225 && point_direction_ < 315 {
				comboPlayerDirectionFacing = playerdirection.down;
			}
			else if point_direction_ >= 135 && point_direction_ < 225 {
				comboPlayerDirectionFacing = playerdirection.left;
			}
		}
		#endregion
	}
}
// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
if (comboTrue == "") && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
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
// Else send to another attack playerState
else if (comboTrue != "") && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
	send_player_to_ability_state(true);
	lastAttackButtonPressed = comboTrue;
	hitboxCreated = false;
}


