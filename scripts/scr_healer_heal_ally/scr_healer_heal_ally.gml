#region Create the Healing Field
if instance_exists(currentTargetToHeal) {
	if (!hitboxCreated) && (enemyImageIndex > 7) {
		// Set hitboxCreated to true so that the enemy only heals objects once in this script
		hitboxCreated = true;
		// Set local variables
		var owner_, target_, i, instance_to_reference_, instance_to_reference_ground_hurtbox_, player_ground_hurtbox_;
		owner_ = self;
		target_ = currentTargetToHeal;
		player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
		// Set the local variable target_ to refer to the ground hurtbox of the target_, not the object itself
		if target_.object_index == obj_player {
			target_ = player_ground_hurtbox_;
		}
		else {
			target_ = target_.enemyGroundHurtbox;
		}
		// If the object calling this state is an enemy, make sure it only heals other enemies
		if combatFriendlyStatus == "Enemy" {
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				// Set the instance to refer to equal to whatever the for loop is currently refering to
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				// As long as the instance to refer to is another enemy, then heal it
				if instance_to_reference_.combatFriendlyStatus == "Enemy" {
					instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
					// As long as the instance's ground hurtbox is within range of the AoE effect, heal the instance itself
					if point_distance(target_.x, target_.y, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y) <= enemyHealAreaOfEffectRadius {
						instance_to_reference_.enemyCurrentHP += enemyHealValue;
					}
				}
			}
		}
		// Else if the object is a minion, make sure it only heals other minions or the player
		else if combatFriendlyStatus == "Minion" {
			// If the player's ground hurtbox is within range of the AoE effect, heal the player
			if point_distance(target_.x, target_.y, player_ground_hurtbox_.x, player_ground_hurtbox_.y) <= enemyHealAreaOfEffectRadius {
				playerCurrentHP += enemyHealValue;
			}
			// If the minion is currently in combat, then heal all allies in combat
			if ds_exists(objectIDsInBattle, ds_type_list) {
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					// Set the instance to refer to equal to whatever the for loop is currently refering to
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					// As long as the instance to refer to is another minion, then heal it
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
						// As long as the intance's ground hurtbox is within range of the AoE effect, heal the instance itself
						if point_distance(target_.x, target_.y, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y) <= enemyHealAreaOfEffectRadius {
							instance_to_reference_.enemyCurrentHP += enemyHealValue;
						}
					}
				}
			}
			// Else if the minion is not in combat, then still heal all allies, just accessing the objectIDsFollowingPlayer instead
			else {
				for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
					// Set the instance to refer to equal to whatever the for loop is currently refering to
					instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
					// As long as the instance to refer to is another minion, then heal it
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
						// As long as the instance's ground hurtbox is within range of the AoE effect, heal the instance itself
						if point_distance(target_.x, target_.y, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y) <= enemyHealAreaOfEffectRadius {
							instance_to_reference_.enemyCurrentHP += enemyHealValue;
						}
					}
				}
			}
		}
	}
}
// Else if the instance to heal doesn't even exist, then just revert back to idle state
else {
	hitboxCreated = false;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	enemyImageIndex = 0;
}
#endregion

// Send the enemy back to idle state after heal has finished
if instance_exists(self) {
	// If the instance calling this state has finished the animation, then revert back to idle state
	if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}

/*
STILL NEED TO DRAW THE AoE EFFECT SPRITE AND SET THE scr_healer_heal SPRITE TO HAVE CORRECT NUMBER OF FRAMES
*/
