/// @description Destroy grid upon exit of room
if ds_exists(roomMovementGrid, ds_type_grid) {
	mp_grid_destroy(roomMovementGrid);
}
var i;
with (obj_enemy) {
	if path_exists(myPath) {
		path_delete(myPath);
	}
}


