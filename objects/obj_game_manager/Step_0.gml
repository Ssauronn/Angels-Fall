/// Run gamewide events and such
if instance_exists(obj_player) {
	if obj_player.key_escape {
		game_end();
	}
	if obj_player.key_restart {
		obj_player.key_restart = false;
		with obj_camera_display_manager {
			var camera_ = camera_get_active();
			camera_destroy(camera_);
		}
		with obj_combat_controller {
			if ds_exists(playerHitboxList, ds_type_list) {
				ds_list_destroy(playerHitboxList);
				playerHitboxList = noone;
			}
			if ds_exists(enemyHitboxList, ds_type_list) {
				ds_list_destroy(enemyHitboxList);
				enemyHitboxList = noone;
			}
		}
		with obj_movement_grid {
			if variable_global_exists("roomMovementGrid") {
				if roomMovementGrid != noone {
					mp_grid_destroy(roomMovementGrid);
					roomMovementGrid = noone;
				}
			}
		}
		with obj_enemy {
			if !is_undefined(myPath) {
				if path_exists(myPath) {
					path_delete(myPath);
					myPath = noone;
				}
			}
			if variable_global_exists("enemy_heal_target_grid_") {
				if ds_exists(enemy_heal_target_grid_, ds_type_grid) {
					ds_grid_destroy(enemy_heal_target_grid_);
					enemy_heal_target_grid_ = noone;
				}
			}
			if variable_global_exists("enemy_target_grid_") {
				if ds_exists(enemy_target_grid_, ds_type_grid) {
					ds_grid_destroy(enemy_target_grid_);
					enemy_target_grid_ = noone;
				}
			}
			if variable_global_exists("minion_heal_target_grid_") {
				if ds_exists(minion_heal_target_grid_, ds_type_grid) {
					ds_grid_destroy(minion_heal_target_grid_);
					minion_heal_target_grid_ = noone;
				}
			}
			if variable_global_exists("minion_target_grid_") {
				if ds_exists(minion_target_grid_, ds_type_grid) {
					ds_grid_destroy(minion_target_grid_);
					minion_target_grid_ = noone;
				}
			}
			if ds_exists(objectIDsInBattle, ds_type_list) {
				ds_list_destroy(objectIDsInBattle);
				objectIDsInBattle = noone;
			}
			if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
				ds_list_destroy(objectIDsFollowingPlayer);
				objectIDsFollowingPlayer = noone;
			}
		}
		with all {
			instance_destroy(self);
		}
		game_restart();
	}
}


