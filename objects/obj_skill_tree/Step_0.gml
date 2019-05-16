/// @description Edit Variables

#region ---PRIME ABILITIES---
// If the player does not have the health to use the prime ability in the first place, the ability
// should not activate/should deactivate.
// If playerCurrentHP is less than the largest amount of HP that would be lost by any ability at once,
// stop the ability before it reduces player to below 0 HP
if playerCurrentHP <= ((50 / room_speed) * playerTotalSpeed) * 2 {
	// Set the prime ability button permanently to false
	if obj_player.key_prime_ability {
		obj_player.key_prime_ability = false;
	}
	// Deactivate all prime abilities
	if slowTimeActive {
		slowTimeActive = false;
		slowTimeActiveTimer = -1;
		userInterfaceGameSpeed = 1;
		playerGameSpeed = 1;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed += 0.75;
		}
	}
	if slowTimeActiveTimer > 0 {
		slowTimeActive = false;
		slowTimeActiveTimer = -1;
		userInterfaceGameSpeed = 1;
		playerGameSpeed = 1;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed += 0.75;
		}
	}
	if primeDamageActive {
		primeDamageActive = false;
		primeBonusDamagePercentAsDecimal = 0;
		obj_player.playerAnimationSprite = noone;
	}
}

// Slow time if the player so chooses, toggled on and off at will, at the cost of health
if primeAbilityChosen == "Slow Time Toggled" {
	if (obj_player.key_prime_ability) {
		slowTimeActive = !slowTimeActive;
		if slowTimeActive {
			if instance_exists(obj_enemy) {
				obj_enemy.enemyGameSpeed -= 0.75;
			}
		}
		else if !slowTimeActive {
			if instance_exists(obj_enemy) {
				obj_enemy.enemyGameSpeed =+ 0.75;
			}
		}
	}
	if slowTimeActive {
		playerCurrentHP -= ((playerMaxHP * 0.1) / room_speed) * playerTotalSpeed;
	}
}
// Slow time if the player so chooses, for a specific amount of time, at the cost of health
else if primeAbilityChosen == "Slow Time Timed" {
	// Reduce slowTimeActiveTimer by one each frame, and if the timer reaches 0 or below 0, deactivate
	// the prime ability.
	if slowTimeActiveTimer >= 0 {
		slowTimeActiveTimer -= 1;
		if slowTimeActiveTimer <= 0 {
			if instance_exists(obj_enemy) {
				obj_enemy.enemyGameSpeed += 0.75;
			}
		}
	}
	else if slowTimeActiveTimer < 0 {
		slowTimeActive = false;
	}
	if (obj_player.key_prime_ability) {
		slowTimeActive = true;
		slowTimeActiveTimer = slowTimeActiveTimerStartTime;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed -= 0.75;
		}
	}
	if slowTimeActive {
		playerCurrentHP -= ((playerMaxHP * 0.15) / room_speed) * playerTotalSpeed;
	}
}
// Deal extra damage if the player so chooses, toggled on and off at will, at the cost of health
else if primeAbilityChosen == "Bonus Damage Toggled" {
	if (obj_player.key_prime_ability) {
		primeDamageActive = !primeDamageActive;
	}
	if primeDamageActive {
		primeBonusDamagePercentAsDecimal = 2;
		obj_player.playerAnimationSprite = spr_prime_damage_buff;
		obj_player.playerAnimationX = obj_player.x;
		obj_player.playerAnimationY = obj_player.y;
		playerCurrentHP -= ((playerMaxHP * 0.1) / room_speed) * playerTotalSpeed;
	}
	else {
		primeBonusDamagePercentAsDecimal = 0;
		obj_player.playerAnimationSprite = noone;
	}
}
#endregion


#region ---PARRY EFFECTS---
// Parry actual effect is applied upon collision with a hitbox on the player while parryWindowActive
// is true
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
#endregion


