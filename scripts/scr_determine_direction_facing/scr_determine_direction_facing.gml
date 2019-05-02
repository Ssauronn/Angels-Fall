///@description Set enemyDirectionFacing correctly each frame this is called

// If the state the enemy is in is NOT to passively follow the player, or if the enemy has not created the hitbox for its attack yet
//if (enemyState != enemystates.passivelyFollowPlayer) && (enemyState != enemystates.heavyMeleeAttack) && (enemyState != enemystates.lightMeleeAttack) && (enemyState != enemystates.heavyRangedAttack) && (enemyState != enemystates.lightRangedAttack) {
if (enemyState != enemystates.passivelyFollowPlayer) || ((enemyState == enemystates.heavyMeleeAttack) && (hitboxCreated == false)) || ((enemyState == enemystates.lightMeleeAttack) && (hitboxCreated == false)) || ((enemyState == enemystates.heavyRangedAttack) && (hitboxCreated == false)) || ((enemyState == enemystates.lightRangedAttack) && (hitboxCreated == false)) {
	// If the enemy has already chosen an attack state to be in
	if chosenEngine != "" {
		// As long as the state to choose to be in is not healing, set direction facing based on the 
		// current target to focus.
		if chosenEngine != "Heal Ally" {
			if instance_exists(currentTargetToFocus) {
				var point_direction_ = point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y);
				currentDirection = point_direction_;
				if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
					enemyDirectionFacing = enemydirection.right;
				}
				else if (point_direction_ <= 135) && (point_direction_ > 45) {
					enemyDirectionFacing = enemydirection.up;
				}
				else if (point_direction_ <= 235) && (point_direction_ > 135) {
					enemyDirectionFacing = enemydirection.left;
				}
				else if (point_direction_ <= 315) && (point_direction_ > 235) {
					enemyDirectionFacing = enemydirection.down;
				}
			}
		}
		// Else if the state chosen to be in is healing, set the direction facing based on the current
		// target to heal.
		else if chosenEngine == "Heal Ally" {
			if instance_exists(currentTargetToHeal) {
				var point_direction_ = point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y);
				currentDirection = point_direction_;
				if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
					enemyDirectionFacing = enemydirection.right;
				}
				else if (point_direction_ <= 135) && (point_direction_ > 45) {
					enemyDirectionFacing = enemydirection.up;
				}
				else if (point_direction_ <= 235) && (point_direction_ > 135) {
					enemyDirectionFacing = enemydirection.left;
				}
				else if (point_direction_ <= 315) && (point_direction_ > 235) {
					enemyDirectionFacing = enemydirection.down;
				}
			}
		}
	}
	// Else if the object has not yet chosen an attack state to be in, but the object is a minion, then
	// just set the direction facing every frame equal to facing the player. This means the minions will
	// still face the player when out of combat, even if not actively following the player.
	else if combatFriendlyStatus == "Minion" {
		if !ds_exists(objectIDsInBattle, ds_type_list) {
			if instance_exists(obj_player) {
				var point_direction_ = point_direction(x, y, obj_player.x, obj_player.y);
				currentDirection = point_direction_;
				if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
					enemyDirectionFacing = enemydirection.right;
				}
				else if (point_direction_ <= 135) && (point_direction_ > 45) {
					enemyDirectionFacing = enemydirection.up;
				}
				else if (point_direction_ <= 235) && (point_direction_ > 135) {
					enemyDirectionFacing = enemydirection.left;
				}
				else if (point_direction_ <= 315) && (point_direction_ > 235) {
					enemyDirectionFacing = enemydirection.down;
				}
			}
		}
	}
}
// Else if the enemy state is in fact set to passively follow the player, then just set the enemy direction
// to follow the player every frame.		   
else {										   
	if combatFriendlyStatus == "Minion" {
		if instance_exists(obj_player) {
			var point_direction_ = point_direction(x, y, obj_player.x, obj_player.y);
			currentDirection = point_direction_;
			if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
				enemyDirectionFacing = enemydirection.right;
			}								   
			else if (point_direction_ <= 135) && (point_direction_ > 45) {
				enemyDirectionFacing = enemydirection.up;
			}								   
			else if (point_direction_ <= 235) && (point_direction_ > 135) {
				enemyDirectionFacing = enemydirection.left;
			}								   
			else if (point_direction_ <= 315) && (point_direction_ > 235) {
				enemyDirectionFacing = enemydirection.down;
			}								   
		}
	}
}

