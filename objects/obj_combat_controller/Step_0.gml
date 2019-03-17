/// @description Edit Variables
// Set the combo counter for the player to tick up once, and then reset the combo counter
if enemiesDealtDamage > 0 {
	comboCounterTimer = comboCounterTimerStartTime;
}
if (comboCounterTimer < 0) || (obj_player.key_animecro_collect) {
	comboCounter = 0;
	comboCounterTimer = -1;
	// This line below isn't needed, but it allows for instant updating of the health bar instead of a 1 frame delay
	playerMaxHP += animecroPool * animecroMultiplier;
	playerMaxAnimecroHP += animecroPool * animecroMultiplier;
	playerCurrentAnimecroHP += animecroPool * animecroMultiplier;
	playerCurrentHP += animecroPool * animecroMultiplier;
	animecroPool = 0;
	animecroMultiplier = 1;
}
if comboCounterTimer >= 0 {
	comboCounterTimer -= 1;
}
comboCounter += enemiesDealtDamage
enemiesDealtDamage = 0;

// Set Animecro Multiplier based on how many enemies have been hit consecutively
if comboCounter > 4 && comboCounter <= 10 {
	animecroMultiplier = 2;
}
else if comboCounter > 10 && comboCounter <= 31 {
	animecroMultiplier = 3;
}
else if comboCounter > 31 && comboCounter <= 60 {
	animecroMultiplier = 4;
}
else if comboCounter > 60 {
	animecroMultiplier = 5;
}

// Variables used to control the incoming and outgoing damage of both the player and other enemies
// Player
playerTotalBonusDamage = 1 + obj_skill_tree.primeBonusDamagePercentAsDecimal; // + whatever other modifiers I can change player damage with. Damage debuffs should be applied as negative numbers.
playerTotalBonusResistance = 0; // + whatever resistances the player has


#region Move Hitbox Objects
// Move player hitbox objects
if ds_exists(playerHitboxList, ds_type_list) {
	var i;
	for (i = 0; i <= ds_list_size(playerHitboxList) - 1; i++) {
		if instance_exists(ds_list_find_value(playerHitboxList, i)) {
			with ds_list_find_value(playerHitboxList, i) {
				if playerHitboxType = "Projectile" {
					// Move the hitbox as long as the parent object still exists
					if instance_exists(owner) {
						x += lengthdir_x(playerProjectileHitboxSpeed, playerHitboxDirection) * playerTotalSpeed;
						y += lengthdir_y(playerProjectileHitboxSpeed, playerHitboxDirection) * playerTotalSpeed;
					}
					else if !instance_exists(owner) {
						with obj_combat_controller {
							if ds_exists(playerHitboxList, ds_type_list) {
								instance_destroy(ds_list_find_value(playerHitboxList, i));
								ds_list_delete(playerHitboxList, i);
							}
						}
					}
				}
			}
		}
	}
}
// Move enemy hitbox objects
if ds_exists(enemyHitboxList, ds_type_list) {
	var i;
	for (i = 0; i <= ds_list_size(enemyHitboxList) - 1; i++) {
		if instance_exists(ds_list_find_value(enemyHitboxList, i)) {
			with ds_list_find_value(enemyHitboxList, i) {
				if enemyHitboxType = "Projectile" {
					// Move the hitbox as long as the parent object still exists
					if instance_exists(owner) {
						x += lengthdir_x(enemyProjectileHitboxSpeed, enemyProjectileHitboxDirection) * owner.enemyTotalSpeed;
						y += lengthdir_y(enemyProjectileHitboxSpeed, enemyProjectileHitboxDirection) * owner.enemyTotalSpeed;
					}
					// Destroy any hitboxes that still exist 
					else if !instance_exists(owner) {
						with obj_combat_controller {
							if ds_exists(enemyHitboxList, ds_type_list) {
								instance_destroy(ds_list_find_value(enemyHitboxList, i));
								ds_list_delete(enemyHitboxList, i);
							}
						}
					}
				}
			}
		}
	}
}
#endregion

#region Count Down and Eliminate Various Debuffs for Enemies
// ---COUNT DOWN (DE)BUFFS---
if instance_exists(obj_enemy) {
	with obj_enemy {
		if variable_instance_exists(self, "slowEnemyTimeWithParryTimer") {
			if slowEnemyTimeWithParryTimer > 0 {
				slowEnemyTimeWithParryTimer -= 1;
			}
		}
	}
}

// ---ELIMINATE (DE)BUFFS---
if instance_exists(obj_enemy) {
	with obj_enemy {
		if variable_instance_exists(self, "slowEnemyTimeWithParryTimer") {
			if slowEnemyTimeWithParryTimer > 0 {
				slowEnemyTimeWithParryActive = true;
			}
			else {
				slowEnemyTimeWithParryActive = false;
				enemyGameSpeed = 1;
			}
		}
	}
}
#endregion


