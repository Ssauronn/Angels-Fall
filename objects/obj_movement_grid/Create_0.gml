/// @description Create Grid
// We do the same thing here below in the Room Start event, except that there we check
// first to see if the grid exists. If it does, we destroy it, then remake it.
globalvar roomMovementGrid;
roomMovementGrid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16);

mp_grid_add_instances(roomMovementGrid, obj_wall, false);


