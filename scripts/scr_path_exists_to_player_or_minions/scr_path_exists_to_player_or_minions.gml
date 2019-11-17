///@description Check for a valid movement path to the player or minions
///@argument0 CollisionObject(s)

if combatFriendlyStatus == "Enemy" {
	/// SET UP VARIABLES
	var self_ = self;
	var current_x_ = self_.enemyGroundHurtbox;
	current_x_ = current_x_.x;
	var current_y_ = self_.enemyGroundHurtbox;
	current_y_ = current_y_.y;
	var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
	var target_x_ = player_ground_hurtbox_.x;
	var target_y_ = player_ground_hurtbox_.y;
	

	var path_ = noone;
	var collision_objects_ = noone;
	#region Checking for player path
	// If there isn't a direct line of sight, check for a path. Otherwise, a path obviously exists.
	if collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
		// If there's collision objects listed, set up the collision object list and get ready to check
		// for alternate safe locations to teleport to.
		if argument_count > 0 {
			var j;
			for (j = 0; j < argument_count; j++) {
				collision_objects_ = ds_list_create();
				ds_list_add(collision_objects_, argument[j]);
			}
		}
		
		// Create the path that will be used to test for a path to a target later on
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);
		var j;
		for (j = 0; j <= ds_list_size(collision_objects_) - 1; j++) {
			mp_grid_add_instances(ds_list_find_value(collision_objects_, j), obj_wall, false);
		}
		
		// If a path exists, return true after wiping necessary variables
		var path_exists_ = false;
		if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
			path_exists_ = true;
		}
		// Wipe variables
		if path_exists(path_) {
			path_delete(path_);
		}
		if ds_exists(collision_objects_, ds_type_list) {
			ds_list_destroy(collision_objects_);
			collision_objects_ = noone;
		}
		// Return true immediately if a path exists
		if path_exists_ {
			return true;
		}
	}
	// If there is line of sight, return true because a path obviously exists.
	else {
		return true;
	}
	#endregion
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
							// If there's collision objects listed, set up the collision object list and get ready to check
							// for alternate safe locations to teleport to.
							if argument_count > 0 {
								var j;
								for (j = 0; j < argument_count; j++) {
									collision_objects_ = ds_list_create();
									ds_list_add(collision_objects_, argument[j]);
								}
							}
							
							// Create the path that will be used to test for a path to the target later
							path_ = path_add();
							path_set_kind(path_, 1);
							path_set_precision(path_, 1);
							var j;
							for (j = 0; j <= ds_list_size(collision_objects_) - 1; j++) {
								mp_grid_add_instances(ds_list_find_value(collision_objects_, j), obj_wall, false);
							}
							
							// If a path exists, return true after wiping necessary variables
							var path_exists_ = false;
							if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
								path_exists_ = true;
							}
							// Wipe variables
							if path_exists(path_) {
								path_delete(path_);
							}
							if ds_exists(collision_objects_, ds_type_list) {
								ds_list_destroy(collision_objects_);
								collision_objects_ = noone;
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
	
	// Finally, return false in case no path was ever found
	return false;
}
// If the obj_enemy calling this script is a minion, then it doesn't need to check for a path because
// it'll be teleported within range anyways
else {
	return true;
}


