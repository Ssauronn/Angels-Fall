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


#region Move Bullet Objects
// Move bullet objects
if ds_exists(enemyBulletHitboxList, ds_type_list) {
	var i, test_;
	for (i = 0; i <= ds_list_size(enemyBulletHitboxList) - 1; i++) {
		if instance_exists(ds_list_find_value(enemyBulletHitboxList, i)) {
			with ds_list_find_value(enemyBulletHitboxList, i) {
				// Move the bullet as long as the parent object still exists
				if instance_exists(owner) {
					x += lengthdir_x(enemyBulletHitboxSpeed, enemyBulletHitboxDirection) * owner.enemyTotalSpeed;
					y += lengthdir_y(enemyBulletHitboxSpeed, enemyBulletHitboxDirection) * owner.enemyTotalSpeed;
					if lengthdir_x(enemyBulletHitboxSpeed, enemyBulletHitboxDirection) == 0 {
						test_ = 1;
					}
				}
				// Destroy any bullets that still exist 
				else if !instance_exists(owner) {
					with obj_combat_controller {
						if ds_exists(enemyBulletHitboxList, ds_type_list) {
							instance_destroy(ds_list_find_value(enemyBulletHitboxList, i));
							ds_list_delete(enemyBulletHitboxList, i);
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


