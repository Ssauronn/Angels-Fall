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
			// If the hitbox persists after a collision, don't destroy the hitbox, instead store the object ID's of all
			// who have collided with the object inside an array (managed in the Step event) and start a countdown for 
			// the time between tics. Apply damage as well if necessary.
			if playerHitboxPersistAfterCollision {
				// If the array already exists, store the information needed inside the array, if it hasn't already been
				// stored.
				if is_array(playerHitboxTargetArray) {
					// Check to see if the target has been hit, and if so, do nothing.
					var i, target_already_hit_;
					target_already_hit_ = false;
					for (i = 0; i <= array_height_2d(playerHitboxTargetArray) - 1; i++) {
						if playerHitboxTargetArray[i, 0] == other_owner_ {
							target_already_hit_ = true;
						}
					}
					// If the target hasn't been hit yet, store the object ID inside this array and set it up to be damaged.
					// I set the timer to 0 so that its immediately ready for interaction with the hitbox after collision.
					if !target_already_hit_ {
						playerHitboxTargetArray[array_height_2d(playerHitboxTargetArray), 0] = other_owner_;
						playerHitboxTargetArray[array_height_2d(playerHitboxTargetArray), 1] = 0;
					}
				}
				// Else if the array doesn't already exist, create and store the information needed inside the array.
				// I set the timer to 0 so that its immediately ready for interaction with the hitbox after collision.
				else {
					playerHitboxTargetArray[0, 0] = other_owner_;
					playerHitboxTargetArray[0, 1] = 0;
				}
				// Loop through the array that now exists and check to see if any objects need to be damaged. If so, damage
				// them, then reset the tic timer.
				var i;
				for (i = 0; i <= array_height_2d(playerHitboxTargetArray) - 1; i++) {
					// If the tic timer for the object being collided with is at or less than 0, apply damage/healing and
					// reset the tic timer. For reference, the tic timer in this situation (a hitbox that persists after
					// collision) is not in reference to DoT damage. The tic timer in this situation is in reference to
					// the time between when a hitbox persisting after collision will deal damage.
					if playerHitboxTargetArray[i, 1] <= 0 {
						apply_damage_and_healing(owner_, other_owner_);
						playerHitboxTargetArray[i, 1] = playerHitboxTicTimer;
					}
				}
			}
			apply_damage_and_healing(owner_, other_owner_)
			/*
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
			*/
			// Set the angelicBarrageActive in the enemy that the hitbox is colliding with, thereby turning the multiplier
			// on. And since the multiplier is turned off every step unless it is actively colliding with the hitbox,
			// this line of code will keep the multiplier active for only as long as the enemy is colliding with this hitbox.
			if playerHitboxAbilityOrigin == "Angelic Barrage" {
				other_owner_.angelicBarrageActive = true;
			}
		}
	}
	else if playerHitboxHeal {
		if other_owner_is_minion_ {
			/*
			playerHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += playerHitboxValue * playerTotalBonusDamage;
			if !(obj_ai_decision_making.playerAttackPatternWeight - (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) < 0.000) {
				obj_ai_decision_making.playerAttackPatternWeight -= (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
			}
			*/
		}
	}
}
// Else if the hitbox was fired by an enemy and collides with a minion, apply enemy damage values times
// enemy bonus damage minus minion bonus resistance
else if owner_is_enemy_ {
	if !enemyHitboxHeal {
		if other_owner_is_minion_ {
			/*
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP -= enemyHitboxValue * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
			*/
		}
		else if other_owner_is_player_ {
			/*
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
			*/
		}
	}
	else if enemyHitboxHeal {
		if other_owner_is_enemy {
			/*
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
			*/
		}
	}
}
// Else if the hitbox was fired by a minion and collides with an enemy, apply minion damage values times
// minion bonus damage minus enemy bonus resistance
else if owner_is_minion_ {
	if !enemyHitboxHeal {
		if other_owner_is_enemy {
			/*
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP -= enemyHitboxValue * (owner_.enemyTotalBonusDamage - other_owner_.enemyTotalBonusResistance);
			lastEnemyHitByMinion = other_owner_;
			*/
		}
	}
	else if enemyHitboxHeal {
		if other_owner_is_player_ {
			/*
			enemyHitboxCollisionFound = true;
			playerCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
			*/
		}
		else if other_owner_is_minion_ {
			/*
			enemyHitboxCollisionFound = true;
			other_owner_.enemyCurrentHP += enemyHitboxValue * owner_.enemyTotalBonusDamage;
			*/
		}
	}
}
#endregion



