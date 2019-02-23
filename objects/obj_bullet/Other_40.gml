/// @description Destroy Self
// Actually destroy the bullet object
var i, row_to_delete_;
row_to_delete_ = -1;
// Delete the info in the ds_list pertaining to the deleted bullet, and destroy the ds_list if necessary
// Check to see if any bullet hitboxes exist
if ds_exists(obj_combat_controller.enemyBulletHitboxList, ds_type_list) {
	// Check to see if the first hitbox exists
	if (instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, 0))) && (!ds_list_empty(obj_combat_controller.enemyBulletHitboxList)){
		// Check to see if there are more than 1 hitboxes active
		if ds_list_size(obj_combat_controller.enemyBulletHitboxList) > 1 {
			// Here I'm setting the local variable "i" to the obj_bullet ID that just hit the player
			for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
				if ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i) == self {
					row_to_delete_ = i;
				}
			}
			// Redundant check, prevents bugs
			if row_to_delete_ != -1 {
				// Delete and destroy the specific line that contains the bullet object
				ds_list_delete(obj_combat_controller.enemyBulletHitboxList, row_to_delete_);
			}
		}
		// If there's only one hitbox active, it must be the one colliding with the player, so erase the hitbox ds_list
		else {
			for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
				if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
					ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
				}
			}
			if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
				ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
				obj_combat_controller.enemyBulletHitboxList = noone;
			}
		}
	}
	// If the first hitbox doesn't exist, erase the hitbox ds_list, as no hitbox now exists
	else {
		for (i = 0; i <= ds_list_size(obj_combat_controller.enemyBulletHitboxList) - 1; i++) {
			if !instance_exists(ds_list_find_value(obj_combat_controller.enemyBulletHitboxList, i)) {
				ds_list_delete(obj_combat_controller.enemyBulletHitboxList, i);
			}
		}
		if ds_list_size(obj_combat_controller.enemyBulletHitboxList) < 1 {
			ds_list_destroy(obj_combat_controller.enemyBulletHitboxList);
			obj_combat_controller.enemyBulletHitboxList = noone;
		}
	}
}
instance_destroy(self);


