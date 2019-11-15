///@description Check for a valid movement path to the player
///@argument0 CollisionObject(s)

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
	
	path_ = path_add();
	path_set_kind(path_, 1);
	path_set_precision(path_, 1);
	var j;
	for (j = 0; j <= ds_list_size(collision_objects_) - 1; j++) {
		mp_grid_add_instances(ds_list_find_value(collision_objects_, j), obj_wall, false);
	}
	if !mp_grid_path(roomMovementGrid, path_, current_x_, current_y_, target_x_, target_y_, true) {
		if path_exists(path_) {
			path_delete(path_);
		}
		if ds_exists(collision_objects_, ds_type_list) {
			ds_list_destroy(collision_objects_);
			collision_objects_ = noone;
		}
		return false;
	}
	else {
		if path_exists(path_) {
			path_delete(path_);
		}
		if ds_exists(collision_objects_, ds_type_list) {
			ds_list_destroy(collision_objects_);
			collision_objects_ = noone;
		}
		return true;
	}
}
else {
	if path_exists(path_) {
		path_delete(path_);
	}
	if ds_exists(collision_objects_, ds_type_list) {
		ds_list_destroy(collision_objects_);
		collision_objects_ = noone;
	}
	return true;
}

// Clean up the path, just in case
if path_exists(path_) {
	path_delete(path_);
}

// Clean up the ds_list_, just in case
if ds_exists(collision_objects_, ds_type_list) {
	ds_list_destroy(collision_objects_);
	collision_objects_ = noone;
}


