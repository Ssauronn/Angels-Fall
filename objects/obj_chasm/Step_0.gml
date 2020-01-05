if point_distance(x, y, obj_player.x, obj_player.y) < 64 {
	instance_destroy(self);
	mp_grid_destroy(roomMovementGrid);
	roomMovementGrid = noone;
	roomMovementGrid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16);
	mp_grid_add_instances(roomMovementGrid, obj_wall, false);
	mp_grid_add_instances(roomMovementGrid, obj_chasm, false);
}