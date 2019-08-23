/// @description Edit Variables
// Set the combo counter for the player to tic up once, and then reset the combo counter
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
	playerCurrentAnimecroHP += animecroPool * animecroMultiplier * 2;
	playerCurrentHP += animecroPool * animecroMultiplier * 2;
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
				if playerHitboxAttackType == "Projectile" {
					// Move the hitbox as long as the parent object still exists
					if instance_exists(owner) {
						if (playerHitboxAbilityOrigin != "Glinting Blade") && (playerHitboxAbilityOrigin != "Whirlwind") {
							x += lengthdir_x(playerProjectileHitboxSpeed, playerProjectileHitboxDirection) * playerTotalSpeed;
							y += lengthdir_y(playerProjectileHitboxSpeed, playerProjectileHitboxDirection) * playerTotalSpeed;
						}
						else if playerHitboxAbilityOrigin == "Glinting Blade" {
							var distance_to_target_ = point_distance(x, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos);
							if distance_to_target_ > (obj_skill_tree.glintingBladeSpeed * playerTotalSpeed) {
								x += lengthdir_x(obj_skill_tree.glintingBladeSpeed, obj_skill_tree.glintingBladeDirection) * playerTotalSpeed;
								y += lengthdir_y(obj_skill_tree.glintingBladeSpeed, obj_skill_tree.glintingBladeDirection) * playerTotalSpeed;
								obj_skill_tree.glintingBladeXPos = x;
								obj_skill_tree.glintingBladeYPos = y;
							}
							else if distance_to_target_ <= (obj_skill_tree.glintingBladeSpeed * playerTotalSpeed) {
								obj_skill_tree.glintingBladeActive = true;
								obj_skill_tree.glintingBladeArrivedAtTargetPos = true;
								obj_skill_tree.glintingBladeAttachedToEnemy = noone;
								// Destroy the player hitbox if its a projectile from Glinting Blade and it has reached
								// its target on the ground without running into an enemy.
								playerHitboxCollisionFound = true;
								x = obj_skill_tree.glintingBladeTargetXPos;
								y = obj_skill_tree.glintingBladeTargetYPos;
								obj_skill_tree.glintingBladeXPos = obj_skill_tree.glintingBladeTargetXPos;
								obj_skill_tree.glintingBladeYPos = obj_skill_tree.glintingBladeTargetYPos;
								obj_skill_tree.glintingBladeTimer = obj_skill_tree.glintingBladeTimerStartTime;
							}
						}
						else if playerHitboxAbilityOrigin == "Whirlwind" {
							var distance_to_target_ = point_distance(x, y, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
							if distance_to_target_ > (obj_skill_tree.whirlwindSpeed * playerTotalSpeed) {
								obj_skill_tree.whirlwindArrivedAtTargetPos = false;
								x += lengthdir_x(obj_skill_tree.whirlwindSpeed, obj_skill_tree.whirlwindDirection) * playerTotalSpeed;
								y += lengthdir_y(obj_skill_tree.whirlwindSpeed, obj_skill_tree.whirlwindDirection) * playerTotalSpeed;
							}
							else if distance_to_target_ <= (obj_skill_tree.whirlwindSpeed * playerTotalSpeed) {
								if obj_skill_tree.whirlwindFirstPhaseActive {
									if instance_exists(obj_player) {
										obj_skill_tree.whirlwindArrivedAtTargetPos = true;
										playerHitboxCollisionFound = true;
										// Create new whirlwind hitbox
										obj_skill_tree.whirlwindFirstPhaseActive = false;
										obj_skill_tree.whirlwindSecondPhaseActive = true;
										with obj_player {
											playerHitbox = instance_create_depth(obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos, -999, obj_hitbox);
											var player_hitbox_ = playerHitbox.id;
										}
										obj_skill_tree.whirlwindTargetXPos = obj_player.x;
										obj_skill_tree.whirlwindTargetYPos = obj_player.y;
										obj_skill_tree.whirlwindDirection = point_direction(x, y, obj_skill_tree.whirlwindTargetXPos, obj_skill_tree.whirlwindTargetYPos);
										player_hitbox_.sprite_index = spr_whirlwind_hitbox;
										player_hitbox_.mask_index = spr_whirlwind_hitbox;
										player_hitbox_.owner = obj_player.id;
										player_hitbox_.playerProjectileHitboxSpeed = obj_skill_tree.whirlwindSpeed;
										player_hitbox_.playerProjectileHitboxDirection = obj_skill_tree.whirlwindDirection;
										player_hitbox_.image_angle = player_hitbox_.playerProjectileHitboxDirection;
										player_hitbox_.visible = true;
										player_hitbox_.playerHitboxAttackType = "Projectile";
										player_hitbox_.playerHitboxDamageType = "Basic Melee";
										player_hitbox_.playerHitboxAbilityOrigin = "Whirlwind";
										player_hitbox_.playerHitboxHeal = false;
										player_hitbox_.playerHitboxValue = obj_skill_tree.whirlwindDamage;
										player_hitbox_.playerHitboxCollisionFound = false;
										player_hitbox_.playerHitboxLifetime = 300;
										player_hitbox_.playerHitboxCollidedWithWall = false;
										player_hitbox_.playerHitboxPersistAfterCollision = true;
										// The next variable is the timer that determines when an object will apply damage again to
										// an object its colliding with repeatedly. This only takes effect if the hitbox's
										// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
										// destroyed upon colliding with the first object it can and no chance will be given for the
										// hitbox to deal damage repeatedly to the object.
										player_hitbox_.playerHitboxTicTimer = player_hitbox_.playerHitboxLifetime + 1;
										player_hitbox_.playerHitboxCanBeTransferredThroughSoulTether = true;
										// This is the variable which will be an array of all objects the hitbox has collided with
										// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
										// it has collided with in the first place
										player_hitbox_.playerHitboxTargetArray = noone;
										// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
										// that unless that hitbox collides with the exact object its meant for, it won't interact
										// with that object. If the hitbox has no specific target, this is set to noone.
										player_hitbox_.playerHitboxSpecificTarget = noone;

										if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
											ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), player_hitbox_);
										}
										else {
											obj_combat_controller.playerHitboxList = ds_list_create();
											ds_list_set(obj_combat_controller.playerHitboxList, 0, player_hitbox_);
										}
									}
								}
								else if obj_skill_tree.whirlwindSecondPhaseActive {
									obj_skill_tree.whirlwindActive = false;
									obj_skill_tree.whirlwindArrivedAtTargetPos = true;
									playerHitboxCollisionFound = true;
									obj_skill_tree.whirlwindFirstPhaseActive = false;
									obj_skill_tree.whirlwindSecondPhaseActive = false;
								}
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
								playerHitboxList = noone;
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
								enemyHitboxList = noone;
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
				if slowEnemyTimeWithParryActive {
					slowEnemyTimeWithParryActive = false;
					enemyGameSpeed += 1;
				}
			}
		}
	}
}
#endregion


