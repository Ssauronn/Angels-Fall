/// @description Deal Damage to Enemy
// Deal damage to enemy as long as the hitbox wasn't fired by an enemy
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




#region Begin Determing What and When to Apply Damages and Healing
// If the hitbox is colliding with an enemy and the object that shot the hitbox is not another enemy,
// then apply player damage values.
if owner_is_player_ {
	if !playerHitboxHeal {
		if other_owner_is_enemy {
			playerHitboxCollisionFound = true;
			// See collision with obj_enemy event in obj_player_melee_hitbox for explanation as to why I multiply
			// comboDamageDealt by the percent I multiply damage by
			enemyHitByPlayer = true;
			comboDamageDealt += playerHitboxValue * playerTotalBonusDamage;
			other_owner_.enemyCurrentHP -= playerHitboxValue * playerTotalBonusDamage;
			lastEnemyHitByPlayer = other_owner_;
			// Track the player's attack pattern's (melee or ranged) based on whether the attack was melee or ranged
			if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
				obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
			}
		}
	}
	else if playerHitboxHeal {
		if other_owner_is_minion_ {
			playerHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += playerHitboxValue * playerTotalBonusDamage;
			if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
				obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
			}
		}
	}
}
// Else if the hitbox was fired by an enemy and collides with a minion, apply enemy damage values times
// enemy bonus damage minus minion bonus resistance
else if owner_is_enemy_ {
	if !enemyHitboxHeal {
		if other_owner_is_minion_ {
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP -= enemyHitboxValue * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
		}
		else if other_owner_is_player_ {
			enemyHitboxCollisionFound = true;
			if (!obj_skill_tree.parryWindowActive) && (!obj_skill_tree.successfulParryInvulnerabilityActive) {
				if obj_player.invincibile == false {
					playerCurrentHP -= enemyHitboxValue * (owner_.enemyTotalBonusDamage - playerTotalBonusResistance);
				}
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
	else if enemyHitboxHeal {
		if other_owner_is_enemy {
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
		}
	}
}
// Else if the hitbox was fired by a minion and collides with an enemy, apply minion damage values times
// minion bonus damage minus enemy bonus resistance
else if owner_is_minion_ {
	if !enemyHitboxHeal {
		if other_owner_is_enemy {
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP -= enemyHitboxValue * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
			lastEnemyHitByMinion = other_owner_;
		}
	}
	else if enemyHitboxHeal {
		if other_owner_is_player_ {
			enemyHitboxCollisionFound = true;
			playerCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
		}
		else if other_owner_is_minion_ {
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
		}
	}
}
#endregion



