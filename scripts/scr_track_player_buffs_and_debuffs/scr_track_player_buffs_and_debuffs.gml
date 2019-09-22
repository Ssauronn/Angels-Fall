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
					if instance_exists(instance_to_reference_) {
						instance_to_reference_.trueCaelestiWingsDebuffTimer = -1;
						instance_to_reference_.trueCaelestiWingsDebuffDamageMultiplier = 1;
						instance_to_reference_.trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
					}
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
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					var i;
					for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						if instance_exists(instance_to_reference_) {
							if instance_to_reference_.combatFriendlyStatus == "Enemy" {
								if point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y) <= armorOfTheCaelestiExplosionRange {
									create_dot_tic_hitbox(instance_to_reference_.id, armorOfTheCaelestiExplosionDamage, true);
								}
							}
						}
					}
				}
			}
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
	
	#region Taken for Pain
	// Rotate the hitboxes and fix their position as long as they're not moving
	if takenForPainFirstPhaseActive || takenForPainSecondPhaseActive {
		if ds_exists(takenForPainHitboxList, ds_type_list) {
			var i;
			for (i = 0; i <= ds_list_size(takenForPainHitboxList) - 1; i++) {
				if !is_undefined(ds_list_find_value(takenForPainHitboxList, i)) {
					var instance_to_reference_ = ds_list_find_value(takenForPainHitboxList, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.playerProjectileHitboxSpeed == 0 {
							// Rotate the hitboxes while they hover around the player - rotation_speed_
							// is currently set to rotate the hitboxes 360 before launching them towards
							// target.
							var rotation_speed_ = 360 / takenForPainFirstPhaseTimerStartTime;
							instance_to_reference_.playerProjectileHitboxDirection += rotation_speed_;
							if instance_to_reference_.playerProjectileHitboxDirection  >= 360 {
								instance_to_reference_.playerProjectileHitboxDirection -= 360;
							}
							instance_to_reference_.image_angle = instance_to_reference_.playerProjectileHitboxDirection;
							
							
							// Keep the hitboxes in place while they hover around the player
							var k, x_location_, y_location_;
							// Set the location of each hitbox, spread evenly in a circle around the player.
							// First, set the angle the object will sit at based on its location index in the
							// takenForPainHitboxList.
							// Then, make sure it doesn't exceed 360 degrees, and finally set the actual
							// x_location_ and y_location_ to the x and y coordinates they should be sitting at
							// around the player.
							k = (takenForPainNumberOfSpikes - 1) - i;
							x_location_ = (k * (360 / takenForPainNumberOfSpikes)) + ((floor(takenForPainNumberOfSpikes / 4) + 1) * (360 / takenForPainNumberOfSpikes));
							y_location_ = (k * (360 / takenForPainNumberOfSpikes)) + ((floor(takenForPainNumberOfSpikes / 4) + 1) * (360 / takenForPainNumberOfSpikes));
							if x_location_ >= 360 {
								x_location_ -= 360;
							}
							if y_location_ >= 360 {
								y_location_ -= 360;
							}
							x_location_ = obj_player.x + lengthdir_x(32 * 1.5, x_location_);
							y_location_ = obj_player.y + lengthdir_y(32 * 1.5, y_location_);
							instance_to_reference_.x = x_location_;
							instance_to_reference_.y = y_location_;
						}
					}
				}
			}
		}
	}
	
	if takenForPainFirstPhaseTimer >= 0 {
		takenForPainFirstPhaseActive = true;
	}
	if takenForPainFirstPhaseActive {
		if takenForPainFirstPhaseTimer < 0 {
			takenForPainFirstPhaseActive = false;
			if ds_exists(takenForPainHitboxList, ds_type_list) {
				ds_list_destroy(takenForPainHitboxList);
				takenForPainHitboxList = noone;
			}
		}
		else if takenForPainFirstPhaseTimer >= 0 {
			var quadrant_;
			for (quadrant_ = 0; quadrant_ <= (takenForPainNumberOfSpikes - 1); quadrant_++) {
				if takenForPainFirstPhaseTimer <= (takenForPainFirstPhaseTimerStartTime / takenForPainNumberOfSpikes) * (quadrant_ + 1) {
					quadrant_ = abs(quadrant_ - (takenForPainNumberOfSpikes - 1))
					break;
				}
			}
			if (!ds_exists(takenForPainHitboxList, ds_type_list)) || ((is_undefined(ds_list_find_value(takenForPainHitboxList, quadrant_)))) {
				if (quadrant_ == 0) && (!ds_exists(takenForPainHitboxList, ds_type_list)) {
					takenForPainHitboxList = ds_list_create();
				}
				// If the list hasn't exceeded the quadrant value, and the target index in the list
				// hasn't yet had a hitbox created, then create the hitbox.
				if (is_undefined(ds_list_find_value(takenForPainHitboxList, quadrant_))) || (!instance_exists(ds_list_find_value(takenForPainHitboxList, quadrant_))) {
					#region Create the hitbox and store the hitbox ID in the takenForPainHitboxList
					// Set the direction relative to the player the hitbox should be created at, spread 
					// evenly in a circle no matter how many spikes are created, starting at the top right
					// of the player.
					var x_location_, y_location_;
					x_location_ = (360 / takenForPainNumberOfSpikes) - (quadrant_ * (360 / takenForPainNumberOfSpikes))
					y_location_ = (360 / takenForPainNumberOfSpikes) - (quadrant_ * (360 / takenForPainNumberOfSpikes))
					if x_location_ < 0 {
						x_location_ += 360;
					}
					if y_location_ < 0 {
						y_location_ += 360;
					}
					x_location_ = obj_player.x + lengthdir_x(32 * 1.5, x_location_);
					y_location_ = obj_player.y + lengthdir_y(32 * 1.5, y_location_);
					with obj_player {
						var owner_ = self;
						playerHitbox = instance_create_depth(x_location_, y_location_, -999, obj_hitbox);
						playerHitbox.sprite_index = spr_player_bullet_hitbox;
						playerHitbox.mask_index = spr_player_bullet_hitbox;
						playerHitbox.owner = owner_;
						playerHitbox.playerProjectileHitboxSpeed = 0;
						playerHitbox.playerProjectileHitboxDirection = 90;
						playerHitbox.image_angle = 90;
						playerHitbox.visible = true;
						playerHitbox.playerHitboxAttackType = "Projectile";
						playerHitbox.playerHitboxDamageType = "Ability";
						playerHitbox.playerHitboxAbilityOrigin = "Taken for Pain";
						playerHitbox.playerHitboxHeal = false;
						playerHitbox.playerHitboxValue = obj_skill_tree.takenForPainDamagePerSpike;
						playerHitbox.playerHitboxCollisionFound = false;
						playerHitbox.playerHitboxLifetime = 300 + obj_skill_tree.takenForPainFirstPhaseTimerStartTime;
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
					
						// Finally, add the hitbox to the takenForPainHitboxList so that I can manipulate
						// it later on.
						ds_list_add(obj_skill_tree.takenForPainHitboxList, playerHitbox);
					}
					#endregion
				}
			}
			/*
			create the hitboxes in a circular fashion around the player
			creation is dependant on a timer
			do this by storing the hitbox ID's in the takenForPainHitboxList, and if the ds_list size - 1
			is equal to or less than the quadrant we're currently on, then don't create the hitbox.
			once first phase is complete, activate second phase
			one by one, launch hitboxes at targets rotating through all enemies that are within range
			this will automatically spread the hitboxes as evenly as possible
			
			*/
			takenForPainFirstPhaseTimer--;
		}
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


