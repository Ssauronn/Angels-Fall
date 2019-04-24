/// @description Edit Variables
// ---PRIME ABILITIES---
// Slow time if the player so chooses, toggled on and off at will, at the cost of health
if primeAbilityChosen == "Slow Time Toggled" {
	if (obj_player.key_prime_ability) {
		slowTimeActive = !slowTimeActive;
		obj_combat_controller.levelPaused = !obj_combat_controller.levelPaused;
	}
	if slowTimeActive {
		playerCurrentHP -= (50 / room_speed) * playerTotalSpeed;
		userInterfaceGameSpeed = 0.25;
		playerGameSpeed = 1.75;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed = 0.25;
		}
	}
	else if (!slowTimeActive) && (slowEnemyTimeWithParryTimer == -1) {
		userInterfaceGameSpeed = 1;
		playerGameSpeed = 1;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed = 1;
		}
	}
}
// Slow time if the player so chooses, for a specific amount of time, at the cost of health
else if primeAbilityChosen == "Slow Time Timed" {
	if slowTimeActiveTimer >= 0 {
		slowTimeActiveTimer -= 1;
	}
	else {
		slowTimeActive = false;
	}
	if (obj_player.key_prime_ability) {
		slowTimeActive = true;
		slowTimeActiveTimer = slowTimeActiveTimerStartTime;
	}
	if slowTimeActive {
		playerCurrentHP -= (100 / room_speed) * playerTotalSpeed;
		userInterfaceGameSpeed = 0.25;
		playerGameSpeed = 1.75;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed = 0.25;
		}
	}
	else if (!slowTimeActive) && (slowEnemyTimeWithParryTimer == -1) {
		userInterfaceGameSpeed = 1;
		playerGameSpeed = 1;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed = 1;
		}
	}
}
// Deal extra damage if the player so chooses, toggled on and off at will, at the cost of health
else if primeAbilityChosen == "Bonus Damage Toggled" {
	if (obj_player.key_prime_ability) {
		primeDamageActive = !primeDamageActive;
	}
	if primeDamageActive {
		primeBonusDamagePercentAsDecimal = 1;
		obj_player.playerAnimationSprite = spr_prime_damage_buff;
		playerCurrentHP -= (50 / room_speed) * playerTotalSpeed;
	}
	else {
		primeBonusDamagePercentAsDecimal = 0;
		obj_player.playerAnimationSprite = noone;
	}
}


// ---PARRY EFFECTS---
if parryEffectChosen == "Slow Time Effect" {
	if parryWindowTimer >= 0 {
		parryWindowTimer--;
		parryWindowActive = true;
	}
	else {
		parryWindowActive = false;
	}
	if successfulParryInvulnerabilityTimer >= 0 {
		successfulParryInvulnerabilityTimer--;
		successfulParryInvulnerabilityActive = true;
	}
	else {
		successfulParryInvulnerabilityActive = false;
	}
	// Usually, the below 3 lines of code would only be happening locally inside obj_enemy's. But I need to keep track of the buff because in case its applied to an enemy, I don't want the Prime ability slow time resets to take effect.
	if slowEnemyTimeWithParryTimer >= 0 {
		slowEnemyTimeWithParryTimer--;
	}
	if obj_player.key_parry {
		if !parryWindowActive && !successfulParryInvulnerabilityActive {
			parryWindowActive = true;
			parryWindowTimer = parryWindowTimerStartTime;
		}
	}
}


