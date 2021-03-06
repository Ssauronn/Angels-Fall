function scr_player_run() {
	if instance_exists(obj_player) {
		obtain_direction();
		if key_dash {
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

	#region If Ability Button is Pressed
		if key_bar_ability_one || key_bar_ability_two || key_bar_ability_three || key_bar_ability_four {
			var point_direction_ = point_direction(x, y, mouse_x, mouse_y);
			if point_direction_ >= 45 && point_direction_ < 135 {
				playerDirectionFacing = playerdirection.up;
			}
			else if point_direction_ >= 315 && point_direction_ < 360 {
				playerDirectionFacing = playerdirection.right;
			}
			else if point_direction_ >= 0 && point_direction_ < 45 {
				playerDirectionFacing = playerdirection.right;
			}
			else if point_direction_ >= 225 && point_direction_ < 315 {
				playerDirectionFacing = playerdirection.down;
			}
			else if point_direction_ >= 135 && point_direction_ < 225 {
				playerDirectionFacing = playerdirection.left;
			}
			send_player_to_ability_state(false);
		}
	#endregion
	#region If Parry Key is Pressed
		if key_parry {
			obj_skill_tree.parryWindowActive = true;
			playerState = playerstates.parryready;
			playerStateSprite = playerstates.parryready;
			playerImageIndex = 0;
			currentSpeed = 0;
		}
	#endregion
	}





}
