///@description Become Invulnerable until Parry Finishes
var combo_true_timer_ = ((sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) * playerImageIndexSpeed) + 1;

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

// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
	obj_skill_tree.successfulParryInvulnerabilityActive = false;
	if (comboTrue == "") && (comboAbilityButton = 0) {
		if currentSpeed == 0 {
			playerState = playerstates.idle;
			playerStateSprite = playerstates.idle;
			hitboxCreated = false;
			playerImageIndex = 0;
		}
		else {
			playerState = playerstates.run;
			playerStateSprite = playerstates.run;
			hitboxCreated = false;
			playerImageIndex = 0;
		}
	}
	// Else send to another attack playerState
	else {
		parrySuccessfullyCombod = true;
		send_player_to_ability_state(true);
		lastAttackButtonPressed = comboTrue;
		hitboxCreated = false;
	}
}


