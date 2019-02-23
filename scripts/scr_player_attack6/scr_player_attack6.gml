// Create the playerMeleeHitbox after frame 2
if instance_exists(obj_player) {
	if (hitboxCreated == false) && (playerImageIndex > 2) {
		var owner_ = id;
		hitboxCreated = true;
		switch (playerDirectionFacing) {
			case playerdirection.right:
				playerMeleeHitbox = instance_create_depth(x + 32, y, -999, obj_player_melee_hitbox);
				playerMeleeHitbox.sprite_index = spr_player_attack_right_hitbox;
				playerMeleeHitbox.mask_index = spr_player_attack_right_hitbox;
				playerMeleeHitbox.owner = owner_;
				break;
			case playerdirection.up:
				playerMeleeHitbox = instance_create_depth(x, y - 32, -999, obj_player_melee_hitbox);
				playerMeleeHitbox.sprite_index = spr_player_attack_up_hitbox;
				playerMeleeHitbox.mask_index = spr_player_attack_up_hitbox;
				playerMeleeHitbox.owner = owner_;
				break;
			case playerdirection.left:
				playerMeleeHitbox = instance_create_depth(x - 32, y, -999, obj_player_melee_hitbox);
				playerMeleeHitbox.sprite_index = spr_player_attack_left_hitbox;
				playerMeleeHitbox.mask_index = spr_player_attack_left_hitbox;
				playerMeleeHitbox.owner = owner_;
				break;
			case playerdirection.down:
				playerMeleeHitbox = instance_create_depth(x, y + 32, -999, obj_player_melee_hitbox);
				playerMeleeHitbox.sprite_index = spr_player_attack_down_hitbox;
				playerMeleeHitbox.mask_index = spr_player_attack_down_hitbox;
				playerMeleeHitbox.owner = owner_;
				break;
		}
	}

	#region If Attack Button is Pressed
	if (key_attack_lmb != "") {
		if playerCurrentStamina >= meleeStaminaCost {
			if (key_attack_lmb == "right") {
				comboTrue = "Attack Right 1";
				playerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_lmb == "up") {
				comboTrue = "Attack Up 1";
				playerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_lmb == "left") {
				comboTrue = "Attack Left 1";
				playerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_lmb == "down") {
				comboTrue = "Attack Down 1";
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
			playerBulletHitboxDirection = point_direction(player_x_, player_y_, mouse_x_, mouse_y_);
		}
	}
	#endregion

	// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
	if (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) && (comboTrue == "") {
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		instance_destroy(playerMeleeHitbox);
		playerMeleeHitbox = noone;
		hitboxCreated = false;
	}
	else if (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) && (comboTrue != "") {
		prepare_to_execute_attacks();
		instance_destroy(playerMeleeHitbox);
		playerMeleeHitbox = noone;
		hitboxCreated = false;
	}
}


