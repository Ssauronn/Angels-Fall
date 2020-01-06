///@description Check for a valid movement path to the player or minions

/*
If the script returns true: a path exists directly to the target the object currently has in its sights
If the script returns false: no path exists to any valid target
If the script returns noone: no path exists to the current target, but a path exists to a different valid target
*/

/// Universal checking for path status to player
// SET UP VARIABLES
var self_ = self;
var current_x_ = self_.enemyGroundHurtbox;
current_x_ = current_x_.x;
var current_y_ = self_.enemyGroundHurtbox;
current_y_ = current_y_.y;
var target_ground_hurtbox_;
// Automatically set the target the enemy will be checking for a path to
if !ds_exists(objectIDsInBattle, ds_type_list) && combatFriendlyStatus == "Enemy" {
	target_ground_hurtbox_ = obj_player;
}
// If the target is in combat, then check for its target to focus or heal and set that
// as the target
if ds_exists(objectIDsInBattle, ds_type_list) {
	if chosenEngine != "" {
		if chosenEngine != "Heal" {
			target_ground_hurtbox_ = currentTargetToFocus;
		}
		else {
			target_ground_hurtbox_ = currentTargetToHeal;
		}
	}
	else {
		return true;
		if combatFriendlyStatus == "Minion" {
			return true;
		}
		else if combatFriendlyStatus == "Enemy" {
			// Create the path that will be used to test for a path to a target later on
			var path_, path_exists_to_valid_target_;
			path_exists_to_valid_target_ = false;
			path_ = path_add();
			path_set_kind(path_, 1);
			path_set_precision(path_, 1);
			// First, check for a path to the player
			if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, obj_player.x, obj_player.y, true) {
				path_exists_to_valid_target_ = true;
				playerIsAValidTarget = true;
			}
			else {
				playerIsAValidTarget = false;
			}
			// If, for some reason, the list of valid targets currently exists,
			// destroy it before creating a new one.
			if ds_exists(validObjectIDsInBattle, ds_type_list) {
				ds_list_destroy(validObjectIDsInBattle);
				validObjectIDsInBattle = noone;
			}
			// Now, check for a path to all minions
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
				if instance_to_reference_.combatFriendlyStatus == "Minion" {
					if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
						if !ds_exists(validObjectIDsInBattle, ds_type_list) {
							validObjectIDsInBattle = ds_list_create();
						}
						ds_list_add(validObjectIDsInBattle, instance_to_reference_);
						path_exists_to_valid_target_ = true;
					}
				}
			}
			// Wipe variables
			if path_exists(path_) {
				path_delete(path_);
			}
			// Return the result of whether a path to any valid target was found
			if path_exists_to_valid_target_ {
				return noone;
			}
			else {
				return false;
			}
		}
		return false;
	}
}
else {
	target_ground_hurtbox_ = obj_player;
}
// Once the target is set, set the new target equal to the current target's
// ground hurtbox. This prevents glitches due to pathfinding trying to find a
// path to a point inside a wall or something.
if instance_exists(target_ground_hurtbox_) {
	if target_ground_hurtbox_.object_index == obj_enemy {
		target_ground_hurtbox_ = target_ground_hurtbox_.enemyGroundHurtbox;
	}
	else {
		target_ground_hurtbox_ = target_ground_hurtbox_.playerGroundHurtbox;
	}
}
else {
	return false;
}
// Finally, set the variables that will be used for most of this script.
var target_x_ = target_ground_hurtbox_.x;
var target_y_ = target_ground_hurtbox_.y;


var path_ = noone;
#region Checking for path to target if the object checking is a minion
if combatFriendlyStatus == "Minion" {
	// If there isn't a direct line of sight, check for a path. Otherwise, a path obviously exists.
	if (collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true)) || (collision_line(current_x_, current_y_, target_x_, target_y_, obj_chasm, false, true)) {

		// Create the path that will be used to test for a path to a target later on
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);

		// If a path exists, return true after wiping necessary variables
		var path_exists_ = false;
		if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
			path_exists_ = true;
		}
		/* 
		Else if no path exists, do the following:
		- If player is in combat: check for a path to any other target, and if it exists, mark
		it as such.
		- If the player is not in combat: check for a path to the player specifically, and if it
		still doesn't exist, set the timer to teleport to the player, if the timer isn't already
		set.
		*/
		else {
			var i, instance_to_reference_, instance_to_reference_ground_hurtbox_;
			if ds_exists(objectIDsInBattle, ds_type_list) {
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
					if (instance_to_reference_.combatFriendlyStatus == "Enemy") && (instance_to_reference_ != target_ground_hurtbox_.owner) {
						if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
							path_exists_ = noone;
						}
					}
				}
			}
			else {
				instance_to_reference_ = obj_player;
				instance_to_reference_ground_hurtbox_ = instance_to_reference_.playerGroundHurtbox;
				if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
					path_exists_ = true;
				}
			}
		}
		// Wipe variables
		if path_exists(path_) {
			path_delete(path_);
		}
		// Return the result of whether a path was found or not
		return path_exists_;
	}
	// If there is line of sight, return true because a path obviously exists.
	else {
		return true;
	}
}
#endregion



#region Checking for path to target if the object checking is an enemy
// First, iterate through each obj_enemy that's marked as a minion to see if a path exists
// from the enemy object calling this script to the minion referenced.
if combatFriendlyStatus == "Enemy" {
	if (collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true)) || (collision_line(current_x_, current_y_, target_x_, target_y_, obj_chasm, false, true)) {
		// Create the path that will be used to test for a path to the target later
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);
	
		// If a path exists, return true after wiping necessary variables
		var path_exists_ = false;
		if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
			path_exists_ = true;
		}
		// Else if no path exists, check for a path to any other minion or the player.
		else {
			var i, instance_to_reference_, instance_to_reference_ground_hurtbox_;
			// Literally every frame of the game if an enemy exists the objectIDsInBattle ds_list
			// will exist, except on the first frame the first enemy is created.
			if ds_exists(objectIDsInBattle, ds_type_list) {
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						if instance_to_reference_ != target_ground_hurtbox_.owner {
							if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
								path_exists_ = noone;
							}
						}
					}
				}
			}
			else {
				path_exists_ = false;
			}
		}
		// Wipe variables
		if path_exists(path_) {
			path_delete(path_);
		}
		// Return the result of whether a path was found or not
		return path_exists_;
	}
	// Else if line of sight exists, a path obviously exists
	else {
		return true;
	}
}
#endregion


