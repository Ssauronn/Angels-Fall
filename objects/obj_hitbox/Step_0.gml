/// @description Destroy Self if Outside Owner Range, Count Down Timers
if instance_exists(owner) {
	if owner.object_index == obj_player {
		if is_array(playerHitboxTargetArray) {
			// If the array's first value is noone, that means no collided objects exist, so delete the array
			if (playerHitboxTargetArray[0, 0] == noone) {
				playerHitboxTargetArray = noone;
			}
			else {
				var i;
				for (i = 0; i <= array_height_2d(playerHitboxTargetArray) - 1; i++) {
					// If the currently referenced row containing an object ID now contains the ID of an object that doesn't
					// exist, then delete that information and move all information down.
					if !instance_exists(playerHitboxTargetArray[i, 0]) {
						var j;
						for (j = i; j <= array_height_2d(playerHitboxTargetArray) - 1; j++) {
							// If the row currently referenced is not the last line in the row and the row below is not yet deleted,
							// then delete the information by shifting everything below the currently referenced row up by 1
							if ((j + 1) != array_height_2d(playerHitboxTargetArray)) && (playerHitboxTargetArray[j + 1, 0] != noone) {
								playerHitboxTargetArray[j + 1, 0] = playerHitboxTargetArray[j, 0];
								playerHitboxTargetArray[j + 1, 1] = playerHitboxTargetArray[j, 1];
							}
							// Else if the row currently referenced is the last line in the row, or the row below is already deleted,
							// then set the currently referenced line to noone, since that information will have already been shifted
							// up by 1 row.
							else if ((j + 1) == array_height_2d(playerHitboxTargetArray)) || (playerHitboxTargetArray[j + 1, 0] == noone) {
								playerHitboxTargetArray[j, 0] = noone;
								playerHitboxTargetArray[j, 1] = -1;
							}
						}
					}
					// Else minus the second value (the countdown) in this grid by one (damage is applied in collision event)
					else {
						if playerHitboxTargetArray[i, 1] >= 0 {
							playerHitboxTargetArray[i, 1] -= 1;
						}
					}
				}
			}
		}
	}
	else if owner.object_index == obj_enemy {
		if is_array(enemyHitboxTargetArray) {
			// If the array's first value is noone, that means no collided objects exist, so delete the array
			if (enemyHitboxTargetArray[0, 0] == noone) {
				enemyHitboxTargetArray = noone;
			}
			else {
				var i;
				for (i = 0; i <= array_height_2d(enemyHitboxTargetArray) - 1; i++) {
					// If the currently referenced row containing an object ID now contains the ID of an object that doesn't
					// exist, then delete that information and move all information down.
					if !instance_exists(enemyHitboxTargetArray[i, 0]) {
						var j;
						for (j = i; j <= array_height_2d(enemyHitboxTargetArray) - 1; j++) {
							// If the row currently referenced is not the last line in the row and the row below is not yet deleted,
							// then delete the information by shifting everything below the currently referenced row up by 1
							if ((j + 1) != array_height_2d(enemyHitboxTargetArray)) && (enemyHitboxTargetArray[j + 1, 0] != noone) {
								enemyHitboxTargetArray[j + 1, 0] = enemyHitboxTargetArray[j, 0];
								enemyHitboxTargetArray[j + 1, 1] = enemyHitboxTargetArray[j, 1];
							}
							// Else if the row currently referenced is the last line in the row, or the row below is already deleted,
							// then set the currently referenced line to noone, since that information will have already been shifted
							// up by 1 row.
							else if ((j + 1) == array_height_2d(enemyHitboxTargetArray)) || (enemyHitboxTargetArray[j + 1, 0] == noone) {
								enemyHitboxTargetArray[j, 0] = noone;
								enemyHitboxTargetArray[j, 1] = -1;
							}
						}
					}
					// Else minus the second value (the countdown) in this grid by one (damage is applied in collision event)
					else {
						if enemyHitboxTargetArray[i, 1] >= 0 {
							enemyHitboxTargetArray[i, 1] -= 1;
						}
					}
				}
			}
		}
	}
}



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
											enemyGameSpeed -= 1;
											slowEnemyTimeWithParryActive = true;
											slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
											// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I'm not resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
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
											enemyGameSpeed -= 1;
											slowEnemyTimeWithParryActive = true;
											slowEnemyTimeWithParryTimer = obj_skill_tree.slowEnemyTimeWithParryTimerStartTime;
											// The below line is not necessary to run the slow time effect on obj_enemy's, but it is necessary to make sure I'm not resetting the obj_enemy enemyGameSpeed variable if the Prime ability slow time is not active.
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
			if (playerHitboxCollisionFound) || (!rectangle_in_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, camera_get_view_x(view_camera[0]) - camera_get_view_width(view_camera[0]), camera_get_view_y(view_camera[0]) - camera_get_view_height(view_camera[0]), camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera) * 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) * 2))) {
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
		// Here I'm checking to determine whether the hitbox was fired by an enemy or the player by checking whether the
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
		// Here I'm checking to determine whether the hitbox was fired by an enemy or the player by checking whether the
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
// This is deleting the bullet in case the owner is undefined. Since the player will never be undefined, I don't have to check
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


