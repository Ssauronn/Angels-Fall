///@description Check for a valid movement path to the player or minions

/*
If the script returns true: a path exists directly to the target the object currently has in its sights
If the script returns false: no path exists to any valid target
If the script returns noone: no path exists to the current target, but a path exists to a different valid target
*/

// SET UP VARIABLES
var current_x_ = enemyGroundHurtbox;
current_x_ = current_x_.x;
var current_y_ = enemyGroundHurtbox;
current_y_ = current_y_.y;
var i;


var path_exists_ = false;
// Create the validObjectIDsInBattle ds_list, used to actually control
// scr_ai_decisions.
if ds_exists(objectIDsInBattle, ds_type_list) {
	// Create the path that will be used to test for a path to a target later on
	var path_;
	path_ = path_add();
	path_set_kind(path_, 1);
	path_set_precision(path_, 1);
	// If, for some reason, the list of valid targets currently exists,
	// destroy it before creating a new one.
	if ds_exists(validObjectIDsInBattle, ds_type_list) {
		ds_list_destroy(validObjectIDsInBattle);
		validObjectIDsInBattle = noone;
	}
	// Now, check for a path to all objects in combat
	for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
		instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
		instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
		if instance_to_reference_ != self {
			if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
				path_exists_ = true;
				if !ds_exists(validObjectIDsInBattle, ds_type_list) {
					validObjectIDsInBattle = ds_list_create();
				}
				ds_list_add(validObjectIDsInBattle, instance_to_reference_);
			}
		}
		// If its referencing itself, don't bother checking for a path to the target because
		// one obviously just exists. Just add it to the validObjectIDsInBattle ds_list.
		else {
			if !ds_exists(validObjectIDsInBattle, ds_type_list) {
				validObjectIDsInBattle = ds_list_create();
			}
			ds_list_add(validObjectIDsInBattle, instance_to_reference_);
		}
	}
	if !path_exists_ {
		if ds_exists(validObjectIDsInBattle, ds_type_list) {
			ds_list_destroy(validObjectIDsInBattle);
			validObjectIDsInBattle = noone;
		}
	}
	if path_exists(path_) {
		path_delete(path_);
	}
}

path_exists_ = false;
// Check for a path to any valid target for enemy objects
if ds_exists(objectIDsInBattle, ds_type_list) {
	if combatFriendlyStatus == "Enemy" {
		// Create the path that will be used to test for a path to a target later on
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);
		if chosenEngine != "Heal Ally" {
			// First, check for a path to the player
			if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, obj_player.x, obj_player.y, true) {
				path_exists_ = noone;
				playerIsAValidFocusTarget = true;
				if instance_exists(currentTargetToFocus) {
					if currentTargetToFocus == obj_player.id {
						return true;
					}
				}
			}
			else {
				playerIsAValidFocusTarget = false;
			}
		}
		// After creating the ds_list just with all objects where a valid path exists,
		// run through that list and see if there are any valid targets. If so, mark it
		// as such.
		if ds_exists(validObjectIDsInBattle, ds_type_list) {
			for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
				if chosenEngine != "Heal Ally" {
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						path_exists_ = noone;
						if instance_exists(currentTargetToFocus) {
							if instance_to_reference_ == currentTargetToFocus {
								return true;
							}
						}
					}
				}
				else {
					if instance_to_reference_.enemyCurrentHP < instance_to_reference_.enemyMaxHP {
						path_exists_ = noone;
						if instance_exists(currentTargetToHeal) {
							if instance_to_reference_ == currentTargetToHeal {
								return true;
							}
						}
					}
				}
			}
		}
		// If there are no valid targets for the enemy except the player, then
		// return true because the player will be the only one targeted.
		else if chosenEngine != "Heal Ally" && playerIsAValidFocusTarget {
			return true;
		}
		// Else if not a single valid target within path sight exists, then return false,
		// because it can't move to anything to attack.
		else {
			return false;
		}
		// Wipe variables
		if path_exists(path_) {
			path_delete(path_);
		}
		// Return the result of whether a path to any valid target was found. If 
		// a path was found to the currently focused target, it will have already
		// return true.
		return path_exists_;
	}
}

#region Checking for path to target if the object checking is a minion
path_exists_ = false;
if combatFriendlyStatus == "Minion" {
	// Create the path that will be used to test for a path to a target later on
	var path_ = noone;
	path_ = path_add();
	path_set_kind(path_, 1);
	path_set_precision(path_, 1);
	var path_exists_ = false;
	/* 
	Do the following:
	- If player is in combat: check for a path to any other target, and if it exists, mark
	it as such.
	- If the player is not in combat: check for a path to the player specifically, and if it
	still doesn't exist, set the timer to teleport to the player, if the timer isn't already
	set.
	*/
	var instance_to_reference_, instance_to_reference_ground_hurtbox_;
	if ds_exists(objectIDsInBattle, ds_type_list) {
		// If the minion is set to heal an ally, check for allies to heal first
		if chosenEngine == "Heal Ally" { 
			if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, obj_player.x, obj_player.y, true) {
				path_exists_ = true;
				playerIsAValidHealTarget = true;
				if instance_exists(currentTargetToHeal) {
					if currentTargetToHeal == obj_player.id {
						return true;
					}
				}
			}
			else {
				playerIsAValidHealTarget = false;
			}
			if ds_exists(validObjectIDsInBattle, ds_type_list) {
				for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, i);
					instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
					if instance_to_reference_.combatFriendlyStatus == "Minion" {
						if instance_to_reference_.enemyCurrentHP < instance_to_reference_.enemyMaxHP {
							path_exists_ = noone;
							if instance_exists(currentTargetToHeal) {
								if instance_to_reference_ == currentTargetToHeal {
									return true;
								}
							}
						}
					}
				}
			}
			else if playerIsAValidHealTarget {
				return true;
			}
		}
		// Else if the minion isn't set to heal a target, determine if valid focus targets exist
		else {
			if ds_exists(validObjectIDsInBattle, ds_type_list) {
				for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
					instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, i);
					instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
					if instance_to_reference_.combatFriendlyStatus == "Enemy" {
						path_exists_ = noone;
						if instance_exists(currentTargetToFocus) {
							if instance_to_reference_ == currentTargetToFocus {
								return true;
							}
						}
					}
				}
			}
			// Return false because if the player is in combat, but no valid targets to move to
			// exist, then it should just stand and wait until a valid target does exist.
			else {
				return false;
			}
		}
	}
	// Else if the minion is not in combat but its trying to heal an ally,
	// if a path exists to any valid target, then set those as potential targets
	// for the AI to heal.
	else if chosenEngine == "Heal Ally" {
		instance_to_reference_ = obj_player;
		instance_to_reference_ground_hurtbox_ = instance_to_reference_.playerGroundHurtbox;
		// Check for healing the player first
		if playerCurrentHP < playerMaxHP {
			if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
				path_exists_ = noone;
				playerIsAValidHealTarget = true;
				if instance_exists(currentTargetToHeal) {
					if instance_to_reference_ == currentTargetToHeal {
						return true;
					}
				}
			}
		}
		if ds_exists(validObjectIDsInBattle, ds_type_list) {
			for (i = 0; i <= ds_list_size(validObjectIDsInBattle) - 1; i++) {
				instance_to_reference_ = ds_list_find_value(validObjectIDsInBattle, i);
				instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
				if instance_to_reference_.combatFriendlyStatus == "Minion" {
					if instance_to_reference_.enemyCurrentHP < instance_to_reference_.enemyMaxHP {
						path_exists_ = noone;
						if instance_exists(currentTargetToHeal) {
							if instance_to_reference_ == currentTargetToHeal {
								return true;
							}
						}
					}
				}
			}
		}
		else if playerIsAValidHealTarget {
			return true;
		}
		else {
			return false;
		}
	}
	// Else if the minion is not in combat or healing, if a path exists 
	// to the player, then return true, because at this point that's 
	// the only target the minion will be following.
	else {
		instance_to_reference_ = obj_player;
		instance_to_reference_ground_hurtbox_ = instance_to_reference_.playerGroundHurtbox;
		if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, true) {
			path_exists_ = true;
		}
		else {
			return false;
		}
	}
	// Wipe variables
	if path_exists(path_) {
		path_delete(path_);
	}
	// Return the result of whether a path was found or not
	return path_exists_;
}
#endregion


