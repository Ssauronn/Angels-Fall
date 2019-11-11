if interactableName == "Dissolve Door 1" {
	interactableImageIndexSpeed = (obj_player.playerImageIndexSpeed * 0.8);
	interactableImageIndex += interactableImageIndexSpeed;
	if interactableImageIndex >= (sprite_get_number(sprite_index) - 1) {
		instance_destroy(interactableWall);
		mp_grid_destroy(roomMovementGrid);
		roomMovementGrid = noone;
		roomMovementGrid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16);
		mp_grid_add_instances(roomMovementGrid, obj_wall, false);
		instance_destroy(self);
	}
	image_index = interactableImageIndex;
}


