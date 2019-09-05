///@description Change and Manage Stats
#region Enemy Total Speed
// Total Speed for Enemy
if !obj_combat_controller.levelPaused && !obj_combat_controller.gamePaused {
	enemyTotalSpeed = (enemyGameSpeed + userInterfaceGameSpeed) / 2;
}
else {
	enemyTotalSpeed = 0;
}
if enemyTotalSpeed < 0 {
	enemyTotalSpeed = 0;
}
#endregion


#region Track Basic Stats - HP, Stamina, and Mana
// Base Stat Regenerations
if enemyHPRegeneration != 0 {
	enemyCurrentHP += ((enemyHPRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier);
}
if enemyStaminaRegeneration != 0 {
	enemyCurrentStamina += ((enemyStaminaRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier) * dinnerIsServedEnemyStaminaRegenerationMultiplier * solidifyEnemyStaminaRegenerationMultiplier;
}
if enemyManaRegeneration != 0 {
	enemyCurrentMana += ((enemyManaRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier) * dinnerIsServedEnemyManaRegenerationMultiplier * solidifyEnemyManaRegenerationMultiplier;
}

// Make sure current stat values do not exceed max stat values
if enemyCurrentHP > enemyMaxHP {
	enemyCurrentHP = enemyMaxHP;
}
if enemyCurrentStamina > enemyMaxStamina {
	enemyCurrentStamina = enemyMaxStamina;
}
if enemyCurrentMana > enemyMaxMana {
	enemyCurrentMana = enemyMaxMana;
}
#endregion


#region Enemy Total Bonus Damages and Resistances
// Enemies' Bonus Damage and Resistance - 
enemyTotalBonusDamage = 1 * overwhelmingChainsDamageMultiplier; // * whatever bonus damages the enemy has
enemyTotalBonusResistance = 1 * angelicBarrageDamageMultiplier * trueCaelestiWingsDebuffDamageMultiplier * overwhelmingChainsDamageResistanceMultiplier; // * whatever bonus resistances the enemy has
#endregion


#region Stun and Hitstun Values
// Setting the stun values
/*
If stun timer is greater than 0, then the stun is active, which forces the state to be sent to stun state

We never actually set enemyState = enemystates.stunned except for in other scripts, because depending on the action
being taken, we'll need to reset/destroy certain variables
*/
if stunTimer > 0 {
	stunActive = true;
}
else {
	stunActive = false;
}
// If the stun timer is greater than 0, then count the timer down
if stunTimer > 0 {
	stunTimer--;
}
// If the stun is not active, set the multiplier to 1. Otherwise, set it to 0 which sets movement speed and resource regen to 0.
if !stunActive {
	stunMultiplier = 1;
}
else {
	stunMultiplier = 0;
}

// Setting the hitstun values, different than stun
// Set hitstun to be active or not
if hitstunTimer > 0 {
	hitstunActive = true;
}
else {
	hitstunActive = false;
}
// If the hitstun timer is greater than 0, then count the timer down
if hitstunTimer > 0 {
	hitstunTimer--;
}
// If the hitstun is not active, set it to default at 1. Otherwise, set it to 0 which sets movement speed, resource regen,
// and image speed to 0 for the duration.
if !hitstunActive {
	hitstunMultiplier = 1;
}
else {
	hitstunMultiplier = 0;
}
#endregion


#region Enemy Total Movement Speed
// Set Speed variables for enemies
maxSpeed = ((baseMaxSpeed * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier) * dinnerIsServedEnemyMovementSpeedMultiplier * bindingsOfTheCaelestiEnemyMovementSpeedMultiplier * wrathOfTheRepentantMovementSpeedMultiplier * solidifyEnemyMovementSpeedMultiplier;
acceleration = ((baseAcceleration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier) * dinnerIsServedEnemyMovementSpeedMultiplier * bindingsOfTheCaelestiEnemyMovementSpeedMultiplier * wrathOfTheRepentantMovementSpeedMultiplier * solidifyEnemyMovementSpeedMultiplier;
frictionAmount = ((baseFrictionAmount * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier) * dinnerIsServedEnemyMovementSpeedMultiplier * bindingsOfTheCaelestiEnemyMovementSpeedMultiplier * wrathOfTheRepentantMovementSpeedMultiplier * solidifyEnemyMovementSpeedMultiplier;
#endregion


#region Destroy Self
// If current HP drops below 0, destroy all variables that could cause a memory leak, then destroy the
// object
if enemyCurrentHP <= 0 {
	if variable_instance_exists(self, "myPath") {
		if !is_undefined(myPath) {
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
	}
	if overwhelmingChainsActiveOnSelf {
		obj_skill_tree.overwhelmingChainsActive = false;
		overwhelmingChainsActiveOnSelf = false;
		overwhelmingChainsDamageMultiplier = 1;
		overwhelmingChainsDamageResistanceMultiplier = 1;
	}
	// If the Final Parting debuff is active on the enemy, apply the final parting debuff to a new target
	// before the enemy dies.
	if finalPartingActive {
		var i, instance_to_reference_;
		var target_to_infect_ = noone;
		if ds_exists(objectIDsInBattle, ds_type_list) {
			// Search for and identify the next target, if applicable
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				// As long as the potential target is not itself, continue the search
				if ds_list_find_value(objectIDsInBattle, i) != self {
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					// If we haven't yet detected a new target, make this a potential new target
					if target_to_infect_ == noone {
						// As long as the combat friendly status is the same, meaning we're not infecting a
						// minion when an enemy dies, then set the new infect target as the currently
						// referenced object.
						if combatFriendlyStatus == instance_to_reference_.combatFriendlyStatus {
							target_to_infect_ = instance_to_reference_;
						}
					}
					// Else if we've already detected a target, but the currently referenced object is closer
					// to this object than the current target is to this object, then set the currently
					// referenced object as the new target.
					else if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < (point_distance(x, y, target_to_infect_.x, target_to_infect_.y)) {
						if combatFriendlyStatus == instance_to_reference_.combatFriendlyStatus {
							target_to_infect_ = instance_to_reference_;
						}
					}
				}
			}
		}
		// If a new target to infect exists, infect that target. The infection spreads at the same time
		// and tic time as it left off at. So, if only one tic remains before the buff falls off, then
		// the buff isn't refreshed and just the one tic finishes out.
		if instance_exists(target_to_infect_) {
			finalPartingNextTarget = target_to_infect_;
			target_to_infect_.finalPartingActive = true;
			target_to_infect_.finalPartingTicTimer = finalPartingTicTimer;
			target_to_infect_.finalPartingTimer = finalPartingTimer;
		}
	}
	if obj_skill_tree.allOutAttackActive {
		playerCurrentStamina += obj_skill_tree.allOutAttackStaminaBonusOnKill * playerMaxStamina;
		playerCurrentMana += obj_skill_tree.allOutAttackManaBonusOnKill * playerMaxMana;
	}
	if combatFriendlyStatus == "Enemy" {
		animecroPool += animecroRewardUponDeath;
		bloodMagicPool += 1;
	}
	// If Glinting Blade is active on the enemy, deactivate it. I don't want the Blade dropping in case
	// teleporting to that enemy then teleports the player into the body of an enemy.
	if glintingBladeActive {
		glintingBladeActive = false;
		glintingBladeTimer = -1;
		obj_skill_tree.glintingBladeActive = false;
		obj_skill_tree.glintingBladeTimer = -1;
		obj_skill_tree.glintingBladeAttachedToEnemy = noone;
		obj_skill_tree.glintingBladeXPos = 0;
		obj_skill_tree.glintingBladeYPos = 0;
	}
	
	// Delete the object from relevant lists and update combat tracking variables
	if ds_exists(objectIDsInBattle, ds_type_list) {
		if ds_list_find_index(objectIDsInBattle, self) != -1 {
			// Delete self from combat list
			ds_list_delete(objectIDsInBattle, ds_list_find_index(objectIDsInBattle, self));
			// Remove self from the count of various archetypes in battle
			if combatFriendlyStatus == "Enemy" {
				switch (objectArchetype) {
					case "Healer": enemyHealersInBattle--;
						break;
					case "Tank": enemyTanksInBattle--;
						break;
					case "Melee DPS": enemyMeleeDPSInBattle--;
						break;
					case "Ranged DPS": enemyRangedDPSInBattle--;
						break;
				}
			}
			else {
				switch (objectArchetype) {
					case "Healer": friendlyHealersInBattle--;
						break;
					case "Tank": friendlyTanksInBattle--;
						break;
					case "Melee DPS": friendlyMeleeDPSInBattle--;
						break;
					case "Ranged DPS": friendlyRangedDPSInBattle--;
						break;
				}
			}
		}
	}
	if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
		if ds_list_find_index(objectIDsFollowingPlayer, self) != -1 {
			ds_list_delete(objectIDsFollowingPlayer, ds_list_find_index(objectIDsFollowingPlayer, self));
		}
	}
	
	// Create the daed body right before the enemy dies
	var dead_body_ = instance_create_depth(x, y, depth, obj_dead_body);
	dead_body_.objectArchetype = objectArchetype;
	dead_body_.enemyName = enemyName;
	dead_body_.deadBodySprite = deadBodySprite;
	dead_body_.deadBodyResurrectionSprite = deadBodyResurrectionSprite;
	dead_body_.deadBodyImageIndex = 0;
	
	// Destroy self after all things pertaining to the obj_enemy have been taken care of
	instance_destroy(self);
	// Exit the script afterwards so that no single line of code after this runs
	exit;
}
#endregion


#region Count Down Timers for use Specifically in Decision Making
// As long as the enemies shouldn't "freeze" (cheating for the player here, to make things look smoother)
if !obj_skill_tree.wrathOfTheDiaboliActive {
	// Timer for spacing out heals, so healers can't spam heals
	if healAllyEngineTimer > 0 {
		healAllyEngineTimer -= 1 * enemyTotalSpeed;
	}

	if alreadyTriedToChaseTimer > 0 {
		alreadyTriedToChaseTimer -= 1 * enemyTotalSpeed * solidifyEnemyChaseTimerSpeedMultiplier;
	}

	// Timer for mana and stamina abilities, so that the enemy doesn't endlessly wait for resource
	// regeneration. Prevents stalling if player debuffs enemy regeneration.
	if enemyTimeUntilNextStaminaAbilityUsableTimer > 0 {
		enemyTimeUntilNextStaminaAbilityUsableTimer -= 1;
	}

	if enemyTimeUntilNextManaAbilityUsableTimer > 0 {
		enemyTimeUntilNextManaAbilityUsableTimer -= 1;
	}

	// Timer for limiting time between attacks. Prevents enemy spamming attack until it runs out of resources,
	// and also helps enemies not overwhelm player all at once with attacks, if they're located in a group.
	if enemyTimeUntilNextAttackUsableTimer >= 0 {
		enemyTimeUntilNextAttackUsableTimer -= 1;
	}
}
#endregion


// Script used to set the direction the object will face every frame
scr_determine_direction_facing();

// Switch statement for State Machine - Called through this script using the name of the enemy
scr_change_states(enemyName);


#region Move the enemy object if it needs to chase its target or the player
// Increase speed to max if the enemy needs to chase an object
if enemyState == enemystates.moveWithinAttackRange {
	if currentSpeed < maxSpeed {
		currentSpeed += acceleration * enemyTotalSpeed;
	}
	else {
		currentSpeed = maxSpeed;
	}
}
// Else if the enemy doesn't ened to chase an object, reduce its speed
else if currentSpeed != 0 {
	currentSpeed = 0;
}
// Make sure enemy speed can't exceed maxSpeed
if (currentSpeed > maxSpeed) || (currentSpeed < 0) {
	currentSpeed = maxSpeed;
}
#endregion


#region Set image index - since enemies cannot equip items, this remains the same even after player can start equipping items
// Set the image index
if enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) {
	enemyImageIndex = -1;
}
if enemyAnimationImageIndex >= sprite_get_number(enemyAnimationSprite) {
	enemyAnimationImageIndex = -1;
	enemyAnimationSprite = noone;
}
enemyImageIndexSpeed = enemyImageIndexBaseSpeed * enemyTotalSpeed * solidifyEnemyImageSpeedMultiplier;
enemyImageIndex += enemyImageIndexSpeed * hitstunMultiplier;
enemyAnimationImageIndex += enemyImageIndexSpeed;

image_index = enemyImageIndex;
#endregion


#region Setting Hurtbox Locations
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
#endregion


