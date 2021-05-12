///@description Track All Buffs and Debuffs That Effect Player Bonus Damage and Resistance
function scr_track_player_buffs_and_debuffs() {
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
				wrathOfTheRepentantTimer--;
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
								playerHitbox.owner = self.id;
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
		if takenForPainFirstPhaseTimer >= 0 {
			takenForPainFirstPhaseActive = true;
		}
		if takenForPainFirstPhaseActive {
			if takenForPainFirstPhaseTimer < 0 {
				takenForPainFirstPhaseActive = false;
				takenForPainSecondPhaseActive = true;
				takenForPainSecondPhaseTimer = takenForPainSecondPhaseTimerStartTime;
			}
			else if takenForPainFirstPhaseTimer >= 0 {
				var quadrant_;
				// Set the quadrant_ variable equal to what area number I am next creating a hitbox in.
				for (quadrant_ = 0; quadrant_ <= (takenForPainNumberOfSpikes - 1); quadrant_++) {
					if takenForPainFirstPhaseTimer <= (takenForPainFirstPhaseTimerStartTime / takenForPainNumberOfSpikes) * (quadrant_ + 1) {
						// I count up from 0 and then reverse the quadrant_ value because otherwise
						// the hitbox would be created in the first quadrant_, everytime
						quadrant_ = abs(quadrant_ - (takenForPainNumberOfSpikes - 1))
						break;
					}
				}
				// If a hitbox from this ability doesn't even exist, or if hitboxes exist but not the correct
				// one, then create the hitbox needed for the set quadrant_.
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
						x_location_ = obj_player.x + lengthdir_x(32 * 1.25, x_location_);
						y_location_ = obj_player.y + lengthdir_y(32 * 1.25, y_location_);
						with obj_player {
							// Create the actual hitbox and assign all relevant variables
							var owner_ = self.id;
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
				// Count down the timer after I do everything else first
				takenForPainFirstPhaseTimer--;
			}
		}
	
	
		// Continue rotating projectiles and launch them towards their target when necessary
		if takenForPainSecondPhaseTimer >= 0 {
			takenForPainSecondPhaseActive = true;
		}
		if takenForPainSecondPhaseActive {
			if takenForPainSecondPhaseTimer < 0 {
				takenForPainSecondPhaseActive = false;
				if ds_exists(takenForPainHitboxList, ds_type_list) {
					ds_list_destroy(takenForPainHitboxList);
					takenForPainHitboxList = -1;
				}
			}
			else if takenForPainSecondPhaseTimer >= 0 {
				var quadrant_;
				// Set the quadrant_ variable equal to what area number I am next launching the hitbox
				// from.
				for (quadrant_ = 0; quadrant_ <= (takenForPainNumberOfSpikes - 1); quadrant_++) {
					if takenForPainSecondPhaseTimer <= (takenForPainSecondPhaseTimerStartTime / takenForPainNumberOfSpikes) * (quadrant_ + 1) {
						// I count up from 0 and then reverse the quadrant_ value because otherwise
						// the hitbox would be created in the first quadrant_, everytime
						quadrant_ = abs(quadrant_ - (takenForPainNumberOfSpikes - 1));
						break;
					}
				}
				if ds_exists(takenForPainHitboxList, ds_type_list) {
					if instance_exists(ds_list_find_value(takenForPainHitboxList, quadrant_)) {
						var self_hitbox_ = ds_list_find_value(takenForPainHitboxList, quadrant_);
						var j, iteration_, target_to_fire_towards_, direction_to_fire_in_;
						iteration_ = 0;
						target_to_fire_towards_ = obj_player;
						direction_to_fire_in_ = point_direction(self_hitbox_.x, self_hitbox_.y, obj_player.x, obj_player.y);
						if ds_exists(objectIDsInBattle, ds_type_list) {
							if quadrant_ >= (ds_list_size(objectIDsInBattle) - 1) {
								// Count through the objectIDsInBattle list, looping through if necessary, until
								// I get to the correct object to target.
								for (j = 0; j <= quadrant_; j++) {
									// First, count up iteration_ and only count up iteration_
									if j != quadrant_ {
										iteration_++;
										if iteration_ > (ds_list_size(objectIDsInBattle) - 1) {
											iteration_ = 0;
										}
									}
									// Then, when iteration_ is equal to the ds_list index I need to target,
									// set that as a target.
									else {
										var secondary_instance_to_reference_ = ds_list_find_value(objectIDsInBattle, iteration_);
										if instance_exists(secondary_instance_to_reference_) {
											target_to_fire_towards_ = secondary_instance_to_reference_;
											direction_to_fire_in_ = point_direction(self_hitbox_.x, self_hitbox_.y, secondary_instance_to_reference_.x, secondary_instance_to_reference_.y);
										}
									}
								}
							}
							else {
								var secondary_instance_to_reference_ = ds_list_find_value(objectIDsInBattle, quadrant_);
								if instance_exists(secondary_instance_to_reference_) {
									target_to_fire_towards_ = secondary_instance_to_reference_;
									direction_to_fire_in_ = point_direction(self_hitbox_.x, self_hitbox_.y, secondary_instance_to_reference_.x, secondary_instance_to_reference_.y);
								}
							}
						}
						self_hitbox_.playerProjectileHitboxSpeed = takenForPainSpeed;
						self_hitbox_.playerProjectileHitboxDirection = direction_to_fire_in_;
						self_hitbox_.image_angle = direction_to_fire_in_;
						ds_list_set(takenForPainHitboxList, quadrant_, noone);
					}
					if quadrant_ == (takenForPainNumberOfSpikes - 1) {
						if ds_exists(takenForPainHitboxList, ds_type_list) {
							ds_list_destroy(takenForPainHitboxList);
							takenForPainHitboxList = noone;
						}
					}
					takenForPainSecondPhaseTimer--;
				}
				else if takenForPainSecondPhaseTimer <= 10 {
					takenForPainFirstPhaseTimer = -1;
					takenForPainFirstPhaseActive = false;
					takenForPainSecondPhaseTimer = -1;
					takenForPainSecondPhaseActive = false;
				}
			}
		}
	
	
		// Rotate the hitboxes and fix their position as long as they're not moving
		if (takenForPainFirstPhaseActive) || (takenForPainSecondPhaseActive) {
			if ds_exists(takenForPainHitboxList, ds_type_list) {
				var i;
				for (i = 0; i <= ds_list_size(takenForPainHitboxList) - 1; i++) {
					if !is_undefined(ds_list_find_value(takenForPainHitboxList, i)) {
						var instance_to_reference_ = ds_list_find_value(takenForPainHitboxList, i);
						if instance_exists(instance_to_reference_) {
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
							x_location_ = obj_player.x + lengthdir_x(32 * 1.25, x_location_);
							y_location_ = obj_player.y + lengthdir_y(32 * 1.25, y_location_);
							instance_to_reference_.x = x_location_;
							instance_to_reference_.y = y_location_;
						}
					}
				}
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





}
