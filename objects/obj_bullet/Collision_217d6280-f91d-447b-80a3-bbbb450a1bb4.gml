/// @description Deal Damage to Enemy
// Deal damage to enemy as long as the bullet wasn't fired by an enemy
#region Set Up Variables Used to Control Damages
var owner_, owner_is_enemy_, owner_is_minion_, owner_is_player_, owner_is_self_;
var other_owner_, other_owner_is_enemy, other_owner_is_minion_, other_owner_is_player_;
owner_is_enemy_ = false;
owner_is_minion_ = false;
owner_is_player_ = false;
owner_is_self_ = false;
owner_ = owner;
other_owner_is_player_ = false;
other_owner_is_enemy = false;
other_owner_is_minion_ = false;
other_owner_ = other.owner;

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
#endregion
#region Begin Determing What and When to Apply Damages
// If the bullet is colliding with an enemy and the object that shot the bullet is not another enemy,
// then apply player damage values.
if owner_is_player_ {
	if other_owner_is_enemy {
		// See collision with obj_enemy event in obj_player_melee_hitbox for explanation as to why I multiply
		// enemiesDealtDamage by the percent I multiply damage by
		enemiesDealtDamage += 1 + (1 * obj_skill_tree.primeBonusDamagePercentAsDecimal);
		other_owner_.enemyCurrentHP -= 100 * playerTotalBonusDamage;
		lastEnemyHitByPlayer = other_owner_;
		// Track the player's attack pattern's (melee or ranged) based on whether the attack was melee or ranged
		if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
			obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
		}
	}
}
// Else if the bullet was fired by an enemy and collides with a minion, apply enemy damage values times
// enemy bonus damage minus minion bonus resistance
else if owner_is_enemy_ {
	if other_owner_is_minion_ {
		other_owner_.enemyCurrentHP -= 100 * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
	}
	else if other_owner_is_player_ {
		if (!obj_skill_tree.parryWindowActive) && (!obj_skill_tree.successfulParryInvulnerabilityActive) {
			playerCurrentHP -= 100 * (owner_.enemyTotalBonusDamage - playerTotalBonusResistance);
		}
		// If the player is parrying upon contact, execute all parry actions and effects
		else {
			if obj_skill_tree.parryWindowActive {
				obj_skill_tree.successfulParryInvulnerabilityActive = true;
				obj_skill_tree.successfulParryInvulnerabilityTimer = obj_skill_tree.successfulParryInvulnerabilityTimerStartTime;
				obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = true;
			}
			obj_skill_tree.parryWindowActive = false;
			obj_skill_tree.parryWindowTimer = -1;
			// execute parry animation and visual effects, etc.
		}
	}
}
// Else if the bullet was fired by a minion and collides with an enemy, apply minion damage values times
// minion bonus damage minus enemy bonus resistance
else if owner_is_minion_ {
	if other_owner_is_enemy {
		other_owner_.enemyCurrentHP -= 100 * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
		lastEnemyHitByMinion = other_owner_;
	}
}
#endregion

#region Actually Destroy the Bullet Object
// If the bullet isn't colliding with the player
if !other_owner_is_player_ {
	// Actually destroy the bullet object
	var i, row_to_delete_;
	row_to_delete_ = -1;
	// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
	// Check to see if any bullet hitboxes exist
	if ds_exists(obj_combat_controller.enemyBulletHitboxList, ds_type_list) {
		// Check to see if the first hitbox exists
		if (instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyBulletHitboxList)){
			// Check to see if there are more than 1 hitboxes active
			if ds_list_size(obj_combat_controller.enemyBulletHitboxList) > 1 {
				// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
					if ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i) == self {
						row_to_delete_ = i;
					}
				}
				// Redundant check, prevents bugs
				if row_to_delete_ != -1 {
					// Delete and destroy the specific line that contains the bullet object
					ds_list_delete(obj_combat_controller.enemyBulletHitboxList, row_to_delete_);
				}
			}
			// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
			else {
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
					if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
						ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
					}
				}
				if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
					ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
					obj_combat_controller.enemyBulletHitboxList = noone;
				}
			}
		}
		// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
		else {
			for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
				if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
					ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
				}
			}
			if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
				ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
				obj_combat_controller.enemyBulletHitboxList = noone;
			}
		}
	}
	instance_destroy(self);
}
// Else if the bullet is colliding with the player
else {
	// Actually destroy the bullet object
	var i, row_to_delete_;
	row_to_delete_ = -1;
	// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
	// Check to see if any bullet hitboxes exist
	if ds_exists(obj_combat_controller.enemyBulletHitboxList, ds_type_list) {
		// Check to see if the first hitbox exists
		if (instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyBulletHitboxList)){
			// Check to see if there are more than 1 hitboxes active
			if ds_list_size(obj_combat_controller.enemyBulletHitboxList) > 1 {
				// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
					if ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i) == self {
						row_to_delete_ = i;
					}
				}
				// Apply the slow to the enemy in case the attack was parried instead
				if obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy {
					with ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, row_to_delete_) {
						with owner_ {
							obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = false;
							enemyGameSpeed = 0;
							slowEnemyTimeWithParryActive = true;
							slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
							// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I aren't resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
							// Essentially, I keep track of the buff's timer on the most recently applied enemy by setting it in a centralized object (obj_skill_tree).
							obj_skill_tree.slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
						}
					}
				}
				// Redundant check, prevents bugs
				if row_to_delete_ != -1 {
					// Delete and destroy the specific line that contains the bullet object
					ds_list_delete(obj_combat_controller.enemyBulletHitboxList, row_to_delete_);
				}
			}
			// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
			else {
				// Apply the slow in case the attack was successfully parried
				if obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy {
					with ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, 0) {
						with owner_ {
							obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = false;
							enemyGameSpeed = 0;
							slowEnemyTimeWithParryActive = true;
							slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
							// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I aren't resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
							// Essentially, I keep track of the buff's timer on the most recently applied enemy by setting it in a centralized object (obj_skill_tree).
							obj_skill_tree.slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
						}
					}
				}
				// Erase the hitbox ds_list assuming it needs erasing
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
					if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
						ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
					}
				}
				if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
					ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
					obj_combat_controller.enemyBulletHitboxList = noone;
				}
			}
		}
		// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
		else {
			for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
				if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
					ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
				}
			}
			if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
				ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
				obj_combat_controller.enemyBulletHitboxList = noone;
			}
		}
	}
	instance_destroy(self);
}
#endregion


