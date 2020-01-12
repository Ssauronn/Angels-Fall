///@description Run Full AI Decisions for Each Enemy on Screen
if instance_exists(obj_player) {
	#region TARGETING ENGINE
	if (ds_exists(validObjectIDsInBattle, ds_type_list)) || (ds_exists(validObjectIDsInLineOfSight, ds_type_list)) || ((playerIsAValidFocusTarget || playerIsAValidFocusTargetInLineOfSight) && combatFriendlyStatus == "Enemy") || ((playerIsAValidHealTarget || playerIsAValidHealTargetInLineOfSight) && combatFriendlyStatus == "Minion") {
		var valid_object_to_target_list_ = noone;
		// Destroy the validObjectIDsInBattle list if there are no objects in battle
		if ds_exists(validObjectIDsInBattle, ds_type_list) {
			if ds_list_size(validObjectIDsInBattle) < 1 {
				ds_list_destroy(validObjectIDsInBattle)
				validObjectIDsInBattle = noone;
				exit;
			}
		}
		if ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
			if ds_list_size(validObjectIDsInLineOfSight) < 1 {
				ds_list_destroy(validObjectIDsInLineOfSight)
				validObjectIDsInLineOfSight = noone;
				exit;
			}
		}
		// Actually set the local variable that will be used to draw potential targets from based on what ds_list is being used
		if ds_exists(validObjectIDsInBattle, ds_type_list) {
			valid_object_to_target_list_ = validObjectIDsInBattle;
		}
		else if ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
			valid_object_to_target_list_ = validObjectIDsInLineOfSight;
		}
		#region Targeting Engine for Each Object In Combat
		// Set the target for each object to focus
		var i, j, k, iteration_, instance_to_reference_, self_is_in_combat_, temporary_instance_to_reference_, number_of_enemy_targets_, number_of_minion_targets_, weight_at_which_this_target_would_be_focused_at_;
		var number_of_enemies_next_to_enemy_heal_target_, number_of_enemies_next_to_minion_heal_target_, number_of_allies_next_to_enemy_heal_target_, number_of_allies_next_to_minion_heal_target_, weight_at_which_this_heal_target_would_be_focused_at_;
		if !variable_global_exists("enemy_target_grid_") {
			globalvar enemy_target_grid_;
			enemy_target_grid_ = -1;
		}
		if !variable_global_exists("minion_target_grid_") {
			globalvar minion_target_grid_;
			minion_target_grid_ = -1;
		}
		if !variable_global_exists("enemy_heal_target_grid_") {
			globalvar enemy_heal_target_grid_;
			enemy_heal_target_grid_ = -1;
		}
		if !variable_global_exists("minion_heal_target_grid_") {
			globalvar minion_heal_target_grid_;
			minion_heal_target_grid_ = -1;
		}
		if ds_exists(enemy_target_grid_, ds_type_grid) {
			ds_grid_destroy(enemy_target_grid_);
			enemy_target_grid_ = -1;
		}
		if ds_exists(minion_target_grid_, ds_type_grid) {
			ds_grid_destroy(minion_target_grid_);
			minion_target_grid_ = -1;
		}
		if ds_exists(enemy_heal_target_grid_, ds_type_grid) {
			ds_grid_destroy(enemy_heal_target_grid_);
			enemy_heal_target_grid_ = -1;
		}
		if ds_exists(minion_heal_target_grid_, ds_type_grid) {
			ds_grid_destroy(minion_heal_target_grid_);
			minion_heal_target_grid_ = -1;
		}
		enemy_target_grid_ = -1;
		minion_target_grid_ = -1;
		enemy_heal_target_grid_ = -1;
		minion_heal_target_grid_ = -1;
		// Run through the list, detecting all objects and assigning each object its target
		/*
		The below code that is selectively commented out in this section and at the beginning of the actual actions section is code that diversifies this script to decide the current
		target and action for every single object in combat all at once, instead of doing what it normally does, which is deciding the current target and action for the object that is
		calling this script and nothing else. By limiting this script to only decide the current target and action for the object calling this script, I save processing power and a lot
		of needless running through for loops.
		*/
		//if ds_exists(valid_object_to_target_list_, ds_type_list) {
			//for (i = 0; i <= ds_list_size(valid_object_to_target_list_) - 1; i++) {
				//if instance_exists(ds_list_find_value(valid_object_to_target_list_, i)) {
				if instance_exists(self) {
					self_is_in_combat_ = false;
					if ds_exists(valid_object_to_target_list_, ds_type_list) {
						for (j = 0; j <= ds_list_size(valid_object_to_target_list_) - 1; j++) {
							if ds_list_find_value(valid_object_to_target_list_, j) == self {
								self_is_in_combat_ = true;
							}
						}
					}
					if (self_is_in_combat_) || (playerIsAValidFocusTarget) || (playerIsAValidHealTarget) || (playerIsAValidFocusTargetInLineOfSight) || (playerIsAValidHealTargetInLineOfSight) {
						//instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, i);
						instance_to_reference_ = self;
						// Assign enemy targets
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							#region Targeting Engine for Each Healer Object In Combat
							if instance_to_reference_.objectArchetype == "Healer" {
								if !ds_exists(enemy_heal_target_grid_, ds_type_grid) {
									// First column is the combatFriendlyStatus the potential heal target is
									// Second column is the potential heal target's ID
									// Third column is the potential heal target's weight to focus based on potential target's current HP percent
									// Fourth column is the potential heal target's weight to focus based on the archetype the potential heal target is
									// Fifth column is the potential heal target's x location
									// Sixth column is the potential heal target's y location
									// Seventh column is the potential heal target's weight to focus based on adjacent allies
									// Eighth column is the potential heal target's weight to focus based on adjacent enemies
									/*
									For the height of this grid, I add one to the ds_list_size (instead of subtracting one to match exactly the height of the list valid_object_to_target_list_)
									because of the way I use the local variable iteration_ right afterwards. I set the first slot in this grid to player info, which takes a space
									not counted by valid_object_to_target_list_. And then, before adding any info from valid_object_to_target_list_, I add one to iteration_ originally set to 0, which takes
									yet another slot. Because I take 2 slots to get to the space where I write the first bit of info from valid_object_to_target_list_, I add 2 to
									ds_list_size(valid_object_to_target_list_) - 1, which brings us to ds_list_size(valid_object_to_target_list_) + 1.
									*/
									if ds_exists(valid_object_to_target_list_, ds_type_list) {
										enemy_heal_target_grid_ = ds_grid_create(8, (ds_list_size(valid_object_to_target_list_) + 1));
									}
									else {
										chosenEngine = "";
										currentTargetToFocus = noone;
										currentTargetToHeal = noone;
									}
								}
								if ds_exists(enemy_heal_target_grid_, ds_type_grid) {
									iteration_ = 0;
									temporary_instance_to_reference_ = obj_player.id;
									ds_grid_set(enemy_heal_target_grid_, 0, iteration_, "Player");
									ds_grid_set(enemy_heal_target_grid_, 1, iteration_, obj_player.id);
									ds_grid_set(enemy_heal_target_grid_, 2, iteration_, ((obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2) - ((playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2))));
									ds_grid_set(enemy_heal_target_grid_, 3, iteration_, ((obj_ai_decision_making.playerAttackPatternWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) * (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 2)));
									ds_grid_set(enemy_heal_target_grid_, 4, iteration_, temporary_instance_to_reference_.x);
									ds_grid_set(enemy_heal_target_grid_, 5, iteration_, temporary_instance_to_reference_.y);
									if ds_exists(valid_object_to_target_list_, ds_type_list) {
										for (k = 0; k <= ds_list_size(valid_object_to_target_list_) - 1; k++) {
											temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, k);
											if instance_exists(temporary_instance_to_reference_) {
												iteration_ += 1;
												if temporary_instance_to_reference_.combatFriendlyStatus == "Enemy" {
													ds_grid_set(enemy_heal_target_grid_, 0, iteration_, "Enemy");
												}
												else if temporary_instance_to_reference_.combatFriendlyStatus == "Minion" {
													ds_grid_set(enemy_heal_target_grid_, 0, iteration_, "Minion");
												}
												// I set all of these values for each object in combat, whether or not its a valid heal target, because it'll make it easier in the future to
												// add more variables for this engine, in case I want some added.
												ds_grid_set(enemy_heal_target_grid_, 1, iteration_, temporary_instance_to_reference_.id);
												ds_grid_set(enemy_heal_target_grid_, 2, iteration_, ((obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2) - ((temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2))));
												switch (temporary_instance_to_reference_.objectArchetype) {
													case "Healer": ds_grid_set(enemy_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 2));
														break;
													case "Tank": ds_grid_set(enemy_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 1.5));
														break;
													case "Ranged DPS": ds_grid_set(enemy_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 1.0));
														break;
													case "Melee DPS": ds_grid_set(enemy_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 0.5));
														break;
												}
												ds_grid_set(enemy_heal_target_grid_, 4, iteration_, temporary_instance_to_reference_.x);
												ds_grid_set(enemy_heal_target_grid_, 5, iteration_, temporary_instance_to_reference_.y);
											}
										}
									}
									//show_debug_message(string(ds_grid_get(enemy_heal_target_grid_, 5, ds_list_size(valid_object_to_target_list_) + 1)))
									// This isn't necessary but its a great, simple way to disconnect the paragraph of code above with the paragraph of code below, and it makes the code easier
									// to read along with. And to prevent a panic attack, its fine that I reset iteration_ here, because the above code is done with it.
									iteration_ = -1;
									// Scrolling through each potential heal target
									for (k = 0; k <= ds_grid_height(enemy_heal_target_grid_) - 1; k++) {
										iteration_ += 1;
										temporary_instance_to_reference_ = ds_grid_get(enemy_heal_target_grid_, 1, iteration_);
										number_of_allies_next_to_enemy_heal_target_ = 0;
										number_of_enemies_next_to_enemy_heal_target_ = 0;
										// Scrolling through again to find all targets adjacent to potential heal target
										for (j = 0; j <= ds_grid_height(enemy_heal_target_grid_) - 1; j++) {
											// Prevents trying to determine if the heal target is adjacent to itself
											if j != iteration_ {
												// If the object in question is close enough to be considered adjacent to potential heal target
												if point_distance(temporary_instance_to_reference_.x, temporary_instance_to_reference_.y, ds_grid_get(enemy_heal_target_grid_, 4, j), ds_grid_get(enemy_heal_target_grid_, 5, j)) <= obj_ai_decision_making.potentialTargetsMaximumDistanceToBeConsideredAdjacentToSpecificPotentialHealTarget {
													if temporary_instance_to_reference_.id != obj_player.id {
														// If the potential heal target is an enemy (meaning its a valid potential heal target):
														if temporary_instance_to_reference_.combatFriendlyStatus == "Enemy" {
															// If the target adjacent to heal target is an enemy (meaning its an ally of potential heal target):
															if ds_grid_get(enemy_heal_target_grid_, 0, j) == "Enemy" {
																number_of_allies_next_to_enemy_heal_target_ += 1;
															}
															// If the target adjacent to heal target is a minion (meaning its an enemy of potential heal target):
															else if ds_grid_get(enemy_heal_target_grid_, 0, j) == "Minion" {
																number_of_enemies_next_to_enemy_heal_target_ += 1;
															}
															// Lastly, if the target adjacent to heal target is the player (meaning its an enemy of potential heal target):
															else if ds_grid_get(enemy_heal_target_grid_, 0, j) == "Player" {
																number_of_enemies_next_to_enemy_heal_target_ += 1;
															}
														}
													}
												}
											}
										}
										// Set the rest of the weights and determine the final weight to focus heal each potential target
										ds_grid_set(enemy_heal_target_grid_, 6, iteration_, ((number_of_allies_next_to_enemy_heal_target_ / obj_ai_decision_making.idealAmountOfTotalPotentialHealTargetsAdjacentToSpecificPotentialHealTarget) * (obj_ai_decision_making.potentialHealTargetsAdjacentAlliesStartWeight * 2)));
										ds_grid_set(enemy_heal_target_grid_, 7, iteration_, ((number_of_enemies_next_to_enemy_heal_target_ / obj_ai_decision_making.idealAmountOfTotalPotentialEnemyTargetsAdjacentToSpecificPotentialHealTarget) * (obj_ai_decision_making.potentialHealTargetsAdjacentEnemiesStartWeight * 2)));
										if instance_exists(temporary_instance_to_reference_) {
											weight_at_which_this_heal_target_would_be_focused_at_ = (ds_grid_get(enemy_heal_target_grid_, 2, iteration_) + ds_grid_get(enemy_heal_target_grid_, 3, iteration_) + ds_grid_get(enemy_heal_target_grid_, 6, iteration_) + ds_grid_get(enemy_heal_target_grid_, 7, iteration_));
											if ((ds_grid_get(enemy_heal_target_grid_, 0, iteration_) == "Minion") || (ds_grid_get(enemy_heal_target_grid_, 0, iteration_) == "Player")) || (ds_grid_get(enemy_heal_target_grid_, 2, iteration_) == 0) {
												weight_at_which_this_heal_target_would_be_focused_at_ = -1;
											}
											if temporary_instance_to_reference_ == instance_to_reference_.currentTargetToHeal {
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if instance_to_reference_.currentTargetToHeal == noone {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(enemy_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if !instance_exists(instance_to_reference_.currentTargetToHeal) {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(enemy_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt < weight_at_which_this_heal_target_would_be_focused_at_ {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(enemy_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
										}
									}
								}
							}
							else {
								instance_to_reference_.currentTargetToHeal = noone;
								instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = 0;
							}
							if ds_exists(enemy_heal_target_grid_, ds_type_grid) {
								ds_grid_destroy(enemy_heal_target_grid_);
								enemy_heal_target_grid_ = -1;
							}
							#endregion
							#region Normal Targeting Engine for Each Object In Combat
							// I set this to 0, and not -1 like with the minions, because I'm taking up the 0 slot in enemy_target_grid_ with obj_player
							number_of_enemy_targets_ = 0;
							/// ---CREATE THE DS_GRID FOR KEEPING TRACK OF WHAT CAN BE TARGETED BY SPECIFIC OBJECT---
							if !ds_exists(enemy_target_grid_, ds_type_grid) {
								// First column is the ID for all potential targets for instance_to_reference_
								// Second column is the distance between the enemy I'm determing the focus for, and all potential targets.
								// Third column is the weighted rank at which the enemy wants to attack each potential target, on a scale compared to the rest of the potential targets, based on distance
								// Fourth column is the weighted rank at which the enemy wants to attack each potential target, based on how dominated one specific archetype of enemy's attack patterns is by melee or ranged
								// Fifth column is the weighted rank at which the enemy wants to attack each potential target, based on how low the current HP of each potential target is
								if ds_exists(valid_object_to_target_list_, ds_type_list) {
									for (k = 0; k <= ds_list_size(valid_object_to_target_list_) - 1; k++) {
										temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, k);
										if instance_exists(temporary_instance_to_reference_) {
											if (temporary_instance_to_reference_.combatFriendlyStatus == "Minion") {
												number_of_enemy_targets_ += 1;
											}
										}
									}
									// I add one to the number of enemy targets because I'm automatically setting the first entry as the player, which takes a slot - unless the player isn't within view
									enemy_target_grid_ = ds_grid_create(6, (number_of_enemy_targets_ + 1));
								}
								else if playerIsAValidFocusTarget || playerIsAValidFocusTargetInLineOfSight {
									enemy_target_grid_ = ds_grid_create(6, 1);
								}
								/// ---SET THE FIRST ENTRY IN THE DS_GRID TO ALWAYS BE THE PLAYER---
								if ds_exists(enemy_target_grid_, ds_type_grid) {
									temporary_instance_to_reference_ = obj_player.id;
									ds_grid_set(enemy_target_grid_, 0, 0, temporary_instance_to_reference_.id);
									ds_grid_set(enemy_target_grid_, 1, 0, point_distance(instance_to_reference_.x, instance_to_reference_.y, temporary_instance_to_reference_.x, temporary_instance_to_reference_.y));
									ds_grid_set(enemy_target_grid_, 4, 0, (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2) - ((playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2)));
								}
							}
							if ds_exists(enemy_target_grid_, ds_type_grid) {
								/// ---DETERMINE HOW FAR EACH POTENTIAL TARGET IS FROM SPECIFIC OBJECT---
								if ds_exists(valid_object_to_target_list_, ds_type_list) {
									iteration_ = 0;
									for (j = 0; j <= ds_list_size(valid_object_to_target_list_) - 1; j++) {
										temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, j);
										if instance_exists(temporary_instance_to_reference_) {
											if (temporary_instance_to_reference_.combatFriendlyStatus == "Minion") {
												iteration_ += 1;
												ds_grid_set(enemy_target_grid_, 0, iteration_, temporary_instance_to_reference_.id);
												ds_grid_set(enemy_target_grid_, 1, iteration_, point_distance(temporary_instance_to_reference_.x, temporary_instance_to_reference_.y, instance_to_reference_.x, instance_to_reference_.y))
												ds_grid_set(enemy_target_grid_, 4, iteration_, (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2) - ((temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2)));
											}
										}
									}
								}
								/// ---SET THE WEIGHT AT WHICH EACH OBJECT WANTS TO ATTACK EACH POTENTIAL TARGET BASED ON PROXIMITY---
								for (k = 0; k <= ds_grid_height(enemy_target_grid_) - 1; k++) {
									ds_grid_set(enemy_target_grid_, 2, k, ((obj_ai_decision_making.objectProximityToTargetForTargetingPurposesStartWeight * 2) * (1 - (ds_grid_get(enemy_target_grid_, 1, k) / camera_get_view_width(view_camera[0])))));
								}
								/*
								/// ---SET THE WEIGHT AT WHICH THE OBJECT WANTS TO ATTACK EACH POTENTIAL TARGET BASED ON WHAT KIND OF PLAYSTYLE THE TARGET HAS---
								if player is potential target, set as is or inverse playerAttackPatternWeight based on whether the enemy I'm evaluating for is a healer/ranged dps, or tank/melee dps
								if enemy is potential target, set as is or inverse enemyAttackPatternWeight based on whether the enemy I'm evaluating for is a healer/ranged dps, or tank/melee dps
								*/
								temporary_instance_to_reference_ = 0;
								if (instance_to_reference_.objectArchetype == "Healer") || (instance_to_reference_.objectArchetype == "Ranged DPS") {
									for (k = 0; k <= ds_grid_height(enemy_target_grid_) - 1; k++) {
										temporary_instance_to_reference_ = ds_grid_get(enemy_target_grid_, 0, k);
										if instance_exists(temporary_instance_to_reference_) {
											if ds_grid_get(enemy_target_grid_, 0, k) == obj_player.id {
												ds_grid_set(enemy_target_grid_, 3, k, obj_ai_decision_making.playerAttackPatternWeight);
											}
											else {
												ds_grid_set(enemy_target_grid_, 3, k, instance_to_reference_.enemyAttackPatternWeight);
											}
										}
									}
								}
								else if (instance_to_reference_.objectArchetype == "Tank") || (instance_to_reference_.objectArchetype == "Melee DPS") {
									for (k = 0; k <= ds_grid_height(enemy_target_grid_) - 1; k++) {
										temporary_instance_to_reference_ = ds_grid_get(enemy_target_grid_, 0, k);
										if instance_exists(temporary_instance_to_reference_) {
											if ds_grid_get(enemy_target_grid_, 0, k) == obj_player.id {
												ds_grid_set(enemy_target_grid_, 3, k, ((obj_ai_decision_making.attackPatternStartWeight * 2) - obj_ai_decision_making.playerAttackPatternWeight));
											}
											else {
												temporary_instance_to_reference_ = ds_grid_get(enemy_target_grid_, 0, k)
												ds_grid_set(enemy_target_grid_, 3, k, ((obj_ai_decision_making.attackPatternStartWeight * 2) - temporary_instance_to_reference_.enemyAttackPatternWeight));
											}
										}
									}
								}
								/// ---CONSOLIDATE WEIGHTS AND ASSIGN A TARGET TO FOCUS FOR THE OBJECTBASED ON BOTH WEIGHTS PREVIOUSLY OBTAINED---
								weight_at_which_this_target_would_be_focused_at_ = 0;
								for (k = 0; k <= ds_grid_height(enemy_target_grid_) - 1; k++) {
									temporary_instance_to_reference_ = ds_grid_get(enemy_target_grid_, 0, k);
									if instance_exists(temporary_instance_to_reference_) {
										var target_of_target_ = noone;
										if temporary_instance_to_reference_.id != obj_player.id {
											target_of_target_ = temporary_instance_to_reference_.currentTargetToFocus;
										}
										else {
											target_of_target_ = lastEnemyHitByPlayer;
										}
										if instance_exists(target_of_target_) {
											if target_of_target_ != obj_player.id {
												switch (target_of_target_.objectArchetype) {
													case "Healer": ds_grid_set(enemy_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 2));
														break;
													case "Tank": ds_grid_set(enemy_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 1.5));
														break;
													case "Ranged DPS": ds_grid_set(enemy_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 1));
														break;
													case "Melee DPS": ds_grid_set(enemy_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 0.5));
														break;
												}
											}
											else {
												ds_grid_set(enemy_target_grid_, 5, k, (obj_ai_decision_making.playerAttackPatternWeight * (obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight * 2)));
											}
										}
										else {
											ds_grid_set(enemy_target_grid_, 5, k, 0);
										}
										weight_at_which_this_target_would_be_focused_at_ = ds_grid_get(enemy_target_grid_, 2, k) + ds_grid_get(enemy_target_grid_, 3, k) + ds_grid_get(enemy_target_grid_, 4, k) + ds_grid_get(enemy_target_grid_, 5, k);
										// If the ds_list valid_object_to_target_list_ exists, and the player isn't included in that list,
										// then remove the player as a possible target.
										if temporary_instance_to_reference_ == obj_player.id {
											if !playerIsAValidFocusTarget && !playerIsAValidFocusTargetInLineOfSight {
												weight_at_which_this_target_would_be_focused_at_ = -1;
											}
										}
										if temporary_instance_to_reference_ == instance_to_reference_.currentTargetToFocus {
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if instance_to_reference_.currentTargetToFocus == noone {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(enemy_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if !instance_exists(instance_to_reference_.currentTargetToFocus) {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(enemy_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if (instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt < weight_at_which_this_target_would_be_focused_at_) {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(enemy_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
									}
								}
							}
							if ds_exists(enemy_target_grid_, ds_type_grid) {
								ds_grid_destroy(enemy_target_grid_);
								enemy_target_grid_ = -1;
							}
							#endregion
						}
					
					
						else if instance_to_reference_.combatFriendlyStatus == "Minion" {
							#region Targeting Engine for Each Healer Object In Combat
							if instance_to_reference_.objectArchetype == "Healer" {
								if !ds_exists(minion_heal_target_grid_, ds_type_grid) {
									// First column is the combatFriendlyStatus the potential heal target is
									// Second column is the potential heal target's ID
									// Third column is the potential heal target's weight to focus based on potential target's current HP percent
									// Fourth column is the potential heal target's weight to focus based on the archetype the potential heal target is
									// Fifth column is the potential heal target's x location
									// Sixth column is the potential heal target's y location
									// Seventh column is the potential heal target's weight to focus based on adjacent allies
									// Eighth column is the potential heal target's weight to focus based on adjacent enemies
									/*
									For the height of this grid, I add one to the ds_list_size (instead of subtracting one to match exactly the height of the list valid_object_to_target_list_)
									because of the way I use the local variable iteration_ right afterwards. I set the first slot in this grid to player info, which takes a space
									not counted by valid_object_to_target_list_. And then, before adding any info from valid_object_to_target_list_, I add one to iteration_ originally set to 0, which takes
									yet another slot. Because I take 2 slots to get to the space where I write the first bit of info from valid_object_to_target_list_, I add 2 to
									ds_list_size(valid_object_to_target_list_) - 1, which brings us to ds_list_size(valid_object_to_target_list_) + 1.
									*/
									if ds_exists(valid_object_to_target_list_, ds_type_list) {
										minion_heal_target_grid_ = ds_grid_create(9, (ds_list_size(valid_object_to_target_list_) + 1));
									}
									else if (playerIsAValidHealTarget) || (playerIsAValidHealTargetInLineOfSight) {
										minion_heal_target_grid_ = ds_grid_create(9, 1);
									}
								}
								if ds_exists(minion_heal_target_grid_, ds_type_grid) {
									// Only set the first value in the grid to equal the player if the player is in line of sight or has a path to the minion.
									// Otherwise, don't set the player inside the minion_heal_target_grid_.
									if playerIsAValidHealTarget || playerIsAValidHealTargetInLineOfSight {
										iteration_ = 0;
										temporary_instance_to_reference_ = obj_player.id;
										ds_grid_set(minion_heal_target_grid_, 0, iteration_, "Player");
										ds_grid_set(minion_heal_target_grid_, 1, iteration_, obj_player.id);
										ds_grid_set(minion_heal_target_grid_, 2, iteration_, ((obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2) - ((playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2))));
										ds_grid_set(minion_heal_target_grid_, 3, iteration_, ((obj_ai_decision_making.playerAttackPatternWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) * (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 2)));
										ds_grid_set(minion_heal_target_grid_, 4, iteration_, temporary_instance_to_reference_.x);
										ds_grid_set(minion_heal_target_grid_, 5, iteration_, temporary_instance_to_reference_.y);
									}
									else {
										iteration_ = -1;
									}
									if ds_exists(valid_object_to_target_list_, ds_type_list) {
										for (k = 0; k <= ds_list_size(valid_object_to_target_list_) - 1; k++) {
											temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, k);
											if instance_exists(temporary_instance_to_reference_) {
												iteration_ += 1;
												if temporary_instance_to_reference_.combatFriendlyStatus == "Enemy" {
													ds_grid_set(minion_heal_target_grid_, 0, iteration_, "Enemy");
												}
												else if temporary_instance_to_reference_.combatFriendlyStatus == "Minion" {
													ds_grid_set(minion_heal_target_grid_, 0, iteration_, "Minion");
												}
												// I set all of these values for each object in combat, whether or not its a valid heal target, because it'll make it easier in the future to
												// add more variables for this engine, in case I want some added.
												ds_grid_set(minion_heal_target_grid_, 1, iteration_, temporary_instance_to_reference_.id);
												ds_grid_set(minion_heal_target_grid_, 2, iteration_, ((obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2) - ((temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.potentialHealTargetsCurrentHPStartWeight * 2))));
												switch (temporary_instance_to_reference_.objectArchetype) {
													case "Healer": ds_grid_set(minion_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 2));
														break;
													case "Tank": ds_grid_set(minion_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 1.5));
														break;
													case "Ranged DPS": ds_grid_set(minion_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 1.0));
														break;
													case "Melee DPS": ds_grid_set(minion_heal_target_grid_, 3, iteration_, (obj_ai_decision_making.potentialHealTargetsAreDifferentArchetypesStartWeight * 0.5));
														break;
												}
												ds_grid_set(minion_heal_target_grid_, 4, iteration_, temporary_instance_to_reference_.x);
												ds_grid_set(minion_heal_target_grid_, 5, iteration_, temporary_instance_to_reference_.y);
											}
										}
									}
									// This isn't necessary but its a great, simple way to disconnect the paragraph of code above with the paragraph of code below, and it makes the code easier
									// to read along with. And to prevent a panic attack, its fine that I reset iteration_ here, because the above code is done with it.
									iteration_ = -1;
									// Scrolling through each potential heal target
									for (k = 0; k <= ds_grid_height(minion_heal_target_grid_) - 1; k++) {
										iteration_ += 1;
										temporary_instance_to_reference_ = ds_grid_get(minion_heal_target_grid_, 1, iteration_);
										number_of_allies_next_to_minion_heal_target_ = 0;
										number_of_enemies_next_to_minion_heal_target_ = 0;
										// Scrolling through again to find all targets adjacent to potential heal target
										for (j = 0; j <= ds_grid_height(minion_heal_target_grid_) - 1; j++) {
											// Prevents trying to determine if the heal target is adjacent to itself
											if j != iteration_ {
												// If the object in question is close enough to be considered adjacent to potential heal target
												if point_distance(temporary_instance_to_reference_.x, temporary_instance_to_reference_.y, ds_grid_get(minion_heal_target_grid_, 4, j), ds_grid_get(minion_heal_target_grid_, 5, j)) <= obj_ai_decision_making.potentialTargetsMaximumDistanceToBeConsideredAdjacentToSpecificPotentialHealTarget {
													// IF the potential heal target is the player (meaning its a valid potential heal target)
													if temporary_instance_to_reference_.id == obj_player.id {
														// If the target adjacent to heal target is a minion (meaning its an ally of potential heal target):
														if ds_grid_get(minion_heal_target_grid_, 0, j) == "Minion" {
															number_of_allies_next_to_minion_heal_target_ += 1;
														}
														// If the target adjacent to heal target is an enemy (meaning its an enemy of potential heal target):
														else if ds_grid_get(minion_heal_target_grid_, 0, j) == "Enemy" {
															number_of_enemies_next_to_minion_heal_target_ += 1;
														}
														// Lastly, if the target adjacent to heal target is the player (meaning its an ally of potential heal target):
														else if ds_grid_get(minion_heal_target_grid_, 0, j) == "Player" {
															number_of_allies_next_to_minion_heal_target_ += 1;
														}
													}
													// If the potential heal target is a minion (meaning its a valid potential heal target):
													else if temporary_instance_to_reference_.combatFriendlyStatus == "Minion" {
														// If the target adjacent to heal target is a minion (meaning its an ally of potential heal target):
														if ds_grid_get(minion_heal_target_grid_, 0, j) == "Minion" {
															number_of_allies_next_to_minion_heal_target_ += 1;
														}
														// If the target adjacent to heal target is an enemy (meaning its an enemy of potential heal target):
														else if ds_grid_get(minion_heal_target_grid_, 0, j) == "Enemy" {
															number_of_enemies_next_to_minion_heal_target_ += 1;
														}
														// Lastly, if the target adjacent to heal target is the player (meaning its an ally of potential heal target):
														else if ds_grid_get(minion_heal_target_grid_, 0, j) == "Player" {
															number_of_allies_next_to_minion_heal_target_ += 1;
														}
													}
												}
											}
										}
										// Set the rest of the weights and determine the final weight to focus heal each potential target
										ds_grid_set(minion_heal_target_grid_, 6, iteration_, ((number_of_allies_next_to_minion_heal_target_ / obj_ai_decision_making.idealAmountOfTotalPotentialHealTargetsAdjacentToSpecificPotentialHealTarget) * (obj_ai_decision_making.potentialHealTargetsAdjacentAlliesStartWeight * 2)));
										ds_grid_set(minion_heal_target_grid_, 7, iteration_, ((number_of_enemies_next_to_minion_heal_target_ / obj_ai_decision_making.idealAmountOfTotalPotentialEnemyTargetsAdjacentToSpecificPotentialHealTarget) * (obj_ai_decision_making.potentialHealTargetsAdjacentEnemiesStartWeight * 2)));
										if instance_exists(temporary_instance_to_reference_) {
											/*
											--------------IMPORTANT-----------
										
											If I want the healer minions to NOT treat the player like a valid heal target, input the line below surrounding the paragraph below this comment
											if temporary_instance_to_reference_ != obj_player.id {
										
											--------------IMPORTANT-----------
											*/
											weight_at_which_this_heal_target_would_be_focused_at_ = (ds_grid_get(minion_heal_target_grid_, 2, iteration_) + ds_grid_get(minion_heal_target_grid_, 3, iteration_) + ds_grid_get(minion_heal_target_grid_, 6, iteration_) + ds_grid_get(minion_heal_target_grid_, 7, iteration_));
											if (ds_grid_get(minion_heal_target_grid_, 0, iteration_) == "Enemy") || (ds_grid_get(minion_heal_target_grid_, 2, iteration_) == 0) {
												weight_at_which_this_heal_target_would_be_focused_at_ = 0;
											}
											if temporary_instance_to_reference_ == instance_to_reference_.currentTargetToHeal {
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if instance_to_reference_.currentTargetToHeal == noone {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(minion_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if !instance_exists(instance_to_reference_.currentTargetToHeal) {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(minion_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
											else if instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt < weight_at_which_this_heal_target_would_be_focused_at_ {
												instance_to_reference_.currentTargetToHeal = ds_grid_get(minion_heal_target_grid_, 1, iteration_);
												instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = weight_at_which_this_heal_target_would_be_focused_at_;
											}
										}
									}
								}
							}
							else {
								instance_to_reference_.currentTargetToHeal = noone;
								instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = 0;
							}
							if ds_exists(minion_heal_target_grid_, ds_type_grid) {
								ds_grid_destroy(minion_heal_target_grid_);
								minion_heal_target_grid_ = -1;
							}
							#endregion
							#region Normal Targeting Engine for Each Object In Combat
							number_of_minion_targets_ = 0;
							/// ---CREATE THE DS_GRID FOR KEEPING TRACK OF WHAT CAN BE TARGETED BY SPECIFIC OBJECT---
							if !ds_exists(minion_target_grid_, ds_type_grid) {
								// First column is the ID for all potential targets for instance_to_reference_
								// Second column is the distance between the minion I'm determing the focus for, and all potential targets.
								// Third column is the weighted rank at which the minion wants to attack each potential target, on a scale compared to the rest of the potential targets, based on distance
								// Fourth column is the weighted rank at which the minion wants to attack each potential target, based on how dominated one specific archetype of the minion's attack patterns is by melee or ranged
								// Fifth column is the weighted rank at which the minion wants to attack each potential target, based on how low the current HP of each potential target is
								if ds_exists(valid_object_to_target_list_, ds_type_list) {
									for (k = 0; k <= ds_list_size(valid_object_to_target_list_) - 1; k++) {
										temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, k);
										if instance_exists(temporary_instance_to_reference_) {
											if (temporary_instance_to_reference_.combatFriendlyStatus == "Enemy") {
												number_of_minion_targets_ += 1;
											}
										}
									}
								}
								else {
									chosenEngine = "";
									currentTargetToFocus = noone;
									currentTargetToHeal = noone;
								}
								if number_of_minion_targets_ != 0 {
									minion_target_grid_ = ds_grid_create(6, number_of_minion_targets_);
									ds_grid_set(minion_target_grid_, 0, 0, noone);
								}
							}
							if ds_exists(minion_target_grid_, ds_type_grid) {
								/// ---DETERMINE HOW FAR EACH POTENTIAL TARGET IS FROM SPECIFIC OBJECT---
								iteration_ = -1;
								for (j = 0; j <= ds_list_size(valid_object_to_target_list_) - 1; j++) {
									temporary_instance_to_reference_ = ds_list_find_value(valid_object_to_target_list_, j);
									if instance_exists(temporary_instance_to_reference_) {
										if (temporary_instance_to_reference_.combatFriendlyStatus == "Enemy") {
											iteration_ += 1;
											ds_grid_set(minion_target_grid_, 0, iteration_, temporary_instance_to_reference_);
											ds_grid_set(minion_target_grid_, 1, iteration_, point_distance(temporary_instance_to_reference_.x, temporary_instance_to_reference_.y, instance_to_reference_.x, instance_to_reference_.y))
											ds_grid_set(minion_target_grid_, 4, iteration_, (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2) - ((temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.potentialTargetsCurrentHPStartWeight * 2)));
										}
									}
								}
								/// ---SET THE WEIGHT AT WHICH EACH OBJECT WANTS TO ATTACK EACH POTENTIAL TARGET BASED ON PROXIMITY---
								for (k = 0; k <= ds_grid_height(minion_target_grid_) - 1; k++) {
									ds_grid_set(minion_target_grid_, 2, k, ((obj_ai_decision_making.objectProximityToTargetForTargetingPurposesStartWeight * 2) * (1 - (ds_grid_get(minion_target_grid_, 1, k) / camera_get_view_width(view_camera[0])))));
								}
								/// ---SET THE WEIGHT AT WHICH THE OBJECT WANTS TO ATTACK EACH POTENTIAL TARGET BASED ON WHAT KIND OF PLAYSTYLE THE TARGET HAS---
								if (instance_to_reference_.objectArchetype == "Healer") || (instance_to_reference_.objectArchetype == "Ranged DPS") {
									for (k = 0; k <= ds_grid_height(minion_target_grid_) - 1; k++) {
										temporary_instance_to_reference_ = ds_grid_get(minion_target_grid_, 0, k)
										if instance_exists(temporary_instance_to_reference_) {
											ds_grid_set(minion_target_grid_, 3, k, temporary_instance_to_reference_.enemyAttackPatternWeight);
										}
									}
								}
								else if (instance_to_reference_.objectArchetype == "Tank") || (instance_to_reference_.objectArchetype == "Melee DPS") {
									for (k = 0; k <= ds_grid_height(minion_target_grid_) - 1; k++) {
										temporary_instance_to_reference_ = ds_grid_get(minion_target_grid_, 0, k)
										if instance_exists(temporary_instance_to_reference_) {
											ds_grid_set(minion_target_grid_, 3, k, ((obj_ai_decision_making.attackPatternStartWeight * 2) - temporary_instance_to_reference_.enemyAttackPatternWeight));
										}
									}
								}
								/// ---CONSOLIDATE WEIGHTS AND ASSIGN A TARGET TO FOCUS FOR THE OBJECTBASED ON BOTH WEIGHTS PREVIOUSLY OBTAINED---
								weight_at_which_this_target_would_be_focused_at_ = 0;
								for (k = 0; k <= ds_grid_height(minion_target_grid_) - 1; k++) {
									temporary_instance_to_reference_ = ds_grid_get(minion_target_grid_, 0, k);
									if instance_exists(temporary_instance_to_reference_) {
										var target_of_target_ = noone;
										target_of_target_ = temporary_instance_to_reference_.currentTargetToFocus;
										if instance_exists(target_of_target_) {
											if target_of_target_ != obj_player.id {
												switch (target_of_target_.objectArchetype) {
													case "Healer": ds_grid_set(minion_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 2));
														break;
													case "Tank": ds_grid_set(minion_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 1.5));
														break;
													case "Ranged DPS": ds_grid_set(minion_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 1));
														break;
													case "Melee DPS": ds_grid_set(minion_target_grid_, 5, k, ((instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier * obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight) * 0.5));
														break;
												}
											}
											else {
												ds_grid_set(minion_target_grid_, 5, k, (obj_ai_decision_making.playerAttackPatternWeight * (obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight * 2)));
											}
										}
										else {
											ds_grid_set(minion_target_grid_, 5, k, 0);
										}
										weight_at_which_this_target_would_be_focused_at_ = ds_grid_get(minion_target_grid_, 2, k) + ds_grid_get(minion_target_grid_, 3, k) + ds_grid_get(minion_target_grid_, 4, k) + ds_grid_get(minion_target_grid_, 5, k);
										if temporary_instance_to_reference_ == instance_to_reference_.currentTargetToFocus {
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if instance_to_reference_.currentTargetToFocus == noone {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(minion_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if !instance_exists(instance_to_reference_.currentTargetToFocus) {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(minion_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
										else if (instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt < weight_at_which_this_target_would_be_focused_at_) {
											instance_to_reference_.currentTargetToFocus = ds_grid_get(minion_target_grid_, 0, k);
											instance_to_reference_.weightAtWhichEnemyIsCurrentlyFocusingTargetAt = weight_at_which_this_target_would_be_focused_at_;
										}
									}
								}
							}
							if ds_exists(minion_target_grid_, ds_type_grid) {
								ds_grid_destroy(minion_target_grid_);
								minion_target_grid_ = -1;
							}
							#endregion
						}
					}
				}
			//}
		//}
		#endregion
	}
	#endregion


	#region Setting Weights for each Individual Engine
	if (ds_exists(validObjectIDsInBattle, ds_type_list)) || (ds_exists(validObjectIDsInLineOfSight, ds_type_list)) || ((playerIsAValidFocusTarget || playerIsAValidFocusTargetInLineOfSight) && combatFriendlyStatus == "Enemy") || ((playerIsAValidHealTarget || (playerIsAValidHealTargetInLineOfSight)) && combatFriendlyStatus == "Minion") {
		var i = 0;
		//for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
			//if instance_exists(ds_list_find_value(validObjectIDsInBattle, i)) {
				//var instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, i);
				if instance_exists(self) {
					var instance_to_reference_ = self;
					#region Heavy Melee Engine
					if instance_exists(instance_to_reference_.currentTargetToFocus) {
						instance_to_reference_.selfCurrentHPPercentForHeavyMeleeEngineTotalWeight = (instance_to_reference_.selfCurrentHPPercent * (obj_ai_decision_making.selfCurrentHPPercentForHeavyMeleeEngineStartWeight * 2))
						instance_to_reference_.targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineTotalWeight = (obj_ai_decision_making.targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineStartWeight * 2) - (instance_to_reference_.targetCurrentPercentageOfStaminaAndMana * obj_ai_decision_making.targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineStartWeight);
						if instance_to_reference_.targetOfTargetCurrentHP != -1 {
							instance_to_reference_.targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight = (instance_to_reference_.targetOfTargetCurrentHP * (obj_ai_decision_making.targetOfTargetCurrentHPForHeavyMeleeEngineStartWeight * 2));
						}
						else {
							instance_to_reference_.targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight = obj_ai_decision_making.targetOfTargetCurrentHPForHeavyMeleeEngineStartWeight;
						}
						instance_to_reference_.objectProximityToTargetForHeavyMeleeEngineTotalWeight = (obj_ai_decision_making.objectProximityToTargetForHeavyMeleeEngineStartWeight * 2) * (1 - (instance_to_reference_.objectProximityToTarget / camera_get_view_width(view_camera[0])));
						instance_to_reference_.percentageOfDamageToTargetTotalHPForHeavyMeleeEngineTotalWeight = (instance_to_reference_.percentageOfDamageToTargetTotalHPHeavyMeleeAttackWillDeal * (obj_ai_decision_making.percentageOfDamageToTargetTotalHPForHeavyMeleeEngineStartWeight * 2))
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							instance_to_reference_.totalEnemiesInBattleForHeavyMeleeEngineTotalWeight = (((1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyMeleeEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHeavyMeleeEngineStartWeight));
						}
						else if instance_to_reference_.combatFriendlyStatus == "Minion" {
							instance_to_reference_.totalEnemiesInBattleForHeavyMeleeEngineTotalWeight = (((enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyMeleeEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHeavyMeleeEngineStartWeight));
						}
						// Set the total weight
						instance_to_reference_.heavyMeleeEngineTotalWeight = (instance_to_reference_.selfCurrentHPPercentForHeavyMeleeEngineTotalWeight + instance_to_reference_.targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineTotalWeight + instance_to_reference_.targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight + instance_to_reference_.objectProximityToTargetForHeavyMeleeEngineTotalWeight + instance_to_reference_.percentageOfDamageToTargetTotalHPForHeavyMeleeEngineTotalWeight + instance_to_reference_.totalEnemiesInBattleForHeavyMeleeEngineTotalWeight) * instance_to_reference_.heavyMeleeEngineWeightMultiplier;
					}
					#endregion
					#region Light Melee Engine
					if instance_exists(instance_to_reference_.currentTargetToFocus) {
						instance_to_reference_.selfCurrentHPPercentForLightMeleeEngineTotalWeight = (obj_ai_decision_making.selfCurrentHPPercentForLightMeleeEngineStartWeight * 2) - (instance_to_reference_.selfCurrentHPPercent * (obj_ai_decision_making.selfCurrentHPPercentForLightMeleeEngineStartWeight * 2))
						instance_to_reference_.targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineTotalWeight = (instance_to_reference_.targetCurrentPercentageOfStaminaAndMana * obj_ai_decision_making.targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineStartWeight);
						if instance_to_reference_.targetOfTargetCurrentHP != -1 {
							instance_to_reference_.targetOfTargetCurrentHPForLightMeleeEngineTotalWeight = (obj_ai_decision_making.targetOfTargetCurrentHPForLightMeleeEngineStartWeight * 2) - (instance_to_reference_.targetOfTargetCurrentHP * (obj_ai_decision_making.targetOfTargetCurrentHPForLightMeleeEngineStartWeight * 2));
						}
						else {
							instance_to_reference_.targetOfTargetCurrentHPForLightMeleeEngineTotalWeight = obj_ai_decision_making.targetOfTargetCurrentHPForLightMeleeEngineStartWeight;
						}
						instance_to_reference_.objectProximityToTargetForLightMeleeEngineTotalWeight = (obj_ai_decision_making.objectProximityToTargetForLightMeleeEngineStartWeight * 2) * (1 - (instance_to_reference_.objectProximityToTarget / camera_get_view_width(view_camera[0])));
						instance_to_reference_.percentageOfDamageToTargetCurrentHPForLightMeleeEngineTotalWeight = (instance_to_reference_.percentageOfDamageToTargetCurrentHPLightMeleeAttackWillDeal * (obj_ai_decision_making.percentageOfDamageToTargetCurrentHPForLightMeleeEngineStartWeight * 2))
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if (1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) <= (obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine * 2) {
								instance_to_reference_.totalEnemiesInBattleForLightMeleeEngineTotalWeight = (((obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine * 2) - (1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle)) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine) * (obj_ai_decision_making.totalEnemiesInBattleForLightMeleeEngineStartWeight);
							}
							else {
								instance_to_reference_.totalEnemiesInBattleForLightMeleeEngineTotalWeight = 0;
							}
						}
						else if instance_to_reference_.combatFriendlyStatus == "Minion" {
							if (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) <= (obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine * 2) {
								instance_to_reference_.totalEnemiesInBattleForLightMeleeEngineTotalWeight = (((obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine * 2) - (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle)) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightMeleeEngine) * (obj_ai_decision_making.totalEnemiesInBattleForLightMeleeEngineStartWeight);
							}
							else {
								instance_to_reference_.totalEnemiesInBattleForLightMeleeEngineTotalWeight = 0;
							}
						}
						// Set the total weight
						instance_to_reference_.lightMeleeEngineTotalWeight = (instance_to_reference_.selfCurrentHPPercentForLightMeleeEngineTotalWeight + instance_to_reference_.targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineTotalWeight + instance_to_reference_.targetOfTargetCurrentHPForLightMeleeEngineTotalWeight + instance_to_reference_.objectProximityToTargetForLightMeleeEngineTotalWeight + instance_to_reference_.percentageOfDamageToTargetCurrentHPForLightMeleeEngineTotalWeight + instance_to_reference_.totalEnemiesInBattleForLightMeleeEngineTotalWeight) * instance_to_reference_.lightMeleeEngineWeightMultiplier;
					}
					#endregion
					#region Heavy Ranged Engine
					if instance_exists(instance_to_reference_.currentTargetToFocus) {
						var temporary_instance_to_reference_ = instance_to_reference_.currentTargetToFocus;
						if temporary_instance_to_reference_ != obj_player.id {
							instance_to_reference_.targetCurrentHPPercentForHeavyRangedEngineTotalWeight = (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForHeavyRangedEngineStartWeight * 2);
							// START OF DETERMINING targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight -----
							if instance_exists(temporary_instance_to_reference_.currentTargetToFocus) {
								var target_of_target_ = temporary_instance_to_reference_.currentTargetToFocus;
								if target_of_target_ != obj_player.id {
									switch (target_of_target_.objectArchetype) {
										case "Healer": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight * 2.00;
											break;
										case "Tank": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight * 1.33;
											break;
										case "Melee DPS": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight * 0.66;
											break;
										case "Ranged DPS": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight * 0.00;
											break;
									}
								}
								else if target_of_target_ == obj_player.id {
									instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = (obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight * ((1 / obj_ai_decision_making.attackPatternStartWeight) * obj_ai_decision_making.playerAttackPatternWeight))
								}
							}
							else {
								instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight;
							}
							// END -----
						}
						else if temporary_instance_to_reference_ == obj_player.id {
							instance_to_reference_.targetCurrentHPPercentForHeavyRangedEngineTotalWeight = (playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForHeavyRangedEngineStartWeight * 2);
						}
						instance_to_reference_.selfCurrentHPPercentForHeavyRangedEngineTotalWeight = instance_to_reference_.selfCurrentHPPercent * (obj_ai_decision_making.selfCurrentHPPercentForHeavyRangedEngineStartWeight * 2);
						instance_to_reference_.objectProximityToTargetForHeavyRangedEngineTotalWeight = (instance_to_reference_.objectProximityToTarget / camera_get_view_width(view_camera[0])) * (obj_ai_decision_making.objectProximityToTargetForHeavyRangedEngineStartWeight * 2);
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if (1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) <= (obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine * 2) {
								instance_to_reference_.totalEnemiesInBattleForHeavyRangedEngineTotalWeight = (((obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine * 2) - (1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle)) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHeavyRangedEngineStartWeight);
							}
							else {
								instance_to_reference_.totalEnemiesInBattleForHeavyRangedEngineTotalWeight = 0;
							}
						}
						else if instance_to_reference_.combatFriendlyStatus == "Minion" {
							if (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) <= (obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine * 2) {
								instance_to_reference_.totalEnemiesInBattleForHeavyRangedEngineTotalWeight = (((obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine * 2) - (enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle)) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHeavyRangedEngineStartWeight);
							}
							else {
								instance_to_reference_.totalEnemiesInBattleForHeavyRangedEngineTotalWeight = 0;
							}
						}
						instance_to_reference_.percentageOfDamageToTargetTotalHPForHeavyRangedEngineTotalWeight = instance_to_reference_.percentageOfDamageToTargetTotalHPHeavyRangedAttackWillDeal * (obj_ai_decision_making.percentageOfDamageToTargetTotalHPForHeavyRangedEngineStartWeight * 2);
						instance_to_reference_.heavyRangedEngineTotalWeight = (instance_to_reference_.targetCurrentHPPercentForHeavyRangedEngineTotalWeight + instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight + instance_to_reference_.selfCurrentHPPercentForHeavyRangedEngineTotalWeight + instance_to_reference_.objectProximityToTargetForHeavyRangedEngineTotalWeight + instance_to_reference_.totalEnemiesInBattleForHeavyRangedEngineTotalWeight + instance_to_reference_.percentageOfDamageToTargetTotalHPForHeavyRangedEngineTotalWeight) * instance_to_reference_.heavyRangedEngineWeightMultiplier;
					}
					#endregion
					#region Light Ranged Engine
					if instance_exists(instance_to_reference_.currentTargetToFocus) {
						var temporary_instance_to_reference_ = instance_to_reference_.currentTargetToFocus;
						if temporary_instance_to_reference_ != obj_player.id {
							instance_to_reference_.targetCurrentHPPercentForLightRangedEngineTotalWeight = (obj_ai_decision_making.targetCurrentHPPercentForHeavyRangedEngineStartWeight * 2) - ((temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForLightRangedEngineStartWeight * 2));
							// START OF DETERMINING targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight -----
							if instance_exists(temporary_instance_to_reference_.currentTargetToFocus) {
								var target_of_target_ = temporary_instance_to_reference_.currentTargetToFocus;
								if target_of_target_ != obj_player.id {
									switch (target_of_target_.objectArchetype) {
										case "Healer": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight * 0.00;
											break;
										case "Tank": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight * 0.66;
											break;
										case "Melee DPS": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight * 1.33;
											break;
										case "Ranged DPS": instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight * 2.0;
											break;
									}
								}
								else if target_of_target_ == obj_player.id {
									instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = (obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight * ((1 / obj_ai_decision_making.attackPatternStartWeight) * obj_ai_decision_making.playerAttackPatternWeight))
								}
							}
							else {
								instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = obj_ai_decision_making.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight;
							}
							// END -----
						}
						else if temporary_instance_to_reference_ == obj_player.id {
							instance_to_reference_.targetCurrentHPPercentForLightRangedEngineTotalWeight = (obj_ai_decision_making.targetCurrentHPPercentForHeavyRangedEngineStartWeight * 2) - ((playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForLightRangedEngineStartWeight * 2));
						}
						instance_to_reference_.selfCurrentHPPercentForLightRangedEngineTotalWeight = (obj_ai_decision_making.selfCurrentHPPercentForHeavyRangedEngineStartWeight * 2) - (instance_to_reference_.selfCurrentHPPercent * (obj_ai_decision_making.selfCurrentHPPercentForLightRangedEngineStartWeight * 2));
						instance_to_reference_.objectProximityToTargetForLightRangedEngineTotalWeight = (instance_to_reference_.objectProximityToTarget / camera_get_view_width(view_camera[0])) * (obj_ai_decision_making.objectProximityToTargetForLightRangedEngineStartWeight * 2);
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							instance_to_reference_.totalEnemiesInBattleForLightRangedEngineTotalWeight = ((1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightRangedEngine) * (obj_ai_decision_making.totalEnemiesInBattleForLightRangedEngineStartWeight);
						}
						else if instance_to_reference_.combatFriendlyStatus == "Minion" {
							instance_to_reference_.totalEnemiesInBattleForLightRangedEngineTotalWeight = ((enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForLightRangedEngine) * (obj_ai_decision_making.totalEnemiesInBattleForLightRangedEngineStartWeight);
						}
						instance_to_reference_.percentageOfDamageToTargetCurrentHPForLightRangedEngineTotalWeight = instance_to_reference_.percentageOfDamageToTargetCurrentHPLightRangedAttackWillDeal * (obj_ai_decision_making.percentageOfDamageToTargetCurrentHPForLightRangedEngineStartWeight * 2);
						instance_to_reference_.lightRangedEngineTotalWeight = (instance_to_reference_.targetCurrentHPPercentForLightRangedEngineTotalWeight + instance_to_reference_.targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight + instance_to_reference_.selfCurrentHPPercentForLightRangedEngineTotalWeight + instance_to_reference_.objectProximityToTargetForLightRangedEngineTotalWeight + instance_to_reference_.totalEnemiesInBattleForLightRangedEngineTotalWeight + instance_to_reference_.percentageOfDamageToTargetCurrentHPForLightRangedEngineTotalWeight) * instance_to_reference_.lightRangedEngineWeightMultiplier;
					}
					#endregion
					#region FOR HEALERS ONLY - Heal Ally
					if instance_to_reference_.objectArchetype == "Healer" {
						if (ds_exists(validObjectIDsInBattle, ds_type_list)) || (ds_exists(validObjectIDsInLineOfSight, ds_type_list)) || ((playerIsAValidHealTarget || playerIsAValidHealTargetInLineOfSight) && instance_to_reference_.combatFriendlyStatus == "Minion") {
							var temporary_instance_to_reference_current_hp_, temporary_instance_to_reference_max_hp_, temporary_instance_to_reference_is_lowest_hp_;
							temporary_instance_to_reference_current_hp_ = 0;
							temporary_instance_to_reference_max_hp_ = 0;
							temporary_instance_to_reference_is_lowest_hp_ = noone;
							if instance_to_reference_.combatFriendlyStatus == "Enemy" {
								if ds_exists(validObjectIDsInBattle, ds_type_list) {
									for (j = 0; j <= ds_list_size(validObjectIDsInBattle) - 1; j++) {
										temporary_instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, j);
										if instance_exists(temporary_instance_to_reference_) {
											if temporary_instance_to_reference_.combatFriendlyStatus == "Enemy" {
												temporary_instance_to_reference_current_hp_ += temporary_instance_to_reference_.enemyCurrentHP;
												temporary_instance_to_reference_max_hp_ += temporary_instance_to_reference_.enemyMaxHP;
												if temporary_instance_to_reference_is_lowest_hp_ == noone {
													temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
												}
												else if instance_exists(temporary_instance_to_reference_is_lowest_hp_) {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (temporary_instance_to_reference_is_lowest_hp_.enemyCurrentHP / temporary_instance_to_reference_is_lowest_hp_.enemyMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
											}
										}
									}
								}
								else if ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
									for (j = 0; j <= ds_list_size(validObjectIDsInLineOfSight) - 1; j++) {
										temporary_instance_to_reference_ = ds_list_find_value(validObjectIDsInLineOfSight, j);
										if instance_exists(temporary_instance_to_reference_) {
											if temporary_instance_to_reference_.combatFriendlyStatus == "Enemy" {
												temporary_instance_to_reference_current_hp_ += temporary_instance_to_reference_.enemyCurrentHP;
												temporary_instance_to_reference_max_hp_ += temporary_instance_to_reference_.enemyMaxHP;
												if temporary_instance_to_reference_is_lowest_hp_ == noone {
													temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
												}
												else if instance_exists(temporary_instance_to_reference_is_lowest_hp_) {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (temporary_instance_to_reference_is_lowest_hp_.enemyCurrentHP / temporary_instance_to_reference_is_lowest_hp_.enemyMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
											}
										}
									}
								}
							}
							else if instance_to_reference_.combatFriendlyStatus == "Minion" {
								temporary_instance_to_reference_current_hp_ += playerCurrentHP;
								temporary_instance_to_reference_max_hp_ += playerMaxHP;
								temporary_instance_to_reference_is_lowest_hp_ = obj_player.id;
								if ds_exists(validObjectIDsInBattle, ds_type_list) {
									// If the player isn't a valid heal target, then revert the instance to heal to the first entry in the validObjectIDsInBattle
									// ds_list, and compare all the other entries against that one.
									if !playerIsAValidHealTarget {
										var first_entry_instance_ = ds_list_find_value(validObjectIDsInBattle, 0);
										temporary_instance_to_reference_current_hp_ += first_entry_instance_.enemyCurrentHP;
										temporary_instance_to_reference_max_hp_ += first_entry_instance_.enemyMaxHP;
										temporary_instance_to_reference_is_lowest_hp_ = first_entry_instance_;
									}
									for (j = 0; j <= ds_list_size(validObjectIDsInBattle) - 1; j++) {
										temporary_instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, j);
										if instance_exists(temporary_instance_to_reference_) {
											if temporary_instance_to_reference_.combatFriendlyStatus == "Minion" {
												temporary_instance_to_reference_current_hp_ += temporary_instance_to_reference_.enemyCurrentHP;
												temporary_instance_to_reference_max_hp_ += temporary_instance_to_reference_.enemyMaxHP;
												if temporary_instance_to_reference_is_lowest_hp_ == obj_player.id {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (playerCurrentHP / playerMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
												else if instance_exists(temporary_instance_to_reference_is_lowest_hp_) {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (temporary_instance_to_reference_is_lowest_hp_.enemyCurrentHP / temporary_instance_to_reference_is_lowest_hp_.enemyMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
											}
										}
									}
								}
								else if ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
									// If the player isn't a valid heal target, then revert the instance to heal to the first entry in the validObjectIDsInLineOfSight
									// ds_list, and compare all the other entries against that one.
									if !playerIsAValidHealTargetInLineOfSight {
										var first_entry_instance_ = ds_list_find_value(validObjectIDsInLineOfSight, 0);
										temporary_instance_to_reference_current_hp_ += first_entry_instance_.enemyCurrentHP;
										temporary_instance_to_reference_max_hp_ += first_entry_instance_.enemyMaxHP;
										temporary_instance_to_reference_is_lowest_hp_ = first_entry_instance_;
									}
									for (j = 0; j <= ds_list_size(validObjectIDsInLineOfSight) - 1; j++) {
										temporary_instance_to_reference_ = ds_list_find_value(validObjectIDsInLineOfSight, j);
										if instance_exists(temporary_instance_to_reference_) {
											if temporary_instance_to_reference_.combatFriendlyStatus == "Minion" {
												temporary_instance_to_reference_current_hp_ += temporary_instance_to_reference_.enemyCurrentHP;
												temporary_instance_to_reference_max_hp_ += temporary_instance_to_reference_.enemyMaxHP;
												if temporary_instance_to_reference_is_lowest_hp_ == obj_player.id {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (playerCurrentHP / playerMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
												else if instance_exists(temporary_instance_to_reference_is_lowest_hp_) {
													if (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) < (temporary_instance_to_reference_is_lowest_hp_.enemyCurrentHP / temporary_instance_to_reference_is_lowest_hp_.enemyMaxHP) {
														temporary_instance_to_reference_is_lowest_hp_ = temporary_instance_to_reference_;
													}
												}
											}
										}
									}
								}
							}
							instance_to_reference_.cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineTotalWeight = (obj_ai_decision_making.cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineStartWeight * 2) - ((temporary_instance_to_reference_current_hp_ / temporary_instance_to_reference_max_hp_) * (obj_ai_decision_making.cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineStartWeight * 2));
							if temporary_instance_to_reference_is_lowest_hp_ != obj_player.id {
								if instance_exists(temporary_instance_to_reference_is_lowest_hp_) {
									switch (temporary_instance_to_reference_is_lowest_hp_.objectArchetype) {
										case "Healer": instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = obj_ai_decision_making.archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight * 2.0;
											break;
										case "Tank": instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = obj_ai_decision_making.archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight * 1.5;
											break;
										case "Melee DPS": instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = obj_ai_decision_making.archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight * 0.5;
											break;
										case "Ranged DPS": instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = obj_ai_decision_making.archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight * 1.0;
											break;
									}
									instance_to_reference_.currentHPPercentOfLowestHPAllyForHealAllyEngineTotalWeight = (obj_ai_decision_making.currentHPPercentOfLowestHPAllyForHealAllyEngineStartWeight * 2) - ((temporary_instance_to_reference_is_lowest_hp_.enemyCurrentHP / temporary_instance_to_reference_is_lowest_hp_.enemyMaxHP) * (obj_ai_decision_making.currentHPPercentOfLowestHPAllyForHealAllyEngineStartWeight * 2));
								}
							}
							else {
								instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = obj_ai_decision_making.archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight * 0.75;
								instance_to_reference_.currentHPPercentOfLowestHPAllyForHealAllyEngineTotalWeight = (obj_ai_decision_making.currentHPPercentOfLowestHPAllyForHealAllyEngineStartWeight * 2) - ((playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.currentHPPercentOfLowestHPAllyForHealAllyEngineStartWeight * 2));
							}
							if instance_exists(instance_to_reference_.currentTargetToFocus) {
								temporary_instance_to_reference_ = instance_to_reference_.currentTargetToFocus;
								if temporary_instance_to_reference_ != obj_player.id {
									instance_to_reference_.targetCurrentHPPercentForHealAllyEngineTotalWeight = (temporary_instance_to_reference_.enemyCurrentHP / temporary_instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForHealAllyEngineStartWeight * 2);
								}
								else {
									instance_to_reference_.targetCurrentHPPercentForHealAllyEngineTotalWeight = (playerCurrentHP / playerMaxHP) * (obj_ai_decision_making.targetCurrentHPPercentForHealAllyEngineStartWeight * 2);
								}
							}
							if instance_to_reference_ == "Enemy" {
								instance_to_reference_.totalEnemiesInBattleForHealAllyEngineTotalWeight = ((1 + friendlyHealersInBattle + friendlyTanksInBattle + friendlyMeleeDPSInBattle + friendlyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHealAllyEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHealAllyEngineStartWeight);
							}
							else if instance_to_reference_ == "Minion" {
								instance_to_reference_.totalEnemiesInBattleForHealAllyEngineTotalWeight = ((enemyHealersInBattle + enemyTanksInBattle + enemyMeleeDPSInBattle + enemyRangedDPSInBattle) / obj_ai_decision_making.idealAmountOfTotalEnemiesInBattleForHealAllyEngine) * (obj_ai_decision_making.totalEnemiesInBattleForHealAllyEngineStartWeight);
							}
							instance_to_reference_.selfCurrentHPPercentForHealAllyEngineTotalWeight = (instance_to_reference_.enemyCurrentHP / instance_to_reference_.enemyMaxHP) * (obj_ai_decision_making.selfCurrentHPPercentForHealAllyEngineStartWeight * 2);
							if instance_to_reference_.healAllyEngineTimer <= 0 {
								instance_to_reference_.healAllyEngineTotalWeight = (instance_to_reference_.cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineTotalWeight + instance_to_reference_.archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight + instance_to_reference_.currentHPPercentOfLowestHPAllyForHealAllyEngineTotalWeight + instance_to_reference_.targetCurrentHPPercentForHealAllyEngineTotalWeight + instance_to_reference_.totalEnemiesInBattleForHealAllyEngineTotalWeight + instance_to_reference_.selfCurrentHPPercentForHealAllyEngineTotalWeight) * instance_to_reference_.healAllyEngineWeightMultiplier;
							}
							else {
								instance_to_reference_.healAllyEngineTotalWeight = 0;
							}
						}
					}
					#endregion
				}
			//}
		//}
	}
	#endregion
	
	
	#region Setting Final Decision Weight based on Each Individual Engine Weight
	if (ds_exists(validObjectIDsInBattle, ds_type_list)) || (ds_exists(validObjectIDsInLineOfSight, ds_type_list)) || ((playerIsAValidFocusTarget || playerIsAValidFocusTargetInLineOfSight) && combatFriendlyStatus == "Enemy") || ((playerIsAValidHealTarget || playerIsAValidHealTargetInLineOfSight) && combatFriendlyStatus == "Minion") {
		//for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
			//if instance_exists(ds_list_find_value(validObjectIDsInBattle, i)) {
				//var instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, i);
				var instance_to_reference_ = self;
				if instance_to_reference_.objectArchetype != "Healer" {
					// Before setting the choice to take, I make sure the action can be taken, and if not, then I
					// move down the list of actions until I run out of actions to take.
					if ds_exists(validObjectIDsInBattle, ds_type_list) {
						if (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Heavy Melee";
						}
						else if (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Light Melee";
						}
						else if (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Heavy Ranged";
						}
						else if (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Light Ranged";
						}
					}
					else if heavyRangedCanBeUsedAcrossChasm {
						instance_to_reference_.chosenEngine = "Heavy Ranged";
					}
					else if lightRangedCanBeUsedAcrossChasm {
						instance_to_reference_.chosenEngine = "Light Ranged";
					}
					else {
						instance_to_reference_.chosenEngine = "";
						instance_to_reference_.currentTargetToFocus = noone;
						instance_to_reference_.currentTargetToHeal = noone;
					}
				}
				else if instance_to_reference_.objectArchetype == "Healer" {
					// First, set the target to healing the player in case the heal target did not previously exist but
					// the player is currently a valid target.
					if !instance_exists(currentTargetToHeal) {
						if playerIsAValidHealTarget || playerIsAValidHealTargetInLineOfSight {
							currentTargetToHeal = obj_player.id;
						}
					}
					if ds_exists(validObjectIDsInBattle, ds_type_list) {
						if (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) && (instance_to_reference_.heavyMeleeEngineTotalWeight > instance_to_reference_.healAllyEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Heavy Melee";
						}
						else if (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) && (instance_to_reference_.lightMeleeEngineTotalWeight > instance_to_reference_.healAllyEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Light Melee";
						}
						else if (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) && (instance_to_reference_.heavyRangedEngineTotalWeight > instance_to_reference_.healAllyEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Heavy Ranged";
						}
						else if (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.lightRangedEngineTotalWeight > instance_to_reference_.healAllyEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Light Ranged";
						}
						else if (instance_to_reference_.healAllyEngineTotalWeight > instance_to_reference_.heavyMeleeEngineTotalWeight) && (instance_to_reference_.healAllyEngineTotalWeight > instance_to_reference_.lightMeleeEngineTotalWeight) && (instance_to_reference_.healAllyEngineTotalWeight > instance_to_reference_.heavyRangedEngineTotalWeight) && (instance_to_reference_.healAllyEngineTotalWeight > instance_to_reference_.lightRangedEngineTotalWeight) {
							instance_to_reference_.chosenEngine = "Heal Ally";
						}
					}
					// Heals can always be used across chasms so I don't check to see if it can be used across the chasm.
					else if instance_exists(currentTargetToHeal) {
						instance_to_reference_.chosenEngine = "Heal Ally";
					}
					else if heavyRangedCanBeUsedAcrossChasm && instance_exists(currentTargetToFocus) {
						instance_to_reference_.chosenEngine = "Heavy Ranged";
					}
					else if lightRangedCanBeUsedAcrossChasm && instance_exists(currentTargetToFocus) {
						instance_to_reference_.chosenEngine = "Light Ranged";
					}
					else {
						instance_to_reference_.chosenEngine = "";
						instance_to_reference_.currentTargetToFocus = noone;
						instance_to_reference_.currentTargetToHeal = noone;
					}
				}
			//}
		//}		
	}
	// Else if, by now not a single available target exists for the action at hand, then reset values and
	// try again some other time.
	else {
		chosenEngine = "";
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
	}
	#endregion
}


