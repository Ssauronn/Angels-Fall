if interactableName == "Dissolve Door 1" {
	interactableImageIndexSpeed = (obj_player.playerImageIndexSpeed * 0.8);
	interactableImageIndex += interactableImageIndexSpeed;
	if interactableImageIndex >= (sprite_get_number(sprite_index) - 1) {
		instance_destroy(self);
	}
	image_index = interactableImageIndex;
}


