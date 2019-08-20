///@description Check for line of sight and if it doesn't exist, move enemy to nearest point with line
// of sight.
///@argument0 Target
///@argument1 CollisionObject(s)

/// SET UP VARIABLES
var self_ = self;
var target_ = argument[0];
var current_x_ = self_.enemyGroundHurtbox;
current_x_ = current_x_.x;
var current_y_ = self_.enemyGroundHurtbox;
current_y_ = current_y_.y;
if (instance_exists(target_)) && (!is_undefined(target_)) {
	if target_.object_index == obj_player {
		var target_x_ = obj_player.playerGroundHurtbox;
		target_x_ = target_x_.x;
		var target_y_ = obj_player.playerGroundHurtbox;
		target_y_ = target_y_.y;
	}
	else {
		var target_x_ = target_.enemyGroundHurtbox;
		target_x_ = target_x_.x;
		var target_y_ = target_.enemyGroundHurtbox;
		target_y_ = target_y_.y;
	}
}
else {
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	enemyImageIndex = 0;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}


var collision_objects_ = noone;
if collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
	// If there's collision objects listed, set up the collision object list and get ready to check
	// for alternate safe locations to teleport to.
	if argument_count > 1 {
		var j;
		for (j = 0; j < (argument_count - 1); j++) {
			collision_objects_ = ds_list_create();
			ds_list_add(collision_objects_, argument[j + 1]);
		}
	}
	var i, p;
	var collision_found_ = false;
	
	var path_ = path_add();
	path_set_kind(path_, 1);
	path_set_precision(path_, 1);
	mp_grid_add_instances(roomMovementGrid, obj_wall, false);
	if mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
		var number_of_points_on_path_ = path_get_number(path_);
		if number_of_points_on_path_ > 0 {
			for (i = 0; i <= number_of_points_on_path_ - 1; i++) {
				collision_found_ = false;
				for (p = 0; p <= ds_list_size(collision_objects_) - 1; p++) {
					if collision_line(path_get_point_x(path_, i), path_get_point_y(path_, i), target_x_, target_y_, ds_list_find_value(collision_objects_, p), false, true) {
						collision_found_ = true;
					}
				}
				if !collision_found_ {
					if enemyState != enemystates.moveWithinAttackRange {
						enemyImageIndex = 0;
						alreadyTriedToChase = false;
						alreadyTriedToChaseTimer = 0;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
						enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
						enemyTimeUntilNextManaAbilityUsableTimerSet = false;
						enemyTimeUntilNextManaAbilityUsableTimer = 0;
					}
					enemyState = enemystates.moveWithinAttackRange;
					enemyStateSprite = enemystates.moveWithinAttackRange;
					xPointToMoveTo = path_get_point_x(path_, path_get_number(path_) - 1);
					yPointToMoveTo = path_get_point_y(path_, path_get_number(path_) - 1);
					// Destroy the list and path before I do anything else to avoid a memory leak
					path_delete(path_);
					if ds_exists(collision_objects_, ds_type_list) {
						ds_list_destroy(collision_objects_);
						collision_objects_ = noone;
					}
					return false;
				}
				if i == (path_get_number(path_) - 1) {
					path_delete(path_);
					return false;
				}
			}
		}
		else {
			path_delete(path_);
			return false;
		}
	}
	else {
		path_delete(path_);
		return false;
	}
}
else {
	return true;
}

// Clean up the ds_list_, just in case
if ds_exists(collision_objects_, ds_type_list) {
	ds_list_destroy(collision_objects_);
	collision_objects_ = noone;
}


