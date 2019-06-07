/// @description Edit Variables

#region Blood Magic (---PRIME ABILITIES---)
#region Tier 1 Abilities
// Crawl of Torment Time Slow Effect
if primeAbilityChosen == "Crawl of Torment" {
	if !crawlOfTormentActive {
		if obj_player.key_prime_ability {
			if playerCurrentBloodMagic >= crawlOfTormentBloodMagicCost {
				playerCurrentBloodMagic -= crawlOfTormentBloodMagicCost;
				crawlOfTormentTimer = crawlOfTormentTimerStartTime;
				if instance_exists(obj_enemy) {
					obj_enemy.enemyGameSpeed -= crawlOfTormentPower;
				}
			}
		}
	}
}
if crawlOfTormentTimer >= 0 {
	crawlOfTormentActive = true;
}
if crawlOfTormentActive {
	if crawlOfTormentTimer < 0 {
		crawlOfTormentActive = false;
		if instance_exists(obj_enemy) {
			obj_enemy.enemyGameSpeed += crawlOfTormentPower;
		}
	}
	else if crawlOfTormentTimer >= 0 {
		crawlOfTormentTimer--;
	}
}
#endregion

#region Tier 2 Abilities
#region Overwhelming Chains
if primeAbilityChosen == "Overwhelming Chains" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= overWhelmingChainsBloodMagicCost {
			// Check if an enemy exists at the target location and if so, use Overwhelming Chains on
			// that instance
			var instance_being_clicked_on_ = instance_position(mouse_x, mouse_y, obj_hurtbox);
			if instance_exists(instance_being_clicked_on_) {
				instance_being_clicked_on_ = instance_being_clicked_on_.owner;
			}
			if instance_exists(instance_being_clicked_on_) {
				if !instance_being_clicked_on_.powerfulBeing {
					if instance_being_clicked_on_.combatFriendlyStatus == "Enemy" {
						playerCurrentBloodMagic -= overWhelmingChainsBloodMagicCost;
						// If Overwhelming Chains is already active, set the past target as an enemy
						// before setting the new target as a minion
						if overwhelmingChainsActive {
							// Reset previous target variables
							if instance_exists(overwhelmingChainsEffectedTarget) {
								with overwhelmingChainsEffectedTarget {
									#region Remove Object from ObjectIDsInBattle
									// Remove the instance from the objectIDsInBattle and re-add it using the new correct
									// combatFriendlyStatus that the object has.
									if ds_exists(objectIDsInBattle, ds_type_list) {
										if (ds_list_find_index(objectIDsInBattle, self) != -1) {
											// Set every instance that wasn't destroyed/left the tether area to make a new decision, as long as the instance
											// isn't currently chasing its target (if it is, I want it to finish out it's series of actions first)
											var j;
											for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
												var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
												instance_to_reference_.decisionMadeForTargetAndAction = false;
												instance_to_reference_.currentTargetToFocus = noone;
												instance_to_reference_.currentTargetToHeal = noone;
											}
											ds_list_delete(objectIDsInBattle, ds_list_find_index(objectIDsInBattle, self));
											switch (objectArchetype) {
												case "Healer": friendlyHealersInBattle -= 1;
													currentTargetToHeal = noone;
													currentTargetToFocus = noone;
													break;
												case "Tank": friendlyTanksInBattle -= 1;
													currentTargetToFocus = noone;
													break;
												case "Melee DPS": friendlyMeleeDPSInBattle -= 1;
													currentTargetToFocus = noone;
													break;
												case "Ranged DPS": friendlyRangedDPSInBattle -= 1;
													currentTargetToFocus = noone;
													break;
											}
										}
									}
									#endregion
									// Reset variables
									overwhelmingChainsActiveOnSelf = false;
									combatFriendlyStatus = "Enemy";
									overwhelmingChainsDamageMultiplier = 1;
									overwhelmingChainsDamageResistanceMultiplier = 1;
									currentTargetToFocus = noone;
									currentTargetToHeal = noone;
									decisionMadeForTargetAndAction = false;
									alreadyTriedToChase = false;
									alreadyTriedToChaseTimer = 0;
									enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
									enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
									enemyTimeUntilNextManaAbilityUsableTimerSet = false;
									enemyTimeUntilNextManaAbilityUsableTimer = 0;
									if !stunActive {
										chosenEngine = "";
										enemyImageIndex = 0;
									}
									#region Re-Add Object to the Correct ds_list (objectIDsInBattle or objectIDsFollowingPlayer)
									// If there are already other enemies within player's field of view, even after this current
									// enemy was removed from the objectIDsInBattle, then add this object to the existing
									// objectIDsInBattle list
									if ds_exists(objectIDsInBattle, ds_type_list) {
										// As long as the object hasn't already been detected and added to objectIDsInBattle, executed code
										if ds_list_find_index(objectIDsInBattle, self) == -1 {
											/* 
											If the object hasn't already been detected, reset the decision making variable 
											decisionMadeForTargetAndAction so that the object can make a combat decision immediately
											in scr_ai_decisions (although decisionMadeForTargetAndAction is actually checked for in 
											the scr_enemy_idle script (enemystates.idle). 
											*/
											decisionMadeForTargetAndAction = false;
											// Set every instance that is or will about to be idling to make a new decision.
											for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
												instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
												instance_to_reference_.decisionMadeForTargetAndAction = false;
												instance_to_reference_.currentTargetToFocus = noone;
												instance_to_reference_.currentTargetToHeal = noone;
											}
											// Add this object's ID to the list of objects in battle (objectIDsInBattle)
											ds_list_add(objectIDsInBattle, self);
											switch (objectArchetype) {
												case "Healer": enemyHealersInBattle += 1;
													currentTargetToHeal = noone;
													currentTargetToFocus = noone;
													break;
												case "Tank": enemyTanksInBattle += 1;
													currentTargetToFocus = noone;
													break;
												case "Melee DPS": enemyMeleeDPSInBattle += 1;
													currentTargetToFocus = noone;
													break;
												case "Ranged DPS": enemyRangedDPSInBattle += 1;
													currentTargetToFocus = noone;
													break;
											}
										}
									}
									#endregion
								}
							}
							// Set new target variables
							overwhelmingChainsActive = true;
							overwhelmingChainsEffectedTarget = instance_being_clicked_on_;
							with overwhelmingChainsEffectedTarget {
								#region Remove Object from ObjectIDsInBattle
								// Remove the instance from the objectIDsInBattle and re-add it using the new correct
								// combatFriendlyStatus that the object has.
								if ds_exists(objectIDsInBattle, ds_type_list) {
									if (ds_list_find_index(objectIDsInBattle, self) != -1) {
										// Set every instance that wasn't destroyed/left the tether area to make a new decision, as long as the instance
										// isn't currently chasing its target (if it is, I want it to finish out it's series of actions first)
										var j;
										for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
											var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
											instance_to_reference_.decisionMadeForTargetAndAction = false;
											instance_to_reference_.currentTargetToFocus = noone;
											instance_to_reference_.currentTargetToHeal = noone;
										}
										// Since this block is executed only if the object is already found inside objectIDsInBattle, if only 1 object
										// is left in battle, that has to be this object and also incidentally an enemy, and so therefore destroy the list.
										if ds_list_size(objectIDsInBattle) == 1 {
											ds_list_destroy(objectIDsInBattle);
											objectIDsInBattle = -1;
											friendlyHealersInBattle = 0;
											friendlyTanksInBattle = 0;
											friendlyMeleeDPSInBattle = 0;
											friendlyRangedDPSInBattle = 0;
											enemyHealersInBattle = 0;
											enemyTanksInBattle = 0;
											enemyMeleeDPSInBattle = 0;
											enemyRangedDPSInBattle = 0;
										}
										else {
											ds_list_delete(objectIDsInBattle, ds_list_find_index(objectIDsInBattle, self));
										}
										switch (objectArchetype) {
											case "Healer": enemyHealersInBattle -= 1;
												currentTargetToHeal = noone;
												currentTargetToFocus = noone;
												break;
											case "Tank": enemyTanksInBattle -= 1;
												currentTargetToFocus = noone;
												break;
											case "Melee DPS": enemyMeleeDPSInBattle -= 1;
												currentTargetToFocus = noone;
												break;
											case "Ranged DPS": enemyRangedDPSInBattle -= 1;
												currentTargetToFocus = noone;
												break;
										}
									}
								}
								// If there are no enemies in battle after changing this object off
								// of an enemy, get rid of the objectIDsInBattle list
								if (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) <= 0 {
									if ds_exists(objectIDsInBattle, ds_type_list) {
										ds_list_destroy(objectIDsInBattle);
										objectIDsInBattle = -1;
										friendlyHealersInBattle = 0;
										friendlyTanksInBattle = 0;
										friendlyMeleeDPSInBattle = 0;
										friendlyRangedDPSInBattle = 0;
										enemyHealersInBattle = 0;
										enemyTanksInBattle = 0;
										enemyMeleeDPSInBattle = 0;
										enemyRangedDPSInBattle = 0;
									}
								}
								#endregion
								overwhelmingChainsActiveOnSelf = true;
								combatFriendlyStatus = "Minion";
								overwhelmingChainsDamageMultiplier = overwhelmingChainsBaseDamageMultiplier;
								overwhelmingChainsDamageResistanceMultiplier = overwhelmingChainsBaseDamageResistanceMultiplier;
								if !stunActive {
									chosenEngine = "";
									decisionMadeForTargetAndAction = false;
									alreadyTriedToChase = false;
									alreadyTriedToChaseTimer = 0;
									enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
									enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
									enemyTimeUntilNextManaAbilityUsableTimerSet = false;
									enemyTimeUntilNextManaAbilityUsableTimer = 0;
									enemyImageIndex = 0;
								}
								#region Re-Add Object to the Correct ds_list (objectIDsInBattle or objectIDsFollowingPlayer)
								// If there are already other enemies within player's field of view, even after this current
								// enemy was removed from the objectIDsInBattle, then add this object to the existing
								// objectIDsInBattle list
								if ds_exists(objectIDsInBattle, ds_type_list) {
									// As long as the object hasn't already been detected and added to objectIDsInBattle, executed code
									if ds_list_find_index(objectIDsInBattle, self) == -1 {
										/* 
										If the object hasn't already been detected, reset the decision making variable 
										decisionMadeForTargetAndAction so that the object can make a combat decision immediately
										in scr_ai_decisions (although decisionMadeForTargetAndAction is actually checked for in 
										the scr_enemy_idle script (enemystates.idle). 
										*/
										decisionMadeForTargetAndAction = false;
										// Set every instance that is or will about to be idling to make a new decision.
										for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
											instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
											instance_to_reference_.decisionMadeForTargetAndAction = false;
											instance_to_reference_.currentTargetToFocus = noone;
											instance_to_reference_.currentTargetToHeal = noone;
										}
										// Add this object's ID to the list of objects in battle (objectIDsInBattle)
										ds_list_add(objectIDsInBattle, self);
										switch (objectArchetype) {
											case "Healer": friendlyHealersInBattle += 1;
												currentTargetToHeal = noone;
												currentTargetToFocus = noone;
												break;
											case "Tank": friendlyTanksInBattle += 1;
												currentTargetToFocus = noone;
												break;
											case "Melee DPS": friendlyMeleeDPSInBattle += 1;
												currentTargetToFocus = noone;
												break;
											case "Ranged DPS": friendlyRangedDPSInBattle += 1;
												currentTargetToFocus = noone;
												break;
										}
									}
								}
								// After the above calculations, if the enemy is a minion, but not combat has been initiated and its still within range, 
								// then create a ds_list meant for tracking just minions outside of combat (objectIDsFollowingPlayer)
								if !ds_exists(objectIDsInBattle, ds_type_list) {
									if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
										if ds_list_find_index(objectIDsFollowingPlayer, self) == -1 {
											/* 
											If the object hasn't already been detected, reset the decision making variable 
											decisionMadeForTargetAndAction so that the object can make a combat decision immediately
											in scr_ai_decisions (although decisionMadeForTargetAndAction is actually checked for in 
											the scr_enemy_idle script (enemystates.idle). 
											*/
											decisionMadeForTargetAndAction = false;
											// Set every instance that is or will about to be idling to make a new decision. If the instance is currently
											// chasing a target though, don't reset that decision, as I want the instance to finish out it's chain of actions.
											for (j = 0; j <= ds_list_size(objectIDsFollowingPlayer) - 1; j++) {
												instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, j);
												if instance_to_reference_.enemyState != enemystates.moveWithinAttackRange {
													instance_to_reference_.decisionMadeForTargetAndAction = false;
												}
											}
											// Add itself's ID to the list of objects following the player
											ds_list_add(objectIDsFollowingPlayer, self);
										}
									}
									// Create the ds_list objectIDsFollowingPlayer if it doesn't already exist and add the object's information to the ds_list
									else {
										// As long as this object hasn't already been added to the list, add its information
										decisionMadeForTargetAndAction = false;
										objectIDsFollowingPlayer = ds_list_create();
										ds_list_add(objectIDsFollowingPlayer, self);
										if objectArchetype == "Healer" {
											currentTargetToHeal = noone;
										}
									}
								}
								#endregion
							}
						}
						// If Overwhelming Chains isn't yet active on an enemy, 
						else {
							overwhelmingChainsActive = true;
							overwhelmingChainsEffectedTarget = instance_being_clicked_on_;
							with overwhelmingChainsEffectedTarget {
								#region Remove Object from ObjectIDsInBattle
								// Remove the instance from the objectIDsInBattle and re-add it using the new correct
								// combatFriendlyStatus that the object has.
								if ds_exists(objectIDsInBattle, ds_type_list) {
									if (ds_list_find_index(objectIDsInBattle, self) != -1) {
										// Set every instance that wasn't destroyed/left the tether area to make a new decision, as long as the instance
										// isn't currently chasing its target (if it is, I want it to finish out it's series of actions first)
										var j;
										for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
											var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
											instance_to_reference_.decisionMadeForTargetAndAction = false;
											instance_to_reference_.currentTargetToFocus = noone;
											instance_to_reference_.currentTargetToHeal = noone;
										}
										// Since this block is executed only if the object is already found inside objectIDsInBattle, if only 1 object
										// is left in battle, that has to be this object and also incidentally an enemy, and so therefore destroy the list.
										if ds_list_size(objectIDsInBattle) == 1 {
											ds_list_destroy(objectIDsInBattle);
											objectIDsInBattle = -1;
											friendlyHealersInBattle = 0;
											friendlyTanksInBattle = 0;
											friendlyMeleeDPSInBattle = 0;
											friendlyRangedDPSInBattle = 0;
											enemyHealersInBattle = 0;
											enemyTanksInBattle = 0;
											enemyMeleeDPSInBattle = 0;
											enemyRangedDPSInBattle = 0;
										}
										else {
											ds_list_delete(objectIDsInBattle, ds_list_find_index(objectIDsInBattle, self));
										}
										switch (objectArchetype) {
											case "Healer": enemyHealersInBattle -= 1;
												currentTargetToHeal = noone;
												currentTargetToFocus = noone;
												break;
											case "Tank": enemyTanksInBattle -= 1;
												currentTargetToFocus = noone;
												break;
											case "Melee DPS": enemyMeleeDPSInBattle -= 1;
												currentTargetToFocus = noone;
												break;
											case "Ranged DPS": enemyRangedDPSInBattle -= 1;
												currentTargetToFocus = noone;
												break;
										}
									}
								}
								// If there are no enemies in battle after changing this object off
								// of an enemy, get rid of the objectIDsInBattle list
								if (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) <= 0 {
									if ds_exists(objectIDsInBattle, ds_type_list) {
										ds_list_destroy(objectIDsInBattle);
										objectIDsInBattle = -1;
										friendlyHealersInBattle = 0;
										friendlyTanksInBattle = 0;
										friendlyMeleeDPSInBattle = 0;
										friendlyRangedDPSInBattle = 0;
										enemyHealersInBattle = 0;
										enemyTanksInBattle = 0;
										enemyMeleeDPSInBattle = 0;
										enemyRangedDPSInBattle = 0;
									}
								}
								#endregion
								overwhelmingChainsActiveOnSelf = true;
								combatFriendlyStatus = "Minion";
								overwhelmingChainsDamageMultiplier = overwhelmingChainsBaseDamageMultiplier;
								overwhelmingChainsDamageResistanceMultiplier = overwhelmingChainsBaseDamageResistanceMultiplier;
								if !stunActive {
									chosenEngine = "";
									decisionMadeForTargetAndAction = false;
									alreadyTriedToChase = false;
									alreadyTriedToChaseTimer = 0;
									enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
									enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
									enemyTimeUntilNextManaAbilityUsableTimerSet = false;
									enemyTimeUntilNextManaAbilityUsableTimer = 0;
									enemyImageIndex = 0;
								}
								#region Re-Add Object to the Correct ds_list (objectIDsInBattle or objectIDsFollowingPlayer)
								// If there are already other enemies within player's field of view, even after this current
								// enemy was removed from the objectIDsInBattle, then add this object to the existing
								// objectIDsInBattle list
								if ds_exists(objectIDsInBattle, ds_type_list) {
									// As long as the object hasn't already been detected and added to objectIDsInBattle, executed code
									if ds_list_find_index(objectIDsInBattle, self) == -1 {
										/* 
										If the object hasn't already been detected, reset the decision making variable 
										decisionMadeForTargetAndAction so that the object can make a combat decision immediately
										in scr_ai_decisions (although decisionMadeForTargetAndAction is actually checked for in 
										the scr_enemy_idle script (enemystates.idle). 
										*/
										decisionMadeForTargetAndAction = false;
										// Set every instance that is or will about to be idling to make a new decision.
										for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
											instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
											instance_to_reference_.decisionMadeForTargetAndAction = false;
											instance_to_reference_.currentTargetToFocus = noone;
											instance_to_reference_.currentTargetToHeal = noone;
										}
										// Add this object's ID to the list of objects in battle (objectIDsInBattle)
										ds_list_add(objectIDsInBattle, self);
										switch (objectArchetype) {
											case "Healer": friendlyHealersInBattle += 1;
												currentTargetToHeal = noone;
												currentTargetToFocus = noone;
												break;
											case "Tank": friendlyTanksInBattle += 1;
												currentTargetToFocus = noone;
												break;
											case "Melee DPS": friendlyMeleeDPSInBattle += 1;
												currentTargetToFocus = noone;
												break;
											case "Ranged DPS": friendlyRangedDPSInBattle += 1;
												currentTargetToFocus = noone;
												break;
										}
									}
								}
								// After the above calculations, if the enemy is a minion, but not combat has been initiated and its still within range, 
								// then create a ds_list meant for tracking just minions outside of combat (objectIDsFollowingPlayer)
								if !ds_exists(objectIDsInBattle, ds_type_list) {
									if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
										if ds_list_find_index(objectIDsFollowingPlayer, self) == -1 {
											/* 
											If the object hasn't already been detected, reset the decision making variable 
											decisionMadeForTargetAndAction so that the object can make a combat decision immediately
											in scr_ai_decisions (although decisionMadeForTargetAndAction is actually checked for in 
											the scr_enemy_idle script (enemystates.idle). 
											*/
											decisionMadeForTargetAndAction = false;
											// Set every instance that is or will about to be idling to make a new decision. If the instance is currently
											// chasing a target though, don't reset that decision, as I want the instance to finish out it's chain of actions.
											for (j = 0; j <= ds_list_size(objectIDsFollowingPlayer) - 1; j++) {
												instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, j);
												if instance_to_reference_.enemyState != enemystates.moveWithinAttackRange {
													instance_to_reference_.decisionMadeForTargetAndAction = false;
												}
											}
											// Add itself's ID to the list of objects following the player
											ds_list_add(objectIDsFollowingPlayer, self);
										}
									}
									// Create the ds_list objectIDsFollowingPlayer if it doesn't already exist and add the object's information to the ds_list
									else {
										// As long as this object hasn't already been added to the list, add its information
										decisionMadeForTargetAndAction = false;
										objectIDsFollowingPlayer = ds_list_create();
										ds_list_add(objectIDsFollowingPlayer, self);
										if objectArchetype == "Healer" {
											currentTargetToHeal = noone;
										}
									}
								}
								#endregion
							}
						}
					}
				}
			}
		}
	}
}
#endregion

#region All is Given
if primeAbilityChosen == "All is Given" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= allIsGivenBloodMagicCost {
			if (friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) > 0 {
				var instance_to_sacrifice_found_ = false;
				if ds_exists(objectIDsInBattle, ds_type_list) {
					var i;
					for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						if instance_exists(instance_to_reference_) {
							if instance_to_reference_.combatFriendlyStatus == "Minion" {
								instance_to_reference_.enemyCurrentHP = -1;
								allIsGivenMultiplier += 1;
								instance_to_sacrifice_found_ = true;
							}
						}
					}
				}
				else if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
					var i;
					for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
						if instance_exists(instance_to_reference_) {
							instance_to_reference_.enemyCurrentHP = -1;
							allIsGivenMultiplier += 1;
							instance_to_sacrifice_found_ = true;
						}
					}
					ds_list_destroy(objectIDsFollowingPlayer);
					objectIDsFollowingPlayer = -1;
				}
				if instance_to_sacrifice_found_ {
					allIsGivenActive = true;
					allIsGivenTimer = allIsGivenTimerStartTime;
					playerCurrentBloodMagic -= allIsGivenBloodMagicCost;
				}
			}
		}
	}
}
if allIsGivenTimer >= 0 {
	allIsGivenActive = true;
}
if allIsGivenActive {
	if (primeAbilityChosen != "All is Given") || (obj_player.key_prime_ability) {
		allIsGivenActive = false;
		allIsGivenMultiplier = 1;
	}
	if allIsGivenTimer < 0 {
		allIsGivenActive = false;
		allIsGivenMultiplier = 1;
	}
	else if allIsGivenTimer >= 0 {
		allIsGivenTimer--;
	}
}
#endregion
#endregion

#region Tier 3 Abilities
#region Forces of Life
if primeAbilityChosen == "Forces of Life" {
	if obj_player.key_prime_ability {
		var forcesOfLifePreviousStatus = true;
		if !forcesOfLifeActive {
			if playerCurrentBloodMagic >= forcesOfLifeBloodMagicCostPerFrame {
				if (friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) > 0 {
					forcesOfLifePreviousStatus = false;
					var instance_to_buff_found_ = false;
					if ds_exists(objectIDsInBattle, ds_type_list) {
						var i;
						for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
							var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
							if instance_exists(instance_to_reference_) {
								if instance_to_reference_.combatFriendlyStatus == "Minion" {
									instance_to_reference_.forcesOfLifeDamageMultiplier = instance_to_reference_.forcesOfLifeBaseDamageMultiplier;
									instance_to_reference_.forcesOfLifeActive = true;
									instance_to_buff_found_ = true;
								}
							}
						}
					}
					else if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
						var i;
						for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
							var instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
							if instance_exists(instance_to_reference_) {
								instance_to_reference_.forcesOfLifeDamageMultiplier = instance_to_reference_.forcesOfLifeBaseDamageMultiplier;
								instance_to_reference_.forcesOfLifeActive = true;
								instance_to_buff_found_ = true;
							}
						}
					}
					if instance_to_buff_found_ {
						forcesOfLifeActive = true;
					}
				}
			}
		}
	}
}
if forcesOfLifeActive {
	// If Forces of Life is active and something happens to make it not so, like the player chaning
	// the selected prime ability, or pressing the prime ability button while Forces of Life is 
	// selected and active, or the player doesn't have enough HP to sacrifice, cancel Forces of Life.
	if (obj_player.key_prime_ability && forcesOfLifePreviousStatus) || (primeAbilityChosen != "Forces of Life") || (playerCurrentHP <= (playerMaxHP * forcesOfLifeHPCostPerFrame * 2)) {
		forcesOfLifeActive = false;
		var instance_to_buff_found_ = false;
		if ds_exists(objectIDsInBattle, ds_type_list) {
			var i;
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				if instance_exists(instance_to_reference_) {
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						instance_to_reference_.forcesOfLifeDamageMultiplier = 1;
						instance_to_reference_.forcesOfLifeActive = false;
					}
				}
			}
		}
		else if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
			var i;
			for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
				var instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
				if instance_exists(instance_to_reference_) {
					instance_to_reference_.forcesOfLifeDamageMultiplier = 1;
					instance_to_reference_.forcesOfLifeActive = false;
				}
			}
		}
	}
	// Else if nothing has happened to cancel Forces of Life and its still active, then simply sacrifice
	// player HP.
	else {
		playerCurrentBloodMagic -= forcesOfLifeBloodMagicCostPerFrame;
	}
}
#endregion

#region Blood Pact
if primeAbilityChosen = "Blood Pact" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= bloodPactBloodMagicCost {
			playerCurrentBloodMagic -= bloodPactBloodMagicCost;
			playerCurrentStamina += (playerMaxStamina * bloodPactStaminaReturn);
			playerCurrentMana += (playerMaxMana * bloodPactManaReturn);
		}
	}
}
#endregion

#region Life Tax
if primeAbilityChosen == "Life Tax" {
	if obj_player.key_prime_ability {
		if !lifeTaxActive {
			if playerCurrentBloodMagic >= lifeTaxBloodMagicCost {
				playerCurrentBloodMagic -= lifeTaxBloodMagicCost;
				lifeTaxActive = true;
				lifeTaxNumberOfObjectsEffected = 1;
				lifeTaxBonusDamageResistanceMultiplier = lifeTaxBaseBonusDamageResistanceMultiplier;
				var i;
				if ds_exists(objectIDsInBattle, ds_type_list) {
					for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						if point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y) <= lifeTaxRange {
							lifeTaxNumberOfObjectsEffected++;
							instance_to_reference_.enemyCurrentHP -= (instance_to_reference_.enemyMaxHP * lifeTaxDamageToOtherObjectsMultiplier);
						}
					}
				}
				else if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
					for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
						if point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y) <= lifeTaxRange {
							lifeTaxNumberOfObjectsEffected++;
							instance_to_reference_.enemyCurrentHP -= (instance_to_reference_.enemyMaxHP * lifeTaxDamageToOtherObjectsMultiplier);
						}
					}
				}
				lifeTaxTimer = (lifeTaxNumberOfObjectsEffected * lifeTaxTimerStartTime);
			}
		}
	}
}
if lifeTaxTimer >= 0 {
	lifeTaxActive = true;
}
if lifeTaxActive {
	if lifeTaxTimer < 0 {
		lifeTaxActive = false;
		lifeTaxBonusDamageResistanceMultiplier = 1;
		lifeTaxNumberOfObjectsEffected = 1;
	}
	else if lifeTaxTimer >= 0 {
		lifeTaxTimer--;
	}
}
#endregion

#region Blood for Blood
if primeAbilityChosen = "Blood for Blood" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= bloodForBloodBloodMagicCost {
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i, instance_to_reference_, closest_instance_to_target_, distance_to_closest_target_;
				closest_instance_to_target_ = noone;
				distance_to_closest_target_ = 100000;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y) < distance_to_closest_target_ {
								closest_instance_to_target_ = instance_to_reference_;
								distance_to_closest_target_ = point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y);
							}
						}
					}
				}
				if instance_exists(closest_instance_to_target_) {
					playerCurrentBloodMagic -= bloodForBloodBloodMagicCost;
					bloodForBloodTarget = closest_instance_to_target_;
					bloodForBloodTarget.enemyCurrentHP -= bloodForBloodDamage;
				}
			}
		}
	}
}
#endregion
#endregion

#region Tier 4 Abilities
#region For the Greater Good
if primeAbilityChosen == "For the Greater Good" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= forTheGreaterGoodBloodMagicCost {
			if !forTheGreaterGoodActive {
				playerCurrentBloodMagic -= forTheGreaterGoodBloodMagicCost;
				forTheGreaterGoodTimer = forTheGreaterGoodTimerStartTime;
				forTheGreaterGoodAttacksEffected = 0;
				forTheGreaterGoodDamageMultiplier = forTheGreaterGoodBaseDamageMultiplier;
			}
		}
	}
}
if forTheGreaterGoodTimer >= 0 {
	forTheGreaterGoodActive = true;
}
if forTheGreaterGoodActive {
	if forTheGreaterGoodTimer < 0 {
		forTheGreaterGoodActive = false;
		forTheGreaterGoodDamageMultiplier = 1;
		forTheGreaterGoodAttacksEffected = 0;
	}
	else if forTheGreaterGoodTimer >= 0 {
		forTheGreaterGoodTimer--;
	}
}
#endregion

#region Solidify
if primeAbilityChosen == "Solidify" {
	if obj_player.key_prime_ability {
		if playerCurrentBloodMagic >= solidifyBloodMagicCost {
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i, instance_to_reference_, closest_instance_to_target_, distance_to_closest_target_;
				closest_instance_to_target_ = noone;
				distance_to_closest_target_ = solidifyRange;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y) < distance_to_closest_target_ {
								closest_instance_to_target_ = instance_to_reference_;
								distance_to_closest_target_ = point_distance(obj_player.x, obj_player.y, instance_to_reference_.x, instance_to_reference_.y);
							}
						}
					}
				}
				if instance_exists(closest_instance_to_target_) {
					// Cancel debuffs on previous target before setting new debuffs on new target
					if instance_exists(solidifyTarget) {
						solidifyTarget.solidifyEnemyImageSpeedMultiplier = 1;
						solidifyTarget.solidifyEnemyMovementSpeedMultiplier = 1;
						solidifyTarget.solidifyEnemyStaminaRegenerationMultiplier = 1;
						solidifyTarget.solidifyEnemyManaRegenerationMultiplier = 1;
					}
					playerCurrentBloodMagic -= solidifyBloodMagicCost;
					solidifyTarget = closest_instance_to_target_;
					solidifyActive = true;
					solidifyTimer = solidifyTimerStartTime;
					solidifyTarget.solidifyEnemyImageSpeedMultiplier = 0;
					solidifyTarget.solidifyEnemyMovementSpeedMultiplier = 0;
					solidifyTarget.solidifyEnemyStaminaRegenerationMultiplier = 0;
					solidifyTarget.solidifyEnemyManaRegenerationMultiplier = 0;
				}
			}
		}
	}
}
if solidifyTimer >= 0 {
	solidifyActive = true;
}
if solidifyActive {
	if solidifyTimer < 0 {
		solidifyActive = false;
		solidifyTarget.solidifyEnemyImageSpeedMultiplier = 1;
		solidifyTarget.solidifyEnemyMovementSpeedMultiplier = 1;
		solidifyTarget.solidifyEnemyStaminaRegenerationMultiplier = 1;
		solidifyTarget.solidifyEnemyManaRegenerationMultiplier = 1;
		solidifyTarget = noone;
	}
	else if solidifyTimer >= 0 {
		solidifyTimer--;
	}
}
#endregion
#endregion
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


