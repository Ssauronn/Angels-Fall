/// @description Destroy Self if Outside Owner Range
// Check to see if the owner even is defined
if !is_undefined(owner) {
	// Check to see if the owner exists
	if instance_exists(owner) {
		// If the owner is an enemy, destroy the hitbox and remove that hitbox from the enemyHitboxList
		if owner.object_index == obj_enemy {
			// Reduce the duration timer of the hitbox and then destroy it if necessary
			if enemyHitboxLifetime <= 0 {
				enemyHitboxCollisionFound = true;
			}
			else if enemyHitboxLifetime > 0 {
				enemyHitboxLifetime--;
			}
			// If the projectile object found a collision, or is outside of the enemy's tether range, destroy itself
			if (enemyHitboxCollisionFound) || (!rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (owner.tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (owner.tetherYRange / 2), (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (owner.tetherXRange / 2), (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (owner.tetherYRange / 2))) {
				// Actually destroy the bullet object
				var i, row_to_delete_;
				row_to_delete_ = -1;
				// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
				// Check to see if any bullet hitboxes exist
				if ds_exists(obj_combat_controller.enemyHitboxList, ds_type_list) {
					// Check to see if the first hitbox exists
					if (!ds_list_empty(obj_combat_controller.enemyHitboxList)) {
						// Check to see if there are more than 1 hitboxes active
						if ds_list_size(obj_combat_controller.enemyHitboxList) > 1 {
							// Here I'm setting the local variable "i" to the obj_hitbox ID that just hit the player
							for (i = 0; i <= ds_list_size(obj_combat_controller.enemyHitboxList) - 1; i++) {
								if ds_list_find_value(obj_combat_controller.enemyHitboxList, i) == self {
									row_to_delete_ = i;
								}
							}
							// Apply the slow to the enemy in case the attack was parried instead
							if obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy {
								with ds_list_find_value(obj_combat_controller.enemyHitboxList, row_to_delete_) {
									if !enemyHitboxCollidedWithWall {
										with owner {
											obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = false;
											enemyGameSpeed = 0;
											slowEnemyTimeWithParryActive = true;
											slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
											// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I aren't resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
											// Essentially, I keep track of the buff's timer on the most recently applied enemy by setting it in a centralized object (obj_skill_tree).
											obj_skill_tree.slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
										}
									}
								}
							}
							// Redundant check, prevents bugs
							if row_to_delete_ != -1 {
								// Delete and destroy the specific line that contains the bullet object
								ds_list_delete(obj_combat_controller.enemyHitboxList, row_to_delete_);
							}
						}
						// If there's only one hitbox active, erase the hitbox ds_list
						else {
							// Apply the slow to the enemy in case the attack was parried instead
							if obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy {
								with ds_list_find_value(obj_combat_controller.enemyHitboxList, row_to_delete_) {
									if !enemyHitboxCollidedWithWall {
										with owner {
											obj_skill_tree.successfulParryEffectNeedsToBeAppliedToEnemy = false;
											enemyGameSpeed = 0;
											slowEnemyTimeWithParryActive = true;
											slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
											// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I aren't resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
											// Essentially, I keep track of the buff's timer on the most recently applied enemy by setting it in a centralized object (obj_skill_tree).
											obj_skill_tree.slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
										}
									}
								}
							}
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
		// If the bullet is owned by the player, then destroy it
		else if owner.object_index == obj_player {
			// Reduce the lifetime of the player hitbox by one frame and then destroy it, if necessary
			if playerHitboxLifetime <= 0 {
				playerHitboxCollisionFound = true;
			}
			else if playerHitboxLifetime > 0 {
				playerHitboxLifetime--;
			}
			// If the bullet has found a collision or is outside of double the camera's size, destroy the bullet
			if playerHitboxCollisionFound || (!rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, camera_get_view_x(view_camera[0]) - camera_get_view_width(view_camera[0]), camera_get_view_y(view_camera[0]) - camera_get_view_height(view_camera[0]), camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera) * 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) * 2))) {
				// Actually destroy the bullet object
				var i, row_to_delete_;
				row_to_delete_ = -1;
				// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
				// Check to see if any bullet hitboxes exist
				if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
					// Check to see if the first hitbox exists
					if (instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.playerHitboxList)){
						// Check to see if there are more than 1 hitboxes active
						if ds_list_size(obj_combat_controller.playerHitboxList) > 1 {
							// Here I'm setting the local variable "i" to the obj_hitbox ID that just hit the player
							for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
								if ds_list_find_value(obj_combat_controller.playerHitboxList, i) == self {
									row_to_delete_ = i;
								}
							}
							// Redundant check, prevents bugs
							if row_to_delete_ != -1 {
								// Delete and destroy the specific line that contains the bullet object
								ds_list_delete(obj_combat_controller.playerHitboxList, row_to_delete_);
							}
						}
						// If there's only one hitbox active, erase the hitbox ds_list
						else {
							for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
								if !instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, i)) {
									ds_list_delete(obj_combat_controller.playerHitboxList, i);
								}
							}
							if ds_list_size(obj_combat_controller.playerHitboxList) < 1 {
								ds_list_destroy(obj_combat_controller.playerHitboxList);
								obj_combat_controller.playerHitboxList = noone;
							}
						}
					}
					// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
					else {
						for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
							if !instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, i)) {
								ds_list_delete(obj_combat_controller.playerHitboxList, i);
							}
						}
						if ds_list_size(obj_combat_controller.playerHitboxList) < 1 {
							ds_list_destroy(obj_combat_controller.playerHitboxList);
							obj_combat_controller.playerHitboxList = noone;
						}
					}
				}
				instance_destroy(self);
			}
		}
	}
	// If the instance firing the bullet doesn't exist, automatically delete and destroy all bullets fired by that instance
	else {
		// Here we're checking to determine whether the hitbox was fired by an enemy or the player by checking whether the
		// "value" variable is named "enemyHitboxValue" or "playerHitboxValue".
		if variable_instance_exists(self, "enemyHitboxValue") {
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
						// Here I'm setting the local variable "i" to the obj_hitbox ID that just hit the player
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
					// If there's only one hitbox active, erase the hitbox ds_list
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
		// Here we're checking to determine whether the hitbox was fired by an enemy or the player by checking whether the
		// "value" variable is named "enemyHitboxValue" or "playerHitboxValue".
		else if variable_instance_exists(self, "playerHitboxValue") {
			// Actually destroy the bullet object
			var i, row_to_delete_;
			row_to_delete_ = -1;
			// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
			// Check to see if any bullet hitboxes exist
			if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
				// Check to see if the first hitbox exists
				if (instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.playerHitboxList)){
					// Check to see if there are more than 1 hitboxes active
					if ds_list_size(obj_combat_controller.playerHitboxList) > 1 {
						// Here I'm setting the local variable "i" to the obj_hitbox ID that just hit the player
						for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
							if ds_list_find_value(obj_combat_controller.playerHitboxList, i) == self {
								row_to_delete_ = i;
							}
						}
						// Redundant check, prevents bugs
						if row_to_delete_ != -1 {
							// Delete and destroy the specific line that contains the bullet object
							ds_list_delete(obj_combat_controller.playerHitboxList, row_to_delete_);
						}
					}
					// If there's only one hitbox active, erase the hitbox ds_list
					else {
						for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
							if !instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, i)) {
								ds_list_delete(obj_combat_controller.playerHitboxList, i);
							}
						}
						if ds_list_size(obj_combat_controller.playerHitboxList) < 1 {
							ds_list_destroy(obj_combat_controller.playerHitboxList);
							obj_combat_controller.playerHitboxList = noone;
						}
					}
				}
				// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
				else {
					for (i = 0; i <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; i++) {
						if !instance_exists(ds_list_find_value(obj_combat_controller.playerHitboxList, i)) {
							ds_list_delete(obj_combat_controller.playerHitboxList, i);
						}
					}
					if ds_list_size(obj_combat_controller.playerHitboxList) < 1 {
						ds_list_destroy(obj_combat_controller.playerHitboxList);
						obj_combat_controller.playerHitboxList = noone;
					}
				}
			}
			instance_destroy(self);
		}
	}
}
// This is deleting the bullet in case the owner is undefined. Since the player will never be undefined, we don't have to check
// whether the owner is the player or enemy.
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
				// Here I'm setting the local variable "i" to the obj_hitbox ID that just hit the player
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


