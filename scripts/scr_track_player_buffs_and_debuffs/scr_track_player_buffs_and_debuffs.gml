///@description Track All Buffs and Debuffs That Effect Player Bonus Damage and Resistance
with obj_skill_tree {
	#region Buffs
	#region Tier 1 Abilities
	#region True Caelesti Wings
	if trueCaelestiWingsTimer >= 0 {
		trueCaelestiWingsActive = true;
	}
	if trueCaelestiWingsActive {
		if trueCaelestiWingsTimer < 0 {
			trueCaelestiWingsActive = false;
			trueCaelestiWingsDamageMultiplier = 1;
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					instance_to_reference_.trueCaelestiWingsDebuffTimer = -1;
					instance_to_reference_.trueCaelestiWingsDebuffDamageMultiplier = 1;
					instance_to_reference_.trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
				}
			}
		}
		else if trueCaelestiWingsTimer >= 0 {
			trueCaelestiWingsTimer--;
			trueCaelestiWingsDamageMultiplier = trueCaelestiWingsBaseDamageMultiplier;
		}
	}
	
	#region Death Incarnate
	if !deathIncarnateFirstPhaseActive && !deathIncarnateSecondPhaseActive {
		deathIncarnateSecondPhaseCurrentDamage = deathIncarnateSecondPhaseStartDamage;
	}
	// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
	// Just put this here to find it later. I need to reset deathIncarnateSecondPhaseCurrentDamage to
	// equal deathIncarnateSecondPhaseStartDamage if the second phase is currently active and the player
	// sends out a new death incarnate, immediately setting to firstphaseactive without both ever being 
	// not active on either phase and resetting the current damage in the line above.
	#endregion
	#endregion
	#endregion
	
	#region Tier 2 Abilities
	#region Armor of the Caelesti
	if armorOfTheCaelestiTimer >= 0 {
		armorOfTheCaelestiActive = true;
	}
	if armorOfTheCaelestiActive {
		if armorOfTheCaelestiRemainingHPBeforeExplosion <= 0 {
			armorOfTheCaelestiActive = false;
			armorOfTheCaelestiTimer = -1;
			armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
		}
		if armorOfTheCaelestiTimer < 0 {
			armorOfTheCaelestiActive = false;
			armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
		}
		else if armorOfTheCaelestiTimer >= 0 {
			armorOfTheCaelestiTimer--;
			armorOfTheCaelestiResistanceMultiplier = armorOfTheCaelestiBaseResistanceMultiplier;
		}
	}
	#endregion
	
	#region Glinting Blade
	// I only track the timer for Glinting Blade if the ability is not attached to an enemy, because
	// otherwise, I track the timer inside the scr_track_enemy_buffs_and_debuffs script for that
	// specific enemy.
	if glintingBladeTimer >= 0 {
		if glintingBladeAttachedToEnemy == noone {
			glintingBladeActive = true;
		}
	}
	if glintingBladeActive {
		if glintingBladeAttachedToEnemy == noone {
			if glintingBladeTimer < 0 {
				glintingBladeActive = false;
				glintingBladeArrivedAtTargetPos = false;
				glintingBladeTargetXPos = 0;
				glintingBladeTargetYPos = 0;
				glintingBladeXPos = 0;
				glintingBladeYPos = 0;
				glintingBladeAttachedToEnemy = noone;
			}
			else if glintingBladeTimer >= 0 {
				glintingBladeTimer--;
			}
		}
	}
	#endregion
	#endregion
	
	#region Tier 3 Abilities
	#region All Out Attack
	if allOutAttackTimer >= 0 {
		allOutAttackActive = true;
	}
	if allOutAttackActive {
		if allOutAttackTimer < 0 {
			allOutAttackActive = false;
		}
		else if allOutAttackTimer >= 0 {
			allOutAttackTimer--;
		}
	}
	#endregion
	
	#region Purifying Rage
	if purifyingRageTimer >= 0 {
		purifyingRageActive = true;
	}
	if purifyingRageActive {
		if purifyingRageTimer < 0 {
			purifyingRageActive = false;
			purifyingRageDamageMultiplierForPoisons = 1;
		}
		else if purifyingRageTimer >= 0 {
			purifyingRageTimer--;
			purifyingRageDamageMultiplierForPoisons = purifyingRageBaseDamageMultiplierForPoisons;
		}
	}
	#endregion
	
	#region Holy Defense
	if holyDefenseTimer >= 0 {
		holyDefenseActive = true;
	}
	if holyDefenseActive {
		if holyDefenseTimer < 0 {
			holyDefenseActive = false;
			holyDefenseStruckDamage = 0;
			holyDefenseParryDamage = 0;
		}
		else if holyDefenseTimer >= 0 {
			holyDefenseTimer--;
			holyDefenseStruckDamage = holyDefenseBaseDamage * 0.5;
			holyDefenseParryDamage = holyDefenseBaseDamage * 1;
		}
	}
	#endregion
	
	#region Wrath of the Repentant
	if wrathOfTheRepentantTimer >= 0 {
		wrathOfTheRepentantActive = true;
	}
	if wrathOfTheRepentantActive {
		if wrathOfTheRepentantTimer < 0 {
			wrathOfTheRepentantActive = false
			wrathOfTheRepentantBasicMeleeDamageBonus = 1;
		}
		else if wrathOfTheRepentantTimer >= 0 {
			wrathOfTheRepentantBasicMeleeDamageBonus = wrathOfTheRepentantBaseBasicMeleeDamageBonus;
		}
	}
	#endregion
	
	#region The One Power
	if theOnePowerTimer >= 0 {
		theOnePowerActive = true;
	}
	if theOnePowerActive {
		if theOnePowerTimer < 0 {
			theOnePowerActive = false;
		}
		else if theOnePowerTimer >= 0 {
			theOnePowerTimer--;
			theOnePowerOriginXPos = obj_player.x + lengthdir_x(theOnePowerRotationDistanceFromPlayer, theOnePowerRotationAngle);
			theOnePowerOriginYPos = obj_player.y + lengthdir_y(theOnePowerRotationDistanceFromPlayer, theOnePowerRotationAngle);
			theOnePowerRotationAngle += 360 / (theOnePowerRotationTimeForAFullCircle);
			if theOnePowerRotationAngle >= 360 {
				theOnePowerRotationAngle -= 360;
			}
			if theOnePowerTicTimer < 0 {
				theOnePowerTicTimer = theOnePowerTicTimerStartTime;
				// Here, create a projectile with an origin point at theOnePowerOriginXPos and
				// theOnePowerOriginYPos, and with a direction towards the nearest enemy, as long as
				// the nearest enemy is within theOnePowerRange, and a speed of
				// theOnePowerPorjectileSpeed.
				with obj_player {
					#region Create Whole Hitbox
					var target_;
					target_ = noone;
					if ds_exists(objectIDsInBattle, ds_type_list) {
						var i;
						for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
							var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
							if !instance_exists(target_) {
								target_ = instance_to_reference_;
							}
							else if (point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y)) < (point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y)) {
								target_ = instance_to_reference_
							}
						}
						if instance_exists(target_) {
							playerHitbox = instance_create_depth(obj_skill_tree.theOnePowerOriginXPos, obj_skill_tree.theOnePowerOriginYPos, -999, obj_hitbox);
							playerHitbox.sprite_index = spr_player_bullet_hitbox;
							playerHitbox.mask_index = spr_player_bullet_hitbox;
							playerHitbox.owner = self;
							playerHitbox.playerProjectileHitboxSpeed = obj_skill_tree.theOnePowerProjectileSpeed;
							playerHitbox.playerProjectileHitboxDirection = point_direction(obj_skill_tree.theOnePowerOriginXPos, obj_skill_tree.theOnePowerOriginYPos, target_.x, target_.y);
							playerHitbox.image_angle = playerHitbox.playerProjectileHitboxDirection;
							playerHitbox.visible = true;
							playerHitbox.playerHitboxAttackType = "Projectile";
							playerHitbox.playerHitboxDamageType = "Ability";
							playerHitbox.playerHitboxAbilityOrigin = "The One Power";
							playerHitbox.playerHitboxHeal = false;
							playerHitbox.playerHitboxValue = obj_skill_tree.theOnePowerDamage;
							playerHitbox.playerHitboxCollisionFound = false;
							playerHitbox.playerHitboxLifetime = 300;
							playerHitbox.playerHitboxCollidedWithWall = false;
							playerHitbox.playerHitboxPersistAfterCollision = false;
							// The next variable is the timer that determines when an object will apply damage again to
							// an object its colliding with repeatedly. This only takes effect if the hitbox's
							// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
							// destroyed upon colliding with the first object it can and no chance will be given for the
							// hitbox to deal damage repeatedly to the object.
							playerHitbox.playerHitboxTicTimer = 1;
							playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
							// This is the variable which will be an array of all objects the hitbox has collided with
							// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
							// it has collided with in the first place
							playerHitbox.playerHitboxTargetArray = noone;
							// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
							// that unless that hitbox collides with the exact object its meant for, it won't interact
							// with that object. If the hitbox has no specific target, this is set to noone.
							playerHitbox.playerHitboxSpecificTarget = noone;
							
							if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
								ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
							}
							else {
								obj_combat_controller.playerHitboxList = ds_list_create();
								ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
							}
						}
					}
					#endregion
				}
			}
			else if theOnePowerTicTimer >= 0 {
				theOnePowerTicTimer--;
			}
		}
	}
	#endregion
	
	#region Lightning Spear
	if lightningSpearBasicMeleeDamageMultiplierActive {
		lightningSpearBasicMeleeDamageMultiplier = lightningSpearBaseBasicMeleeDamageMultiplier;
	}
	else if !lightningSpearBasicMeleeDamageMultiplierActive {
		lightningSpearBasicMeleeDamageMultiplier = 1;
	}
	#endregion
	#endregion
	
	#region Tier 4 Abilities
	#region Rushdown
	if rushdownDashDamageMultiplierActive {
		rushdownDashDamageMultiplier = rushdownDashBaseDamageMultiplier;
	}
	else if !rushdownDashDamageMultiplierActive {
		rushdownDashDamageMultiplier = 1;
	}
	#endregion
	#endregion
	#endregion


	#region Debuffs

	#endregion


	#region Poisons

	#endregion


	#region Stuns

	#endregion
}


