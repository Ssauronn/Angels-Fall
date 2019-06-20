///@description Apply Damages and Healing Correctly using Attacker and Defender stats
///@argument0 AttackerID
///@argument1 DefenderID

#region Set Up Variables Used to Control Damages
var applicable_player_damage_bonus_, total_damage_, applicable_enemy_damage_bonus_;
var self_, owner_, owner_is_enemy_, owner_is_minion_, owner_is_player_, owner_is_self_;
var other_owner_, other_owner_is_enemy, other_owner_is_minion_, other_owner_is_player_;
var i, instance_to_reference_;
self_ = self;
owner_is_enemy_ = false;
owner_is_minion_ = false;
owner_is_player_ = false;
owner_is_self_ = false;
owner_ = argument0;
other_owner_is_player_ = false;
other_owner_is_enemy = false;
other_owner_is_minion_ = false;
other_owner_ = argument1;


// Set all local variables that make it easier to determine and set values in this script based
// on what the attacker is, and the defender.
if other_owner_ == owner_ {
	owner_is_self_ = true;
}
if instance_exists(obj_player) {
	if owner_ == obj_player.id {
		owner_is_player_ = true;
	}
}
if !owner_is_player_ {
	if owner_.combatFriendlyStatus == "Enemy" {
		owner_is_enemy_ = true;
	}
	else if owner_.combatFriendlyStatus == "Minion" {
		owner_is_minion_ = true;
	}
}
if other_owner_ != obj_player.id {
	if other_owner_.combatFriendlyStatus == "Enemy" {
		other_owner_is_enemy = true;
	}
	else if other_owner_.combatFriendlyStatus == "Minion" {
		other_owner_is_minion_ = true;
	}
}
else {
	other_owner_is_player_ = true;
}


// Set the local variable applicable_player_damage_bonus_ equal to the damage bonus that the
// hitbox type is, which will be used later to automatically determine what damage value should
// be applied to the enemy.
if owner_is_player_ {
	if playerHitboxDamageType == "Ability" {
		applicable_player_damage_bonus_ = playerTotalBonusDamage;
	}
	else if playerHitboxDamageType == "Basic Melee" {
		applicable_player_damage_bonus_ = playerTotalBonusBasicMeleeDamage;
	}
}
else if owner_is_enemy_ {
	applicable_enemy_damage_bonus_ = owner_.enemyTotalBonusDamage;
}


// Set the local variable used to add to the total damage the hitbox will do to the enemy later on
// in this script. First I'll add any bonus damages like what is provided by Lightning Spear. Then
// I'll multiply bonus damages provided by the attacker TotalBonusDamage, and finally I'll find
// the final value by multiplying the current value against the defender TotalBonusResistance.
if owner_is_player_ {
	total_damage_ = playerHitboxValue;
}
else if (owner_is_enemy_) || (owner_is_minion_) {
	total_damage_ = enemyHitboxValue;
}
#endregion

#region Damaging
// Apply damages here, taking into account total resistances and bonus damages of defender and
// attacker, and whether the damage being dealt is basic melee or not.
#region Player Damaging Enemies
if owner_is_player_ {
	if other_owner_is_enemy {
		if !playerHitboxHeal {
			if playerHitboxSpecificTarget == noone || playerHitboxSpecificTarget == owner_ {
				if playerHitboxAbilityOrigin == "Melee Attack" {
					with obj_skill_tree {
						if rushdownDashDamageMultiplierActive {
							rushdownDashDamageMultiplierActive = false;
						}
						if forTheGreaterGoodActive {
							forTheGreaterGoodAttacksEffected++;
						}
						if wrathOfTheRepentantActive {
							other_owner_.wrathOfTheRepentantDebuffTimer = other_owner_.wrathOfTheRepentantDebuffTimerStartTime;
						}
						if trueCaelestiWingsActive {
							other_owner_.trueCaelestiWingsDebuffTimer = other_owner_.trueCaelestiWingsDebuffTimerStartTime;
							other_owner_.trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded++;
						}
						if lightningSpearBasicMeleeDamageMultiplierActive {
							lightningSpearBasicMeleeDamageMultiplierActive = false;
						}
						if other_owner_.soulTetherActive {
							if self_.playerHitboxCanBeTransferredThroughSoulTether {
								if is_array(soulTetherTargetArray) {
									for (i = 0; i <= array_length_1d(soulTetherTargetArray) - 1; i++) {
										instance_to_reference_ = soulTetherTargetArray[i];
										if instance_exists(instance_to_reference_) {
											if instance_to_reference_ != other_owner_ {
												with obj_player {
													#region Create Whole Hitbox
													playerHitbox = instance_create_depth(other_owner_.x, other_owner_.y, -999, obj_hitbox);
													playerHitbox.sprite_index = spr_single_hit;
													playerHitbox.mask_index = spr_single_hit;
													playerHitbox.owner = owner_;
													playerHitbox.playerHitboxAttackType = self_.playerHitboxAttackType;
													playerHitbox.playerHitboxDamageType = self_.playerHitboxDamageType;
													playerHitbox.playerHitboxAbilityOrigin = "Soul Tether";
													playerHitbox.playerHitboxHeal = self_.playerHitboxHeal;
													playerHitbox.playerHitboxValue = total_damage_;
													playerHitbox.playerHitboxCollisionFound = false;
													playerHitbox.playerHitboxLifetime = 1;
													playerHitbox.playerHitboxCollidedWithWall = false;
													playerHitbox.playerHitboxPersistAfterCollision = false;
													// The next variable is the timer that determines when an object will apply damage again to
													// an object its colliding with repeatedly. This only takes effect if the hitbox's
													// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
													// destroyed upon colliding with the first object it can and no chance will be given for the
													// hitbox to deal damage repeatedly to the object.
													playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
													playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = false;
													// This is the variable which will be an array of all objects the hitbox has collided with
													// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
													// it has collided with in the first place
													playerHitbox.playerHitboxTargetArray = noone;
													// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
													// that unless that hitbox collides with the exact object its meant for, it won't interact
													// with that object. If the hitbox has no specific target, this is set to noone.
													playerHitbox.playerHitboxSpecificTarget = instance_to_reference_;
		
													if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
														ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
													}
													else {
														obj_combat_controller.playerHitboxList = ds_list_create();
														ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
													}
													#endregion
												}
											}
										}
									}
								}
							}
						}
						if allOutAttackActive {
							if point_distance(obj_player.x, obj_player.y, other_owner_.x, other_owner_.y) <= obj_skill_tree.allOutAttackRange {
								total_damage_ *= allOutAttackBaseMeleeRangeDamageMultiplier;
							}
						}
					}
					if !playerHitboxPersistAfterCollision {
						playerHitboxCollisionFound = true;
					}
					// See collision with obj_enemy event in obj_player_melee_hitbox for explanation as to why I multiply
					// comboDamageDealt by the percent I multiply damage by
					enemyHitByPlayer = true;
					total_damage_ *= applicable_player_damage_bonus_;
					total_damage_ *= other_owner_.enemyTotalBonusResistance;
					comboDamageDealt += total_damage_;
					other_owner_.enemyCurrentHP -= total_damage_;
					lastEnemyHitByPlayer = other_owner_;
					// Exploit Weakness needs to add .25 of total damage after resistances to poisons if active
					if other_owner_.exploitWeaknessActive {
						if !obj_skill_tree.purifyingRageActive {
							if other_owner_.exploitWeaknessCanBeRefreshed {
								other_owner_.exploitWeaknessDamageToAdd = (total_damage_ * other_owner_.exploitWeaknessPercentOfDamageToAdd);
							}
						}
					}
				
					// Track the player's attack pattern's (melee or ranged) based on whether the attack was melee or ranged
					if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
						obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
					}
				}
				// Else if the hitbox did not originate from a simple basic melee attack from a left click,
				// then that means it was created with an ability, and I need to check for all ability
				// buffing, debuffing, etc. in addition to the above checks where I check for player buffs
				// as well.
				else {
					with obj_skill_tree {
						if rushdownDashDamageMultiplierActive {
							rushdownDashDamageMultiplierActive = false;
						}
						if forTheGreaterGoodActive {
							forTheGreaterGoodAttacksEffected++;
						}
						if wrathOfTheRepentantActive {
							other_owner_.wrathOfTheRepentantDebuffTimer = other_owner_.wrathOfTheRepentantDebuffTimerStartTime;
						}
						if trueCaelestiWingsActive {
							other_owner_.trueCaelestiWingsDebuffTimer = other_owner_.trueCaelestiWingsDebuffTimerStartTime;
							other_owner_.trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded++;
						}
						if lightningSpearBasicMeleeDamageMultiplierActive {
							lightningSpearBasicMeleeDamageMultiplierActive = false;
						}
						if other_owner_.soulTetherActive {
							if self_.playerHitboxCanBeTransferredThroughSoulTether {
								if is_array(soulTetherTargetArray) {
									for (i = 0; i <= array_length_1d(soulTetherTargetArray) - 1; i++) {
										instance_to_reference_ = soulTetherTargetArray[i];
										if instance_exists(instance_to_reference_) {
											if instance_to_reference_ != other_owner_ {
												with obj_player {
													#region Create Whole Hitbox
													playerHitbox = instance_create_depth(other_owner_.x, other_owner_.y, -999, obj_hitbox);
													playerHitbox.sprite_index = spr_single_hit;
													playerHitbox.mask_index = spr_single_hit;
													playerHitbox.owner = owner_;
													playerHitbox.playerHitboxAttackType = self_.playerHitboxAttackType;
													playerHitbox.playerHitboxDamageType = self_.playerHitboxDamageType;
													playerHitbox.playerHitboxAbilityOrigin = "Soul Tether";
													playerHitbox.playerHitboxHeal = self_.playerHitboxHeal;
													playerHitbox.playerHitboxValue = total_damage_;
													playerHitbox.playerHitboxCollisionFound = false;
													playerHitbox.playerHitboxLifetime = 1;
													playerHitbox.playerHitboxCollidedWithWall = false;
													playerHitbox.playerHitboxPersistAfterCollision = false;
													// The next variable is the timer that determines when an object will apply damage again to
													// an object its colliding with repeatedly. This only takes effect if the hitbox's
													// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
													// destroyed upon colliding with the first object it can and no chance will be given for the
													// hitbox to deal damage repeatedly to the object.
													playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
													playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = false;
													// This is the variable which will be an array of all objects the hitbox has collided with
													// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
													// it has collided with in the first place
													playerHitbox.playerHitboxTargetArray = noone;
													// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
													// that unless that hitbox collides with the exact object its meant for, it won't interact
													// with that object. If the hitbox has no specific target, this is set to noone.
													playerHitbox.playerHitboxSpecificTarget = instance_to_reference_;
		
													if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
														ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
													}
													else {
														obj_combat_controller.playerHitboxList = ds_list_create();
														ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
													}
													#endregion
												}
											}
										}
									}
								}
							}
						}
						if self_.playerHitboxAbilityOrigin == "Glinting Blade" {
							other_owner_.glintingBladeTimer = glintingBladeTimerStartTime;
						}
						else if self_.playerHitboxAbilityOrigin == "Hellish Landscape" {
							other_owner_.stunTimer = hellishLandscapeStunDuration;
						}
						else if self_.playerHitboxAbilityOrigin == "Hidden Dagger" {
							if !purifyingRageActive {
								total_damage_ *= other_owner_.hiddenDaggerDamageMultiplier;
								if other_owner_.hiddenDaggerActive {
									if other_owner_.hiddenDaggerCanBeRefreshed {
										other_owner_.hiddenDaggerTicTimer = other_owner_.hiddenDaggerTicTimerStartTime;
									}
								}
								else {
									other_owner_.hiddenDaggerTicTimer = other_owner_.hiddenDaggerTicTimerStartTime;
								}
							}
						}
						else if self_.playerHitboxAbilityOrigin == "Exploit Weakness" {
							if !purifyingRageActive {
								if other_owner_.exploitWeaknessActive {
									if other_owner_.exploitWeaknessCanBeRefreshed {
										other_owner_.exploitWeaknessTimer = other_owner_.exploitWeaknessTimerStartTime;
									}
								}
								else {
									other_owner_.exploitWeaknessTimer = other_owner_.exploitWeaknessTimerStartTime;
								}
							}
							// Else if purifying rage is active, add the total amount of damage that
							// Exploit Weakness would do over its duration to the attack value. I get this number
							// by first obtaining the amount of damage per tic the dot would normally do, and
							// then dividing the total normal dot duration by the time between tics. This gets me
							// the number of times the dot would tic before it ends, and so i can multiply that 
							// by the amount of damage the dot would deal per tic to get the total amount of 
							// damage that this ability would deal over its entire duration. Finally, I multiply 
							// this value by the purifying rage dot multiplier to get my final value to add to
							// total_damage_.
							else {
								// (total_damage_ * exploitWeaknessPercentOfDamageToAdd) = damage per dot tic it would do
								// (other_owner_.exploitWeaknessTimerStartTime / other_owner_.exploitWeaknessTicTimerStartTime) = how many times the dot would have ticked
								// multiply those two tother, times the purifyingRage multiplier to add that onto the total_damage_ value
								total_damage_ += ((total_damage_ * exploitWeaknessPercentOfDamageToAdd) * (other_owner_.exploitWeaknessTimerStartTime / other_owner_.exploitWeaknessTicTimerStartTime)) * purifyingRageDamageMultiplierForPoisons;
							}
						}
						else if self_.playerHitboxAbilityOrigin == "Rushdown" {
							if total_damage_ == rushdownMeleeDamage {
								rushdownDashDamageMultiplierActive = true;
							}
						}
						else if self_.playerHitboxAbilityOrigin == "Diabolus Blast" {
							var point_distance_to_target_ = point_distance(obj_player.x, obj_player.y, other_owner_.x, other_owner_.y);
							var percent_ = (point_distance_to_target_ - 32) / ((diabolusBlastMaxRange) - 32);
							// This adds onto the base damage a total of up to 100 extra damage, increasing 
							// as target is closer to player. If target is 32px away (meaning they're pressed
							// up against player), damage is maxed out. Otherwise, the extra damage reduces 
							// from 100 all the way down to 0 depending on the extra distance from the player.
							total_damage_ += (diabolusBlastMaxExtraDamage - (diabolusBlastMaxExtraDamage * percent_));
						}
						else if self_.playerHitboxAbilityOrigin == "Bindings of the Caelesti" {
							other_owner_.bindingsOfTheCaelestiTimer = other_owner_.bindingsOfTheCaelestiTimerStartTime;
						}
						else if self_.playerHitboxAbilityOrigin == "Lightning Spear" {
							lightningSpearBasicMeleeDamageMultiplierActive = true;
						}
						else if self_.playerHitboxAbilityOrigin == "Dinner is Served" {
							if !purifyingRageActive {
								if other_owner_.dinnerIsServedActive {
									if other_owner_.dinnerIsServedCanBeRefreshed {
										other_owner_.dinnerIsServedTimer = other_owner_.dinnerIsServedTimerStartTime;
									}
								}
								else {
									other_owner_.dinnerIsServedTimer = other_owner_.dinnerIsServedTimerStartTime;
								}
							}
							else {
								total_damage_ += (other_owner_.dinnerIsServedStartingDamage * (other_owner_.dinnerIsServedTimerStartTime / other_owner_.dinnerIsServedTicTimerStartTime)) * purifyingRageDamageMultiplierForPoisons;
							}					
						}
						else if self_.playerHitboxAbilityOrigin == "Final Parting" {
							if !purifyingRageActive {
								if other_owner_.finalPartingActive {
									if other_owner_.finalPartingCanBeRefreshed {
										other_owner_.finalPartingTimer = other_owner_.finalPartingTimerStartTime;
									}
								}
								else {
									other_owner_.finalPartingTimer = other_owner_.finalPartingTimerStartTime;
								}
							}
							else {
								total_damage_ += (finalPartingDamage * (other_owner_.finalPartingTimerStartTime / finalPartingTicTimerStartTime)) * purifyingRageDamageMultiplierForPoisons;
							}
						}
						else if self_.playerHitboxAbilityOrigin == "Taken for Pain" {
							if other_owner_.poisoned {
								total_damage_ *= takenForPainDamageMultiplierVsPoisonedTargets;
							}
						}
						else if self_.playerHitboxAbilityOrigin == "Sickly Proposition" {
							if other_owner_.poisoned {
								total_damage_ *= other_owner_.sicklyPropositionDamageMultiplierVsPoisonedTarget;
							}
							if !purifyingRageActive {
								if other_owner_.sicklyPropositionActive {
									if other_owner_.sicklyPropositionCanBeRefreshed {
										other_owner_.sicklyPropositionTimer = other_owner_.sicklyPropositionTimerStartTime;
									}
								}
								else {
									other_owner_.sicklyPropositionTimer = other_owner_.sicklyPropositionTimerStartTime;
								}
							}
							// Add the total dot damage to the total hitbox damage value if purifying rage is active
							else {
								total_damage_ += (other_owner_.sicklyPropositionDoTDamage * (other_owner_.sicklyPropositionTimerStartTime / other_owner_.sicklyPropositionTicTimerStartTime)) * purifyingRageDamageMultiplierForPoisons;
							}
						}
						if allOutAttackActive {
							if point_distance(obj_player.x, obj_player.y, other_owner_.x, other_owner_.y) <= allOutAttackRange {
								total_damage_ *= allOutAttackBaseMeleeRangeDamageMultiplier;
							}
						}
					}
					if !playerHitboxPersistAfterCollision {
						playerHitboxCollisionFound = true;
					}
					// See collision with obj_enemy event in obj_player_melee_hitbox for explanation as to why I multiply
					// comboDamageDealt by the percent I multiply damage by
					enemyHitByPlayer = true;
					total_damage_ *= applicable_player_damage_bonus_;
					total_damage_ *= other_owner_.enemyTotalBonusResistance;
					comboDamageDealt += total_damage_;
					other_owner_.enemyCurrentHP -= total_damage_;
					lastEnemyHitByPlayer = other_owner_;
					// Exploit Weakness needs to add .25 of total damage after resistances to poisons if active
					if other_owner_.exploitWeaknessActive {
						if !obj_skill_tree.purifyingRageActive {
							if other_owner_.exploitWeaknessCanBeRefreshed {
								other_owner_.exploitWeaknessDamageToAdd = (total_damage_ * other_owner_.exploitWeaknessPercentOfDamageToAdd);
							}
						}
					}
					// After hitbox damage is applied
					if self_.playerHitboxAbilityOrigin == "Death Incarnate" {
						if deathIncarnateSecondPhaseActive {
							if other_owner_.enemyCurrentHP <= 0 {
								deathIncarnateSecondPhaseCurrentDamage *= deathIncarnateSecondPhaseSubsequentDamageMultiplier;
							}
							else {
								deathIncarnateSecondPhaseActive = false;
								deathIncarnateSecondPhaseCurrentDamage = deathIncarnateSecondPhaseStartDamage;
							}
						}
					}
				
					// Track the player's attack pattern's (melee or ranged) based on whether the attack was melee or ranged
					if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
						obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
					}
				}
				exit;
			}
		}
	}
}
#endregion
#region Enemies Damaging Player
if owner_is_enemy_ {
	if other_owner_is_player_ {
		if !enemyHitboxHeal {
			// Apply damages to player if the player isn't parrying, and manipulate any buffs.
			if (!obj_skill_tree.parryWindowActive) && (!obj_skill_tree.successfulParryInvulnerabilityActive) {
				if !obj_player.invincibile {
					if !enemyHitboxPersistAfterCollision {
						enemyHitboxCollisionFound = true;
					}
					total_damage_ *= applicable_enemy_damage_bonus_;
					total_damage_ *= playerTotalBonusResistance;
					if !obj_skill_tree.trueCaelestiWingsActive {
						playerCurrentHP -= total_damage_;
					}
					else if (playerCurrentHP - total_damage_) > 0 {
						playerCurrentHP -= total_damage_;
					}
					else if (playerCurrentHP - total_damage_) <= 0 {
						playerCurrentHP += total_damage_;
					}
					if obj_skill_tree.armorOfTheCaelestiActive {
						obj_skill_tree.armorOfTheCaelestiRemainingHPBeforeExplosion -= total_damage_;
						if obj_skill_tree.armorOfTheCaelestiRemainingHPBeforeExplosion <= 0 {
							// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
						}
					}
					if obj_skill_tree.holyDefenseActive {
						// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
					}
				}
			}
			// Else if the player is currently parrying, apply parry effects
			else {
				if !enemyHitboxPersistAfterCollision {
					enemyHitboxCollisionFound = true;
				}
				if (obj_skill_tree.parryWindowActive) {
					obj_skill_tree.successfulParryInvulnerabilityActive = true;
					obj_skill_tree.successfulParryInvulnerabilityTimer = obj_skill_tree.successfulParryInvulnerabilityTimerStartTime;
					obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = true;
					if obj_skill_tree.holyDefenseActive {
						// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
					}
				}
				obj_skill_tree.parryWindowActive = false;
				obj_skill_tree.parryWindowTimer = -1;
				// execute parry animation and visual effects, etc.
			}
			exit;
		}
	}
}
#endregion
#region Enemies Damaging Minions and Vice Versa
if (owner_is_enemy_ && other_owner_is_minion_) || (owner_is_minion_ && other_owner_is_enemy) {
	if !enemyHitboxHeal {
		if !enemyHitboxPersistAfterCollision {
			enemyHitboxCollisionFound = true;
		}
		total_damage_ *= owner_.enemyTotalBonusDamage;
		total_damage_ *= other_owner_.enemyTotalBonusResistance;
		other_owner_.enemyCurrentHP -= total_damage_;
		if owner_is_minion_ && other_owner_is_enemy {
			lastEnemyHitByMinion = other_owner_;
		}
		exit;
	}
}
#endregion
#endregion



#region Healing
#region Player Healing Minions
if owner_is_player_ {
	if other_owner_is_minion_ {
		if playerHitboxHeal {
			if !playerHitboxPersistAfterCollision {
				playerHitboxCollisionFound = true;
			}
			total_damage_ *= playerTotalBonusDamage;
			other_owner_.enemyCurrentHP += total_damage_;
			if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
				obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
			} 
			exit;
		}
	}
}
#endregion

#region Minions Healing Player
if owner_is_minion_ {
	if other_owner_is_player_ {
		if enemyHitboxHeal {
			if !enemyHitboxPersistAfterCollision {
				enemyHitboxCollisionFound = true;
			}
			total_damage_ *= owner_.enemyTotalBonusDamage;
			playerCurrentHP += total_damage_;
			exit;
		}
	}
}
#endregion

#region Minions Healing Minions
if owner_is_minion_ {
	if other_owner_is_minion_ {
		if enemyHitboxHeal {
			if !enemyHitboxPersistAfterCollision {
				enemyHitboxCollisionFound = true;
			}
			total_damage_ *= owner_.enemyTotalBonusDamage;
			other_owner_.enemyCurrentHP += total_damage_;
			exit;
		}
	}
}
#endregion

#region Enemies Healing Enemies
if owner_is_enemy_ {
	if other_owner_is_enemy {
		if enemyHitboxHeal {
			if !enemyHitboxPersistAfterCollision {
				enemyHitboxCollisionFound = true;
			}
			total_damage_ *= owner_.enemyTotalBonusDamage;
			other_owner_.enemyCurrentHP += total_damage_;
			exit;
		}
	}
}
#endregion
#endregion


