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

// Create the playerHitbox after frame 5	
if instance_exists(obj_player) {
	if (!hitboxCreated) && (playerImageIndex > 5) {
		hitboxCreated = true;
		obj_skill_tree.whirlwindFirstPhaseActive = true;
		obj_skill_tree.whirlwindArrivedAtTargetPos = false;
		obj_skill_tree.whirlwindActive = true;
		obj_skill_tree.whirlwindArrivedAtTargetPos = false;
		var owner_ = self;
		switch (playerDirectionFacing) {
			case playerdirection.right:
				playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_whirlwind_hitbox;
				playerHitbox.mask_index = spr_whirlwind_hitbox;
				var point_direction_ = point_direction(x + 32, y, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
				obj_skill_tree.whirlwindDirection = point_direction_;
				break;
			case playerdirection.up:
				playerHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_whirlwind_hitbox;
				playerHitbox.mask_index = spr_whirlwind_hitbox;
				var point_direction_ = point_direction(x, y - 32, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
				obj_skill_tree.whirlwindDirection = point_direction_;
				break;
			case playerdirection.left:
				playerHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_whirlwind_hitbox;
				playerHitbox.mask_index = spr_whirlwind_hitbox;
				var point_direction_ = point_direction(x - 32, y, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
				obj_skill_tree.whirlwindDirection = point_direction_;
				break;
			case playerdirection.down:
				playerHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_whirlwind_hitbox;
				playerHitbox.mask_index = spr_whirlwind_hitbox;
				var point_direction_ = point_direction(x, y + 32, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
				obj_skill_tree.whirlwindDirection = point_direction_;
				break;
		}
		playerHitbox.owner = owner_;
		playerHitbox.playerProjectileHitboxSpeed = obj_skill_tree.whirlwindSpeed;
		playerHitbox.playerProjectileHitboxDirection = point_direction_;
		playerHitbox.image_angle = playerHitbox.playerProjectileHitboxDirection;
		playerHitbox.visible = true;
		playerHitbox.playerHitboxAttackType = "Projectile";
		playerHitbox.playerHitboxDamageType = "Basic Melee";
		playerHitbox.playerHitboxAbilityOrigin = "Whirlwind";
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = obj_skill_tree.whirlwindDamage;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = 300;
		playerHitbox.playerHitboxCollidedWithWall = false;
		playerHitbox.playerHitboxPersistAfterCollision = true;
		// The next variable is the timer that determines when an object will apply damage again to
		// an object its colliding with repeatedly. This only takes effect if the hitbox's
		// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
		// destroyed upon colliding with the first object it can and no chance will be given for the
		// hitbox to deal damage repeatedly to the object.
		playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime + 1;
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
}


