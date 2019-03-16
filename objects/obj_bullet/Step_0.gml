/// @description Destroy Self if Outside Owner Range
if !is_undefined(owner) {
	if instance_exists(owner) {
		if owner.object_index == obj_enemy {
			// If the projectile object is outside of the enemy's tether range, destroy itself
			if !(rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (owner.tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (owner.tetherYRange / 2), (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (owner.tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (owner.tetherYRange / 2))) {
				// Actually destroy the bullet object
				var i, row_to_delete_;
				row_to_delete_ = -1;
				// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
				// Check to see if any bullet hitboxes exist
				if ds_exists(obj_combat_controller.enemyHitboxList, ds_type_list) {
					// Check to see if the first hitbox exists
					if (instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyHitboxList)){
						// Check to see if there are more than 1 hitboxes active
						if ds_list_size(obj_combat_controller.enemyHitboxList) > 1 {
							// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
							for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
								if ds_list_find_value(obj_combat_controller.enemyHitboxList, i) == self {
									row_to_delete_ = i;
								}
							}
							// Redundant check, prevents bugs
							if row_to_delete_ != -1 {
								// Delete and destroy the specific line that contains the bullet object
								ds_list_delete(obj_combat_controller.enemyHitboxList, row_to_delete_);
							}
						}
						// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
						else {
							for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
								if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
									ds_list_delete(obj_combat_controller.enemyHitboxList, i);
								}
							}
							if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
								ds_list_destroy(obj_combat_controller.enemyHitboxList);
								obj_combat_controller.enemyHitboxList = noone;
							}
						}
					}
					// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
					else {
						for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
							if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
								ds_list_delete(obj_combat_controller.enemyHitboxList, i);
							}
						}
						if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
							ds_list_destroy(obj_combat_controller.enemyHitboxList);
							obj_combat_controller.enemyHitboxList = noone;
						}
					}
				}
				instance_destroy(self);
			}
		}
	}
	else {
		// Actually destroy the bullet object
		var i, row_to_delete_;
		row_to_delete_ = -1;
		// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
		// Check to see if any bullet hitboxes exist
		if ds_exists(obj_combat_controller.enemyHitboxList, ds_type_list) {
			// Check to see if the first hitbox exists
			if (instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyHitboxList)){
				// Check to see if there are more than 1 hitboxes active
				if ds_list_size(obj_combat_controller.enemyHitboxList) > 1 {
					// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
					for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
						if ds_list_find_value(obj_combat_controller.enemyHitboxList, i) == self {
							row_to_delete_ = i;
						}
					}
					// Redundant check, prevents bugs
					if row_to_delete_ != -1 {
						// Delete and destroy the specific line that contains the bullet object
						ds_list_delete(obj_combat_controller.enemyHitboxList, row_to_delete_);
					}
				}
				// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
				else {
					for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
						if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
							ds_list_delete(obj_combat_controller.enemyHitboxList, i);
						}
					}
					if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
						ds_list_destroy(obj_combat_controller.enemyHitboxList);
						obj_combat_controller.enemyHitboxList = noone;
					}
				}
			}
			// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
			else {
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
					if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
						ds_list_delete(obj_combat_controller.enemyHitboxList, i);
					}
				}
				if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
					ds_list_destroy(obj_combat_controller.enemyHitboxList);
					obj_combat_controller.enemyHitboxList = noone;
				}
			}
		}
		instance_destroy(self);
	}
}
else {
	// Actually destroy the bullet object
	var i, row_to_delete_;
	row_to_delete_ = -1;
	// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
	// Check to see if any bullet hitboxes exist
	if ds_exists(obj_combat_controller.enemyHitboxList, ds_type_list) {
		// Check to see if the first hitbox exists
		if (instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyHitboxList)){
			// Check to see if there are more than 1 hitboxes active
			if ds_list_size(obj_combat_controller.enemyHitboxList) > 1 {
				// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
					if ds_list_find_value(obj_combat_controller.enemyHitboxList, i) == self {
						row_to_delete_ = i;
					}
				}
				// Redundant check, prevents bugs
				if row_to_delete_ != -1 {
					// Delete and destroy the specific line that contains the bullet object
					ds_list_delete(obj_combat_controller.enemyHitboxList, row_to_delete_);
				}
			}
			// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
			else {
				for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
					if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
						ds_list_delete(obj_combat_controller.enemyHitboxList, i);
					}
				}
				if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
					ds_list_destroy(obj_combat_controller.enemyHitboxList);
					obj_combat_controller.enemyHitboxList = noone;
				}
			}
		}
		// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
		else {
			for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
				if !instance_exists(ds_list_find_value(obj_combat_controller.enemyHitboxList, i)) {
					ds_list_delete(obj_combat_controller.enemyHitboxList, i);
				}
			}
			if ds_list_size(obj_combat_controller.enemyHitboxList) < 1 {
				ds_list_destroy(obj_combat_controller.enemyHitboxList);
				obj_combat_controller.enemyHitboxList = noone;
			}
		}
	}
	instance_destroy(self);
}


