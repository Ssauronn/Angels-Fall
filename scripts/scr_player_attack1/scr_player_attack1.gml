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


// Create the playerHitbox after frame 2	
if instance_exists(obj_player) {
	if (!hitboxCreated) && (playerImageIndex > 2) {
		hitboxCreated = true;
		var owner_ = id;
		switch (playerDirectionFacing) {
			case playerdirection.right:
				playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_player_attack_right_hitbox;
				playerHitbox.mask_index = spr_player_attack_right_hitbox;
				break;
			case playerdirection.up:
				playerHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_player_attack_up_hitbox;
				playerHitbox.mask_index = spr_player_attack_up_hitbox;
				break;
			case playerdirection.left:
				playerHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_player_attack_left_hitbox;
				playerHitbox.mask_index = spr_player_attack_left_hitbox;
				break;
			case playerdirection.down:
				playerHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
				playerHitbox.sprite_index = spr_player_attack_down_hitbox;
				playerHitbox.mask_index = spr_player_attack_down_hitbox;
				break;
		}
		playerHitbox.owner = owner_;
		playerHitbox.playerHitboxType = "Melee";
		playerHitbox.playerHitboxDamageTypeIsBasicMelee = true;
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = playerMeleeAttackOneValue;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = 1;
		playerHitbox.playerHitboxCollidedWithWall = false;
		playerHitbox.playerHitboxPersistAfterCollision = false;
		playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
		playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
		playerHitbox.playerHitboxTargetArray = noone;
		
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
				comboTrue = "Attack Right 2";
				playerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_lmb == "up") {
				comboTrue = "Attack Up 2";
				playerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_lmb == "left") {
				comboTrue = "Attack Left 2";
				playerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_lmb == "down") {
				comboTrue = "Attack Down 2";
				playerDirectionFacing = playerdirection.down;
			}
		}
	}
	#endregion
	#region If Magic Button is Pressed
	if (key_attack_rmb != "") {
		if playerCurrentMana >= magicManaCost {
			if (key_attack_rmb == "right") {
				comboTrue = "Skillshot Magic Right";
				playerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_rmb == "up") {
				comboTrue = "Skillshot Magic Up";
				playerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_rmb == "left") {
				comboTrue = "Skillshot Magic Left";
				playerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_rmb == "down") {
				comboTrue = "Skillshot Magic Down";
				playerDirectionFacing = playerdirection.down;
			}
			var player_x_ = obj_player.x;
			var player_y_ = obj_player.y;
			var mouse_x_ = mouse_x;
			var mouse_y_ = mouse_y;
			playerHitboxDirection = point_direction(player_x_, player_y_, mouse_x_, mouse_y_);
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
		prepare_to_execute_attacks();
		hitboxCreated = false;
	}
}


