///@description Check for a valid movement path to the player or minions

// If the object is an enemy, check for an existing path to player or minion. If its a minion, as 
// long as there is no current combat happening then check for an existing path only to player.
if (combatFriendlyStatus == "Enemy") || (combatFriendlyStatus == "Minion" && !ds_exists(objectIDsInBattle, ds_type_list)) {
	/// Universal checking for path status to player
	// SET UP VARIABLES
	var self_ = self;
	var current_x_ = self_.enemyGroundHurtbox;
	current_x_ = current_x_.x;
	var current_y_ = self_.enemyGroundHurtbox;
	current_y_ = current_y_.y;
	var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
	var target_x_ = player_ground_hurtbox_.x;
	var target_y_ = player_ground_hurtbox_.y;
	
	
	var path_ = noone;
	#region Checking for player path, for both the minions and enemies.
	// If there isn't a direct line of sight, check for a path. Otherwise, a path obviously exists.
	if collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
	
		// Create the path that will be used to test for a path to a target later on
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);
	
		// If a path exists, return true after wiping necessary variables
		var path_exists_ = false;
		if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
			path_exists_ = true;
		}
		// Wipe variables
		if path_exists(path_) {
			path_delete(path_);
		}
		// Return true immediately if a path exists, or return whatever the output is if the object
		// calling this script is a minion because a minion won't check for paths to other minions.
		if (path_exists_) || (combatFriendlyStatus == "Minion") {
			return path_exists_;
		}
	}
	// If there is line of sight, return true because a path obviously exists.
	else {
		return true;
	}
	#endregion


	if combatFriendlyStatus == "Enemy" {
		#region Checking for minion path
		// First, iterate through each obj_enemy that's marked as a minion to see if a path exists
		// from the enemy object calling this script to the minion referenced.
		with obj_enemy {
			var target_ = self;
			if target_.id != self_.id {
				if target_.combatFriendlyStatus == "Minion" {
					var variable_exists_ = false;
					with target_ {
						if variable_instance_exists(target_, "enemyGroundHurtbox") {
							if instance_exists(target_.enemyGroundHurtbox) {
								variable_exists_ = true;
							}
						}
					}
					if variable_exists_ {
						target_ = target_.enemyGroundHurtbox;
						target_x_ = target_.x;
						target_y_ = target_.y;
						with self_ {
							if collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
								// Create the path that will be used to test for a path to the target later
								path_ = path_add();
								path_set_kind(path_, 1);
								path_set_precision(path_, 1);
							
								// If a path exists, return true after wiping necessary variables
								var path_exists_ = false;
								if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
									path_exists_ = true;
								}
								// Wipe variables
								if path_exists(path_) {
									path_delete(path_);
								}
								// Return true immediately if a path exists
								if path_exists_ {
									return true;
								}
							}
							else {
								return true;
							}
						}
					}
				}
			}
		}
		#endregion
		// Finally, return false in case no path was ever found to any existing target for enemy objects
		return false;
	}
}
// The only way this will activate is if the object calling this script is a minion in combat, and if
// that's the case, then it should finish combat before checking for an existing path to the player, so
// just return true.
else {
	return true;
}


