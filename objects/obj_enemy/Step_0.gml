/// @description Change Variables
// Initialize variables if stats, sprite table, and scripts using have not yet been set
if !enemyStatsAndSpritesInitialized {
	scr_initialize_enemy_stats(enemyName);
	enemyStatsAndSpritesInitialized = true;
}

// Set the total composite speed for each individual enemy
enemyTotalSpeed = (enemyGameSpeed + userInterfaceGameSpeed) / 2;

// Set the max movement speed for each individual enemy
maxSpeed = baseMaxSpeed * enemyTotalSpeed;

tetherXRange = camera_get_view_width(view_camera[0]) * 2;
tetherYRange = camera_get_view_height(view_camera[0]) * 2;


#region Variables Changed by obj_ai_decision_making to Control Each Enemy
if attackPatternStartWeight != obj_ai_decision_making.attackPatternStartWeight {
	attackPatternStartWeight = obj_ai_decision_making.attackPatternStartWeight;
	switch (objectArchetype) {
		case "Healer": enemyAttackPatternWeight = attackPatternStartWeight * (1 / 4);
			targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier = 1.0;
			heavyMeleeEngineWeightMultiplier = 0.7;
			lightMeleeEngineWeightMultiplier = 0.7;
			heavyRangedEngineWeightMultiplier = 0.9;
			lightRangedEngineWeightMultiplier = 1.0;
			runAwayEngineWeightMultiplier = 0.6;
			healAllyEngineWeightMultiplier = 1.3;
			break;
		case "Tank": enemyAttackPatternWeight = attackPatternStartWeight * (3 / 2);
			targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier = 1.3;
			heavyMeleeEngineWeightMultiplier = 1.3;
			lightMeleeEngineWeightMultiplier = 1.2;
			heavyRangedEngineWeightMultiplier = 1.1;
			lightRangedEngineWeightMultiplier = 0.9;
			runAwayEngineWeightMultiplier = 0.8;
			healAllyEngineWeightMultiplier = 0.00;
			break;
		case "Ranged DPS": enemyAttackPatternWeight = attackPatternStartWeight * (1 / 2);
			targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier = 1.1;
			heavyMeleeEngineWeightMultiplier = 0.7;
			lightMeleeEngineWeightMultiplier = 0.8;
			heavyRangedEngineWeightMultiplier = 1.2;
			lightRangedEngineWeightMultiplier = 1.3;
			runAwayEngineWeightMultiplier = 0.6;
			healAllyEngineWeightMultiplier = 0.00;
			break;
		case "Melee DPS": enemyAttackPatternWeight = attackPatternStartWeight * (7 / 4);
			targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightMultiplier = 0.9;
			heavyMeleeEngineWeightMultiplier = 1.2;
			lightMeleeEngineWeightMultiplier = 1.3;
			heavyRangedEngineWeightMultiplier = 0.7;
			lightRangedEngineWeightMultiplier = 0.8;
			runAwayEngineWeightMultiplier = 0.6;
			healAllyEngineWeightMultiplier = 0.00;
			break;
	}
}

var instance_to_reference_, j;
// Detect whether enemies are within player's field of view
if (rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (tetherYRange / 2), (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (tetherYRange / 2))) {
	// If there are already other enemies within player's field of view
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
			for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
				instance_to_reference_.decisionMadeForTargetAndAction = false;
			}
			// Add this object's ID to the list of objects in battle (objectIDsInBattle)
			ds_list_add(objectIDsInBattle, self);
			/*
			The next if/else statement checks for the combatFriendlyStatus (whether the object is an enemy
			or friend to the player) and then adjusts the correct variable depending on the object's 
			objectArchetype (what kind of role the enemy fills).
			*/
			if combatFriendlyStatus == "Enemy" {
				switch (objectArchetype) {
					case "Healer": enemyHealersInBattle += 1;
						break;
					case "Tank": enemyTanksInBattle += 1;
						break;
					case "Melee DPS": enemyMeleeDPSInBattle += 1;
						break;
					case "Ranged DPS": enemyRangedDPSInBattle += 1;
						break;
				}
			}
			else if combatFriendlyStatus == "Minion" {
				switch (objectArchetype) {
					case "Healer": friendlyHealersInBattle += 1;
						break;
					case "Tank": friendlyTanksInBattle += 1;
						break;
					case "Melee DPS": friendlyMeleeDPSInBattle += 1;
						break;
					case "Ranged DPS": friendlyRangedDPSInBattle += 1;
						break;
				}
			}
		}
	}
	// If this is the first enemy to enter player's field of view
	else {
		/*
		As long as the enemy in the player's view is an enemy, start up the combat list (objectIDsInBattle)
		---We don't do this for minions because if JUST a minion is in view, that doesn't mean the player is
		in combat, it just means the player has minions following.
		*/
		if combatFriendlyStatus == "Enemy" {
			decisionMadeForTargetAndAction = false;
			objectIDsInBattle = ds_list_create();
			ds_list_add(objectIDsInBattle, self);
			switch (objectArchetype) {
				case "Healer": enemyHealersInBattle += 1;
					currentTargetToHeal = noone;
					break;
				case "Tank": enemyTanksInBattle += 1;
					break;
				case "Melee DPS": enemyMeleeDPSInBattle += 1;
					break;
				case "Ranged DPS": enemyRangedDPSInBattle += 1;
					break;
			}
		}
	}
}

// If the enemy object is destroyed or it leaves the screen, remove it from the objects in combat
if (self.enemyCurrentHP <= 0) || !(rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (tetherYRange / 2), (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (tetherYRange / 2))) {
	currentTargetToFocus = noone;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	if ds_exists(objectIDsInBattle, ds_type_list) {
		if (ds_list_find_index(objectIDsInBattle, self) != -1) {
			for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
				instance_to_reference_.decisionMadeForTargetAndAction = false;
			}
			ds_list_delete(objectIDsInBattle, ds_list_find_index(objectIDsInBattle, self));
			if combatFriendlyStatus == "Enemy" {
				switch (objectArchetype) {
					case "Healer": enemyHealersInBattle -= 1;
						currentTargetToHeal = noone;
						break;
					case "Tank": enemyTanksInBattle -= 1;
						break;
					case "Melee DPS": enemyMeleeDPSInBattle -= 1;
						break;
					case "Ranged DPS": enemyRangedDPSInBattle -= 1;
						break;
				}
			}
			else if combatFriendlyStatus == "Minion" {
				switch (objectArchetype) {
					case "Healer": friendlyHealersInBattle -= 1;
						currentTargetToHeal = noone;
						break;
					case "Tank": friendlyTanksInBattle -= 1;
						break;
					case "Melee DPS": friendlyMeleeDPSInBattle -= 1;
						break;
					case "Ranged DPS": friendlyRangedDPSInBattle -= 1;
						break;
				}
			}
		}
	}
}
if variable_global_exists("objectIDsInBattle") {
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
}
// Remove specifically the targets of those targeting other objects out of tether range
if instance_exists(currentTargetToFocus) {
	if !(rectangle_in_rectangle(currentTargetToFocus.bbox_left, currentTargetToFocus.bbox_top, currentTargetToFocus.bbox_right, currentTargetToFocus.bbox_bottom, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (tetherYRange / 2), (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (tetherYRange / 2))) {
		currentTargetToFocus = noone;
	}
}


/// Set percentage values for various variables based on self damage values and currentTargetToFocus
if instance_exists(obj_player) {
	selfCurrentHPPercent = enemyCurrentHP / enemyMaxHP;
	if instance_exists(currentTargetToFocus) {
		objectProximityToTarget = point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y);
		if currentTargetToFocus != obj_player.id {
			// Current HP - See create event for details
			percentageOfDamageToTargetCurrentHPHeavyMeleeAttackWillDeal = enemyHeavyMeleeAttackDamage / currentTargetToFocus.enemyCurrentHP;
			percentageOfDamageToTargetCurrentHPLightMeleeAttackWillDeal = enemyLightMeleeAttackDamage / currentTargetToFocus.enemyCurrentHP;
			percentageOfDamageToTargetCurrentHPHeavyRangedAttackWillDeal = enemyHeavyRangedAttackDamage / currentTargetToFocus.enemyCurrentHP;
			percentageOfDamageToTargetCurrentHPLightRangedAttackWillDeal = enemyLightRangedAttackDamage / currentTargetToFocus.enemyCurrentHP;
			// Total HP - See create event for details
			percentageOfDamageToTargetTotalHPHeavyMeleeAttackWillDeal = enemyHeavyMeleeAttackDamage / currentTargetToFocus.enemyMaxHP;
			percentageOfDamageToTargetTotalHPLightMeleeAttackWillDeal = enemyLightMeleeAttackDamage / currentTargetToFocus.enemyMaxHP;
			percentageOfDamageToTargetTotalHPHeavyRangedAttackWillDeal = enemyHeavyRangedAttackDamage / currentTargetToFocus.enemyMaxHP;
			percentageOfDamageToTargetTotalHPLightRangedAttackWillDeal = enemyLightRangedAttackDamage / currentTargetToFocus.enemyMaxHP;
		}
		else {
			percentageOfDamageToTargetCurrentHPHeavyMeleeAttackWillDeal = enemyHeavyMeleeAttackDamage / playerCurrentHP;
			percentageOfDamageToTargetCurrentHPLightMeleeAttackWillDeal = enemyLightMeleeAttackDamage / playerCurrentHP;
			percentageOfDamageToTargetCurrentHPHeavyRangedAttackWillDeal = enemyHeavyRangedAttackDamage / playerCurrentHP;
			percentageOfDamageToTargetCurrentHPLightRangedAttackWillDeal = enemyLightRangedAttackDamage / playerCurrentHP;
			// Total HP - See create event for details
			percentageOfDamageToTargetTotalHPHeavyMeleeAttackWillDeal = enemyHeavyMeleeAttackDamage / playerMaxHP;
			percentageOfDamageToTargetTotalHPLightMeleeAttackWillDeal = enemyLightMeleeAttackDamage / playerMaxHP;
			percentageOfDamageToTargetTotalHPHeavyRangedAttackWillDeal = enemyHeavyRangedAttackDamage / playerMaxHP;
			percentageOfDamageToTargetTotalHPLightRangedAttackWillDeal = enemyLightRangedAttackDamage / playerMaxHP;
		}
		// Total Allies for this Object that are in Combat
		enemyTotalAlliesInBattle = 0;
		minionTotalAlliesInBattle = 0;
		// here I set minionTotalAlliesInBattle and enemyTotalAlliesInBattle
		if ds_exists(objectIDsInBattle, ds_type_list) {
			var i, temporary_instance_to_reference_;
			if combatFriendlyStatus == "Enemy" {
				i = 0;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					temporary_instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(temporary_instance_to_reference_) {
						if (temporary_instance_to_reference_.combatFriendlyStatus == "Enemy") && (temporary_instance_to_reference_ != self) {
							enemyTotalAlliesInBattle += 1;
						}
					}
				}
			}
			else if combatFriendlyStatus == "Minion" {
				i = 0;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					temporary_instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(temporary_instance_to_reference_) {
						if (temporary_instance_to_reference_.combatFriendlyStatus == "Minion") && (temporary_instance_to_reference_ != self) {
							minionTotalAlliesInBattle += 1;
						}
					}
				}
			}
		}
		// here I set targetOfTargetCurrentHP
		if currentTargetToFocus != obj_player.id {
			var target_of_target_;
			target_of_target_ = currentTargetToFocus.currentTargetToFocus;
			if instance_exists(target_of_target_) {
				if target_of_target_ != obj_player.id {
					targetOfTargetCurrentHP = target_of_target_.enemyCurrentHP / target_of_target_.enemyMaxHP;
				}
				else {
					targetOfTargetCurrentHP = playerCurrentHP / playerMaxHP;
				}
			}
			else {
				targetOfTargetCurrentHP = -1;
			}
		}
		else {
			if instance_exists(lastEnemyHitByPlayer) {
				var target_of_target_ = lastEnemyHitByPlayer;
				targetOfTargetCurrentHP = target_of_target_.enemyCurrentHP / target_of_target_.enemyMaxHP;
			}
			else {
				targetOfTargetCurrentHP = -1;
			}
		}
		// here I set targetCurrentPercentageOfStaminaAndMana
		// Since targetCurrentPercentageOfStaminaAndMana is a scale between 0 to 2, multiply this value
		// directly against the weight (since the weights can range from 0 to weight*2)
		if currentTargetToFocus != obj_player.id {
			targetCurrentPercentageOfStaminaAndMana = (currentTargetToFocus.enemyCurrentStamina / currentTargetToFocus.enemyMaxStamina) + (currentTargetToFocus.enemyCurrentMana / currentTargetToFocus.enemyMaxMana);
		}
		else {
			targetCurrentPercentageOfStaminaAndMana = (playerCurrentStamina / playerMaxStamina) + (playerCurrentMana / playerMaxMana);
		}
	}
}
#endregion

// Change and track all HP, Stamina, and Mana stats for the enemy
scr_track_enemy_stats();


// Make sure being hit multiple times by the same hitbox is not possible
if !instance_exists(alreadyHit) {
	alreadyHit = -1;
}
if alreadyHitTimer >= 0 {
	alreadyHitTimer -= 1;
}
if alreadyTriedToChaseTimer > 0 {
	alreadyTriedToChase -= 1;
}

// Script used to set the direction the object will face every frame
scr_determine_direction_facing();

// Switch statement for State Machine - Called through script
scr_change_states(enemyName);


// Set the image index
if enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) {
	enemyImageIndex = -1;
}
if enemyAnimationImageIndex >= sprite_get_number(enemyAnimationSprite) {
	enemyAnimationImageIndex = -1;
}
enemyImageIndexSpeed = 0.3 * enemyTotalSpeed;
enemyImageIndex += enemyImageIndexSpeed;
enemyAnimationImageIndex += enemyImageIndexSpeed;
// This line below is only used for debugging/prototyping/testing purposes.
// In the future, this line will be removed, and a series of lines of code in the draw event 
// (not draw gui) as seen immediately below will be used to draw the enemy with their armor on, using 
// enemyImageIndex to set sprite_index for each drawn item.
//
// draw_sprite_ext(enemyHeadSprite[enemyStateSprite, enemyDirectionFacing], enemyImageIndex, x, y, 1, 1, 0, c_white, 1);
//
// The line above is an example of using a sprite table for each different armor type to draw the armor
// that the player has equipped.
image_index = enemyImageIndex;


// Hurtbox and Ground Hurtbox Sprite Setting and Location Setting - must be done after obj_enemy
// sprites and locations have changed so that the hurtboxes don't lag a frame behind the obj_enemy
if instance_exists(self) {
	if instance_exists(enemyHurtbox) {
		enemyHurtbox.x = x;
		enemyHurtbox.y = y;
		enemyHurtbox.sprite_index = enemySprite[enemyStateSprite, enemyDirectionFacing];
	}
	if instance_exists(enemyGroundHurtbox) {
		enemyGroundHurtbox.x = x;
		enemyGroundHurtbox.y = y + 13;
	}
}


/*
show_debug_message("For " + string(self.id) + " these are the following weights for heavy melee attack:");
show_debug_message(string(selfCurrentHPPercentForHeavyMeleeEngineTotalWeight) + " = selfCurrentHPPercentForHeavyMeleeEngineTotalWeight");
show_debug_message(string(targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineTotalWeight) + " = targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineTotalWeight");
show_debug_message(string(targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight) + " = targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight");
show_debug_message(string(objectProximityToTargetForHeavyMeleeEngineTotalWeight) + " = objectProximityToTargetForHeavyMeleeEngineTotalWeight");
show_debug_message(string(percentageOfDamageToTargetTotalHPForHeavyMeleeEngineTotalWeight) + " = percentageOfDamageToTargetTotalHPForHeavyMeleeEngineTotalWeight");
show_debug_message(string(totalEnemiesInBattleForHeavyMeleeEngineTotalWeight) + " = totalEnemiesInBattleForHeavyMeleeEngineTotalWeight");
show_debug_message("Total Heavy Melee Engine Weight AFTER Multiplier = " + string(heavyMeleeEngineTotalWeight));
show_debug_message("- BREAK -");
show_debug_message("And for light melee attack: ")
show_debug_message("For " + string(self.id) + " these are the following weights:" );
show_debug_message(string(selfCurrentHPPercentForLightMeleeEngineTotalWeight) + " = selfCurrentHPPercentForLightMeleeEngineTotalWeight");
show_debug_message(string(targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineTotalWeight) + " = targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineTotalWeight");
show_debug_message(string(targetOfTargetCurrentHPForLightMeleeEngineTotalWeight) + " = targetOfTargetCurrentHPForLightMeleeEngineTotalWeight");
show_debug_message(string(objectProximityToTargetForLightMeleeEngineTotalWeight) + " = objectProximityToTargetForLightMeleeEngineTotalWeight");
show_debug_message(string(percentageOfDamageToTargetCurrentHPForLightMeleeEngineTotalWeight) + " = percentageOfDamageToTargetCurrentHPForLightMeleeEngineTotalWeight");
show_debug_message(string(totalEnemiesInBattleForLightMeleeEngineTotalWeight) + " = totalEnemiesInBattleForLightMeleeEngineTotalWeight");
show_debug_message("Total Light Melee Engine Weight AFTER Multiplier = " + string(lightMeleeEngineTotalWeight));
show_debug_message("- BREAK -");
show_debug_message("And for heavy ranged attack: ");
show_debug_message("For " + string(self.id) + " these are the following weights:");
show_debug_message(string(targetCurrentHPPercentForHeavyRangedEngineTotalWeight) + " = targetCurrentHPPercentForHeavyRangedEngineTotalWeight");
show_debug_message(string(targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight) + " = targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight");
show_debug_message(string(selfCurrentHPPercentForHeavyRangedEngineTotalWeight) + " = selfCurrentHPPercentForHeavyRangedEngineTotalWeight");
show_debug_message(string(objectProximityToTargetForHeavyRangedEngineTotalWeight) + " = objectProximityToTargetForHeavyRangedEngineTotalWeight");
show_debug_message(string(totalEnemiesInBattleForHeavyRangedEngineTotalWeight) + " = totalEnemiesInBattleForHeavyRangedEngineTotalWeight");
show_debug_message(string(percentageOfDamageToTargetTotalHPForHeavyRangedEngineTotalWeight) + " = percentageOfDamageToTargetTotalHPForHeavyRangedEngineTotalWeight");
show_debug_message("Total Heavy Ranged Engine Weight AFTER Multiplier = " + string(heavyRangedEngineTotalWeight));
show_debug_message("- BREAK -");
show_debug_message("And for light ranged attack: ");
show_debug_message("For " + string(self.id) + " these are the following weights:");
show_debug_message(string(targetCurrentHPPercentForLightRangedEngineTotalWeight) + " = targetCurrentHPPercentForLightRangedEngineTotalWeight");
show_debug_message(string(targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight) + " = targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight");
show_debug_message(string(selfCurrentHPPercentForLightRangedEngineTotalWeight) + " = selfCurrentHPPercentForLightRangedEngineTotalWeight");
show_debug_message(string(objectProximityToTargetForLightRangedEngineTotalWeight) + " = objectProximityToTargetForLightRangedEngineTotalWeight");
show_debug_message(string(totalEnemiesInBattleForLightRangedEngineTotalWeight) + " = totalEnemiesInBattleForLightRangedEngineTotalWeight");
show_debug_message(string(percentageOfDamageToTargetCurrentHPForLightRangedEngineTotalWeight) + " = percentageOfDamageToTargetCurrentHPForLightRangedEngineTotalWeight");
show_debug_message("Total Light Ranged Engine Weight AFTER Multiplier = " + string(lightRangedEngineTotalWeight));
show_debug_message("- BREAK -");
show_debug_message("And for run away: ");
show_debug_message("For " + string(self.id) + " these are the following weights:");
show_debug_message(string(selfCurrentHPPercentForRunAwayEngineTotalWeight) + "selfCurrentHPPercentForRunAwayEngineTotalWeight");
show_debug_message(string(objectProximityToTargetForRunAwayEngineTotalWeight) + "objectProximityToTargetForRunAwayEngineTotalWeight");
show_debug_message(string(targetCurrentHPPercentForRunAwayEngineTotalWeight) + "targetCurrentHPPercentForRunAwayEngineTotalWeight");
show_debug_message(string(targetIsDifferentArchetypesForRunAwayEngineTotalWeight) + "targetIsDifferentArchetypesForRunAwayEngineTotalWeight");
show_debug_message(string(totalEnemiesInBattleForRunAwayEngineTotalWeight) + "totalEnemiesInBattleForRunAwayEngineTotalWeight");
show_debug_message("Total Run Away Engine Weight AFTER Multiplier" + string(runAwayEngineTotalWeight));
show_debug_message("- BREAK -");
show_debug_message("- BREAK -");
show_debug_message("");



