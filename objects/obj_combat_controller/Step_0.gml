/// @description Edit Variables
// Set the combo counter for the player to tick up once, and then reset the combo counter
if enemyHitByPlayer {
	comboCounterTimer = comboCounterTimerStartTime;
	enemyHitByPlayer = false;
}
// If the combo timer runs out, or the player collects on the combo early, then reset variables, add to the player's
// Max HP, and add to the player's current HP
if (comboCounterTimer < 0) || (obj_player.key_animecro_collect) {
	// Reset combo variables
	comboCounter = 0;
	comboCounterTimer = -1;
	comboDamageDealt = 0;
	// This one line below isn't needed, but it allows for instant updating of the health bar instead of a 1 frame delay
	playerMaxHP += animecroPool * animecroMultiplier;
	playerMaxAnimecroHP += animecroPool * animecroMultiplier;
	playerCurrentAnimecroHP += animecroPool * animecroMultiplier;
	playerCurrentHP += animecroPool * animecroMultiplier;
	playerCurrentBloodMagic += bloodMagicPool * animecroMultiplier;
	bloodMagicPool = 0;
	animecroPool = 0;
	animecroMultiplier = 1;
}
if comboCounterTimer >= 0 {
	comboCounterTimer -= 1;
}
if comboDamageDealt > 100 {
	comboDamageDealt -= 100;
	comboCounter++;
}

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
// Player Bonus Damage, Bonus Basic Melee Damage, and Bonus Resistance
playerTotalBonusDamage = 1 * obj_skill_tree.allIsGivenMultiplier * obj_skill_tree.forTheGreaterGoodDamageMultiplier * obj_skill_tree.trueCaelestiWingsDamageMultiplier * obj_skill_tree.rushdownDashDamageMultiplier; // * whatever other modifiers I can change player damage with, numbers greater than 1.
playerTotalBonusBasicMeleeDamage = playerTotalBonusDamage * obj_skill_tree.wrathOfTheRepentantBasicMeleeDamageBonus * obj_skill_tree.lightningSpearBasicMeleeDamageMultiplier; // * whatever other modifiers I can change the player basic melee damage with, numbers greater than 1.
playerTotalBonusResistance = 1 * obj_skill_tree.lifeTaxBonusDamageResistanceMultiplier * obj_skill_tree.armorOfTheCaelestiResistanceMultiplier; // * whatever other modifiers I can change the player resistance with, numbers greater than 0 and less than 1.


#region Move Hitbox Objects
// Move player hitbox objects
if ds_exists(playerHitboxList, ds_type_list) {
	var i;
	for (i = 0; i <= ds_list_size(playerHitboxList) - 1; i++) {
		if instance_exists(ds_list_find_value(playerHitboxList, i)) {
			with ds_list_find_value(playerHitboxList, i) {
				if playerHitboxAttackType = "Projectile" {
					// Move the hitbox as long as the parent object still exists
					if instance_exists(owner) {
						if (playerHitboxAbilityOrigin != "Glinting Blade") && (playerHitboxAbilityOrigin != "Whirlwind") {
							x += lengthdir_x(playerProjectileHitboxSpeed, playerHitboxDirection) * playerTotalSpeed;
							y += lengthdir_y(playerProjectileHitboxSpeed, playerHitboxDirection) * playerTotalSpeed;
						}
						else if playerHitboxAbilityOrigin == "Glinting Blade" {
							var distance_to_target_ = point_distance(x, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos);
							if distance_to_target_ > obj_skill_tree.glintingBladeSpeed {
								x += lengthdir_x(obj_skill_tree.glintingBladeSpeed, obj_skill_tree.glintingBladeDirection) * playerTotalSpeed;
								y += lengthdir_y(obj_skill_tree.glintingBladeSpeed, obj_skill_tree.glintingBladeDirection) * playerTotalSpeed;
							}
							else if distance_to_target_ <= obj_skill_tree.glintingBladeSpeed {
								obj_skill_tree.glintingBladeActive = true;
								obj_skill_tree.glintingBladeArrivedAtTargetPos = true;
								obj_skill_tree.glintingBladeAttachedToEnemy = noone;
								playerHitboxCollisionFound = true;
								x = obj_skill_tree.glintingBladeTargetXPos;
								y = obj_skill_tree.glintingBladeTargetYPos;
								obj_skill_tree.glintingBladeXPos = x;
								obj_skill_tree.glintingBladeYPos = y;
								obj_skill_tree.glintingBladeTimer = obj_skill_tree.glintingBladeTimerStartTime;
							}
						}
						else if playerHitboxAbilityOrigin == "Whirlwind" {
							var distance_to_target_ = point_distance(x, y, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
							if distance_to_target_ > obj_skill_tree.whirlwindSpeed {
								x += lengthdir_x(obj_skill_tree.whirlwindSpeed, obj_skill_tree.whirlwindDirection) * playerTotalSpeed;
								y += lengthdir_y(obj_skill_tree.whirlwindSpeed, obj_skill_tree.whirlwindDirection) * playerTotalSpeed;
							}
							else if distance_to_target_ <= obj_skill_tree.whirlwindSpeed {
								obj_skill_tree.whirlwindArrivedAtTargetPos = true;
								playerHitboxCollisionFound = true;
								x = obj_skill_tree.whirlwindTargetXPos;
								y = obj_skill_tree.whirlwindTargetYPos;
							}
						}
					}
					else if !instance_exists(owner) {
						with obj_combat_controller {
							// If the owner of the hitbox current referenced doesn't exist, destroy the hitbox
							// and erase the DS List
							if ds_exists(playerHitboxList, ds_type_list) {
								instance_destroy(ds_list_find_value(playerHitboxList, i));
								ds_list_delete(playerHitboxList, i);
							}
							// And if, after the hitbox was destroyed and erased from the DS List, there are no 
							// longer any existing hitboxes, then destroy the DS List as well
							var j, a_hitbox_still_exists_;
							a_hitbox_still_exists_ = false;
							for (j = 0; j <= ds_list_size(playerHitboxList) - 1; j++) {
								var instance_to_reference_ = ds_list_find_value(playerHitboxList, j);
								if instance_exists(instance_to_reference_) {
									a_hitbox_still_exists_ = true;
								}
							}
							if !a_hitbox_still_exists_ {
								ds_list_destroy(playerHitboxList);
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
				if enemyHitboxAttackType == "Projectile" {
					// Move the hitbox as long as the parent object still exists
					if instance_exists(owner) {
						x += lengthdir_x(enemyProjectileHitboxSpeed, enemyProjectileHitboxDirection) * owner.enemyTotalSpeed;
						y += lengthdir_y(enemyProjectileHitboxSpeed, enemyProjectileHitboxDirection) * owner.enemyTotalSpeed;
					}
					// Destroy any hitboxes that still exist 
					else if !instance_exists(owner) {
						with obj_combat_controller {
							// If the owner of the hitbox current referenced doesn't exist, destroy the hitbox
							// and erase the DS List
							if ds_exists(enemyHitboxList, ds_type_list) {
								instance_destroy(ds_list_find_value(enemyHitboxList, i));
								ds_list_delete(enemyHitboxList, i);
							}
							// And if, after the hitbox was destroyed and erased from the DS List, there are no 
							// longer any existing hitboxes, then destroy the DS List as well
							var j, a_hitbox_still_exists_;
							a_hitbox_still_exists_ = false;
							for (j = 0; j <= ds_list_size(enemyHitboxList) - 1; j++) {
								var instance_to_reference_ = ds_list_find_value(enemyHitboxList, j);
								if instance_exists(instance_to_reference_) {
									a_hitbox_still_exists_ = true;
								}
							}
							if !a_hitbox_still_exists_ {
								ds_list_destroy(enemyHitboxList);
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
if ds_exists(objectIDsInBattle, ds_type_list) {
	var i;
	for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
		with ds_list_find_value(objectIDsInBattle, i) {
			if variable_instance_exists(self, "slowEnemyTimeWithParryTimer") {
				if slowEnemyTimeWithParryTimer > 0 {
					slowEnemyTimeWithParryTimer -= 1;
				}
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
				enemyGameSpeed += 1;
			}
		}
	}
}
#endregion


