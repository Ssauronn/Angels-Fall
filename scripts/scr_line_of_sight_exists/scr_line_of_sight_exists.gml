/// @function scr_line_of_sight_exists(TargetX, TargetY, CollisionObject(s)...);
/// @param {real} TargetX
/// @param {real} TargetY
/// @param {real} CollisionObject(s)
function scr_line_of_sight_exists() {
	///@description Check for line of sight and if it doesn't exist, move enemy to nearest point with line
	// of sight.

	/// SET UP VARIABLES
	var return_value_ = false;
	var self_ = self.id;
	var current_x_ = self_.enemyGroundHurtbox;
	current_x_ = current_x_.x;
	var current_y_ = self_.enemyGroundHurtbox;
	current_y_ = current_y_.y;
	var target_x_ = argument[0];
	var target_y_ = argument[1];

	var path_ = noone;
	var collision_objects_ = noone;
	if collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
		// If there's collision objects listed, set up the collision object list and get ready to check
		// for alternate safe locations to teleport to.
		if argument_count > 2 {
			var j;
			for (j = 0; j < (argument_count - 2); j++) {
				collision_objects_ = ds_list_create();
				ds_list_add(collision_objects_, argument[j + 2]);
			}
		}
		var i, p;
		var collision_found_ = false;
	
		path_ = path_add();
		path_set_kind(path_, 1);
		path_set_precision(path_, 1);
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
						if scr_path_exists_to_player_or_minions() {
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
							lineOfSightExists = false;
							return_value_ = false;
							break;
						}
						else {
							return_value_ = false;
							break;
						}
					}
					if i == (path_get_number(path_) - 1) {
						return_value_ = false;
						break;
					}
				}
			}
			else {
				return_value_ = false;
			}
		}
		else {
			return_value_ = false;
		}
	}
	else {
		lineOfSightExists = true;
		pointToMoveToTimer = room_speed * 0.25;
		return_value_ = true;
	}

	// Clean up the path
	if path_exists(path_) {
		path_delete(path_);
	}

	// Clean up the ds_list_
	if ds_exists(collision_objects_, ds_type_list) {
		ds_list_destroy(collision_objects_);
		collision_objects_ = noone;
	}

	// Return whatever needs to be returned
	return return_value_;

	/*
	Yes, I know repeatedly setting return_value_ to false is redunandant in this script; however,
	it makes it much easier to read, and for that reason I'm keeping it in.
	*/





}
