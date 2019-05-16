/// @description Create Grid
globalvar roomMovementGrid;
// First check to see if the grid exists already. If it does, destroy it.
if ds_exists(roomMovementGrid, ds_type_grid) {
	mp_grid_destroy(roomMovementGrid);
	if instance_exists(obj_enemy) {
		with (obj_enemy) {
			if !is_undefined(myPath) {
				if path_exists(myPath) {
					path_delete(myPath);
				}
				myPath = undefined;
				pathCreated = false;
			}
		}
	}
}
// Now that I'm sure a grid doesn't exist, remake the movement grid in the dimensions of the room
if !ds_exists(roomMovementGrid, ds_type_grid) {
	roomMovementGrid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16);
	mp_grid_add_instances(roomMovementGrid, obj_wall, false);
}


