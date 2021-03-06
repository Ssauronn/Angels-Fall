/// @description Deal Damage to Enemy
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
if other_owner_.id != obj_player.id {
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


if owner_ != 0 {
	#region Begin Determing What and When to Apply Damages and Healing as long as the owner is the player
	// If the hitbox is colliding with an enemy and the object that shot the hitbox is not another enemy,
	// then apply player damage values.
	if owner_is_player_ {
		// If the hitbox persists after a collision, don't destroy the hitbox, instead store the object ID's of all
		// who have collided with the object inside an array (managed in the Step event) and start a countdown for 
		// the time between tics. Apply damage as well if necessary.
		if playerHitboxPersistAfterCollision {
			// As long as the hitbox colliding with the hurtbox isn't owned by the same object and is
			// meant to deal damage, then determine potential targets and count down the tic timers
			if !(!playerHitboxHeal && owner_is_self_) {
				// If the array already exists, store the information needed inside the array, if it 
				// hasn't already been stored.
				if is_array(playerHitboxTargetArray) {
					// Check to see if the target has been hit, and if so, do nothing.
					var i, target_already_hit_;
					target_already_hit_ = false;
					for (i = 0; i <= array_height_2d(playerHitboxTargetArray) - 1; i++) {
						var instance_to_reference_ = playerHitboxTargetArray[i, 0];
						if instance_exists(instance_to_reference_) {
							if instance_to_reference_.id == other_owner_ {
								target_already_hit_ = true;
							}
						}
					}
					// If the target hasn't been hit yet, store the object ID inside this array and set it up to be damaged.
					// I set the timer to 0 so that its immediately ready for interaction with the hitbox after collision.
					if !target_already_hit_ {
						var array_height_ = array_height_2d(playerHitboxTargetArray);
						playerHitboxTargetArray[array_height_, 0] = other_owner_;
						playerHitboxTargetArray[array_height_, 1] = 0;
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
				var array_height_ = array_height_2d(playerHitboxTargetArray);
				for (i = 0; i <= array_height_ - 1; i++) {
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
		}
		else {
			apply_damage_and_healing(owner_, other_owner_)
		}
		// Set the angelicBarrageActive in the enemy that the hitbox is colliding with, thereby turning the multiplier
		// on. And since the multiplier is turned off every step unless it is actively colliding with the hitbox,
		// this line of code will keep the multiplier active for only as long as the enemy is colliding with this hitbox.
		if playerHitboxAbilityOrigin == "Angelic Barrage" {
			other_owner_.angelicBarrageActive = true;
		}
	}
	#endregion
	#region Begin Determing What and When to Apply Damages and Healing as long as the owner is an enemy or minion
	if owner_is_enemy_ || owner_is_minion_ {
		// If the hitbox persists after a collision, don't destroy the hitbox, instead store the object ID's of all
		// who have collided with the object inside an array (managed in the Step event) and start a countdown for 
		// the time between tics. Apply damage as well if necessary.
		if enemyHitboxPersistAfterCollision {
			// As long as the hitbox colliding with the hurtbox isn't meant to damage others and isn't
			// owned by the same object, then determine all potential targets and count down tic timers
			if !(!enemyHitboxHeal && owner_is_self_) {
				// If the array already exists, store the information needed inside the array, if it 
				// hasn't already been stored.
				if is_array(enemyHitboxTargetArray) {
					// Check to see if the target has been hit, and if so, do nothing.
					var i, target_already_hit_;
					target_already_hit_ = false;
					for (i = 0; i <= array_height_2d(enemyHitboxTargetArray) - 1; i++) {
						var instance_to_reference_ = enemyHitboxTargetArray[i, 0];
						if instance_exists(instance_to_reference_) {
							if instance_to_reference_.id == other_owner_ {
								target_already_hit_ = true;
							}
						}
					}
					// If the target hasn't been hit yet, store the object ID inside this array and set it up to be damaged.
					// I set the timer to 0 so that its immediately ready for interaction with the hitbox after collision.
					if !target_already_hit_ {
						var array_height_ = array_height_2d(enemyHitboxTargetArray);
						enemyHitboxTargetArray[array_height_, 0] = other_owner_;
						enemyHitboxTargetArray[array_height_, 1] = 0;
					}
				}
				// Else if the array doesn't already exist, create and store the information needed inside the array.
				// I set the timer to 0 so that its immediately ready for interaction with the hitbox after collision.
				else {
					enemyHitboxTargetArray[0, 0] = other_owner_;
					enemyHitboxTargetArray[0, 1] = 0;
				}
				// Loop through the array that now exists and check to see if any objects need to be damaged. If so, damage
				// them, then reset the tic timer.
				var i;
				for (i = 0; i <= array_height_2d(enemyHitboxTargetArray) - 1; i++) {
					// If the tic timer for the object being collided with is at or less than 0, apply damage/healing and
					// reset the tic timer. For reference, the tic timer in this situation (a hitbox that persists after
					// collision) is not in reference to DoT damage. The tic timer in this situation is in reference to
					// the time between when a hitbox persisting after collision will deal damage.
					if enemyHitboxTargetArray[i, 1] <= 0 {
						apply_damage_and_healing(owner_, other_owner_);
						enemyHitboxTargetArray[i, 1] = enemyHitboxTicTimer;
					}
				}
			}
		}
		else {
			apply_damage_and_healing(owner_, other_owner_)
		}
	}
	#endregion
}


