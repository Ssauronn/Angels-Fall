function scr_player_idle() {
	// Set friction amount, which is set to a higher number while in dash script
	if instance_exists(obj_player) {
		frictionAmount = baseFrictionAmount * playerTotalSpeed;
		// Dashing script initilization
		if key_dash {
			playerState = playerstates.dash;
			playerStateSprite = playerstates.dash;
			// playerStateSprite = playerstates.dash - this line needs to be added once the dash animation is obtained
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
	#region If Movement Button is Pressed
		if key_up|| key_right|| key_down|| key_left {
			playerState = playerstates.run;
		}
	#endregion
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
	#region If Attack Button is Pressed
		if (key_attack_lmb != "") {
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
