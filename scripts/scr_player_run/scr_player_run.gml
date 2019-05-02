if instance_exists(obj_player) {
	obtain_direction();
	if key_dash {
		if playerCurrentStamina >= dashStaminaCost {
			playerCurrentStamina -= dashStaminaCost;
			playerState = playerstates.dash;
			playerStateSprite = playerstates.dash;
			currentSpeed = 0;
			dashTimer = dashTime;
			xDashPosition = mouse_x;
			yDashPosition = mouse_y;
			dashDir = point_direction(obj_player.x, obj_player.y, xDashPosition, yDashPosition)
			if dashDir > 315 && dashDir <= 360 {
				playerDirectionFacing = playerdirection.right;
			}
			else if dashDir > 0 && dashDir <= 45  {
				playerDirectionFacing = playerdirection.right;
			}
			else if dashDir > 45 && dashDir <= 135 {
				playerDirectionFacing = playerdirection.up;
			}
			else if dashDir > 135 && dashDir <= 225 {
				playerDirectionFacing = playerdirection.left;
			}
			else if dashDir > 225 && dashDir <= 315 {
				playerDirectionFacing = playerdirection.down;
			}
		}
	}
	else {
		if (key_right && key_left && !key_down && !key_up) || (!key_right && !key_left && key_up && key_down) {
			apply_friction_to_movement_entity();
		}
		else if !key_nokey {
			add_movement(maxSpeed, acceleration, point_direction(0, 0, xinput, yinput));
		}
		else {
			apply_friction_to_movement_entity();
		}
		if (currentSpeed == 0) {
			playerState = playerstates.idle;
			playerStateSprite = playerstates.idle;
		}
		move_movement_entity(false);
	}

	if (key_attack_lmb != "") && (!key_dash) {
		if playerCurrentStamina >= meleeStaminaCost {
			if (key_attack_lmb == "right") {
				lastAttackButtonPressed = "Attack Right 1";
				playerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_lmb == "up") {
				lastAttackButtonPressed = "Attack Up 1";
				playerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_lmb == "left") {
				lastAttackButtonPressed = "Attack Left 1";
				playerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_lmb == "down") {
				lastAttackButtonPressed = "Attack Down 1";
				playerDirectionFacing = playerdirection.down;
			}
			execute_attacks();
		}
	}
	#region If Magic Button is Pressed
	if (key_attack_rmb != "") {
		if playerCurrentMana >= magicManaCost {
			if (key_attack_rmb == "right") {
				lastAttackButtonPressed = "Skillshot Magic Right";
				playerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_rmb == "up") {
				lastAttackButtonPressed = "Skillshot Magic Up";
				playerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_rmb == "left") {
				lastAttackButtonPressed = "Skillshot Magic Left";
				playerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_rmb == "down") {
				lastAttackButtonPressed = "Skillshot Magic Down";
				playerDirectionFacing = playerdirection.down;
			}
			var player_x_ = obj_player.x;
			var player_y_ = obj_player.y;
			var mouse_x_ = mouse_x;
			var mouse_y_ = mouse_y;
			playerHitboxDirection = point_direction(player_x_, player_y_, mouse_x_, mouse_y_);
			execute_attacks();
		}
	}
	#endregion
	#region If Parry Key is Pressed
	if key_parry {
		obj_skill_tree.parryWindowActive = true;
		obj_skill_tree.parryWindowTimer = obj_skill_tree.parryWindowTimerStartTime;
		playerState = playerstates.parryready;
		playerStateSprite = playerstates.parryready;
		playerImageIndex = 0;
	}
	#endregion
}


