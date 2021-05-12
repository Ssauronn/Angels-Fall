/// Dash Script
function scr_player_dash() {
	if dashTimer <= 0 {
		// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
		if (comboTrue == "") && (comboAbilityButton = 0) {
			hitboxCreated = false;
			playerImageIndex = 0;
			// If the dash script is over, set the current speed to 0 and the playerState to running. I don't use
			// the script set_movement_variables because I'm not interested in setting the direction. And I
			// set the player to the run playerState instead of the idle playerState, because if the player is holding 
			// down the run keys after the dash ends, and I set the player to idle instead of running, it will
			// take an extra game frame to switch to running script.
			playerState = playerstates.run;
			playerStateSprite = playerstates.run;
			frictionAmount = baseFrictionAmount * playerTotalSpeed;
			playerRecentlyDashed = true;
			invincibile = false;
			if !dashAvoidedDamage {
				playerCurrentStamina -= dashStaminaCost;
			}
			dashAvoidedDamage = false;
			dashSuccessfullyCombod = false;
		}
		// Else send to another attack playerState
		else {
			frictionAmount = baseFrictionAmount * playerTotalSpeed;
			playerRecentlyDashed = true;
			invincibile = false;
			if !dashAvoidedDamage {
				playerCurrentStamina -= dashStaminaCost;
			}
			dashAvoidedDamage = false;
			hitboxCreated = false;
			dashSuccessfullyCombod = true;
			send_player_to_ability_state(true);
			lastAttackButtonPressed = comboTrue;
			hitboxCreated = false;
		}
	}
	else {
		// Else if the dash script is not over yet, set the speed to the correct dash speed value and move
		// in the direction of that dash
	
		// This line parially controls how the movement is handled when above obj_player.maxSpeed while and 
		// right after a dash was executed.
		playerRecentlyDashed = true;
		currentSpeed = dashSpeed * playerTotalSpeed;
		currentDirection = dashDir;
		frictionAmount = baseFrictionAmount * (dashSpeed / maxSpeed) * playerTotalSpeed;
		invincibile = true;
		move_movement_entity(false);
	
		// Register attacks if they happen
		var combo_true_timer_ = dashTimer + 1;
	#region If Attack Button is Pressed
		// I don't actually set lastAttackButtonPressed, because if I did, it would immediately send 
		// us to the next attack script. I set comboTrue to what lastAttackButtonPressed should be, and
		// after the script is up, i.e. the attack has finished its animation, I then call
		// prepare_to_execute_melle_attacks script to set lastAttackButtonPressed to what I need it to be,
		// which will then send the player to the next attack script (via calling execute_attacks script
		// every step in the obj_player Step event.
		if (key_attack_lmb != "") {
			if (key_attack_lmb == "right") {
				comboTrue = "Attack Right 2";
				comboTrueTimer = combo_true_timer_;
				comboPlayerDirectionFacing = playerdirection.right;
			}
			else if (key_attack_lmb == "up") {
				comboTrue = "Attack Up 2";
				comboTrueTimer = combo_true_timer_;
				comboPlayerDirectionFacing = playerdirection.up;
			}
			else if (key_attack_lmb == "left") {
				comboTrue = "Attack Left 2";
				comboTrueTimer = combo_true_timer_;
				comboPlayerDirectionFacing = playerdirection.left;
			}
			else if (key_attack_lmb == "down") {
				comboTrue = "Attack Down 2";
				comboTrueTimer = combo_true_timer_;
				comboPlayerDirectionFacing = playerdirection.down;
			}
		}
	#endregion
	#region If Ability Button is Pressed
		if key_bar_ability_one || key_bar_ability_two || key_bar_ability_three || key_bar_ability_four {
			if key_bar_ability_one {
				comboTrueTimer = combo_true_timer_;
				comboAbilityButton = 1;
			}
			else if key_bar_ability_two {
				comboTrueTimer = combo_true_timer_;
				comboAbilityButton = 2;
			}
			else if key_bar_ability_three {
				comboTrueTimer = combo_true_timer_;
				comboAbilityButton = 3;
			}
			else if key_bar_ability_four {
				comboTrueTimer = combo_true_timer_;
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
