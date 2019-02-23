// Set friction amount, which is set to a higher number while in dash script
if instance_exists(obj_player) {
	frictionAmount = 300.00;
	// Dashing script initilization
	if key_dash {
		if playerCurrentStamina >= dashStaminaCost {
			playerCurrentStamina -= dashStaminaCost;
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
	}
	#region If Movement Button is Pressed
	if key_up|| key_right|| key_down|| key_left {
		playerState = playerstates.run;
	}
	#endregion
	#region If Attack Button is Pressed
	if (key_attack_lmb != "") {
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
		}
	}
	#endregion
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
			playerBulletHitboxDirection = point_direction(player_x_, player_y_, mouse_x_, mouse_y_);
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


