/// @description Detect if within range and execute code
// Make sure if the interactable is solid, a wall has been created for the interactable
if interactableSolid {
	if !instance_exists(interactableWall) {
		interactableWall = instance_create_depth(x, y, -999, obj_wall);
		interactableWall.sprite_index = sprite_index;
		interactableWall.visible = false;
		mp_grid_add_instances(roomMovementGrid, interactableWall, false);
	}
	// If the interactable is solid, update the wall location in case the interactable ever changes location
	// Set on a one second timer. If the interactable moves, a timer starts for 1 second that deactivates itself
	// after completiong and destroys, and creates, a new wall at the new interactable location while updating the
	// roomMovementGrid
	if (interactableXLocation != x) || (interactableYLocation != y) {
		if interactableWallUpdateTimer <= 0 {
			interactableWallUpdateTimer = interactableWallUpdateTimerStartTime;
		}
		if interactableWallUpdateTimer > 0 {
			interactableWallUpdateTimer--;
		}
		if interactableWallUpdateTimer <= 0 {
			interactableXLocation = x;
			interactableYLocation = y;
			if instance_exists(interactableWall) {
				instance_destroy(interactableWall);
			}
			interactableWall = instance_create_depth(x, y, -999, obj_wall);
			interactableWall.image_angle = image_angle;
			interactableWall.sprite_index = sprite_index;
			interactableWall.visible = false;
			mp_grid_destroy(roomMovementGrid);
			roomMovementGrid = noone;
			roomMovementGrid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16);
			mp_grid_add_instances(roomMovementGrid, obj_wall, false);
		}
	}
}

// First run animations and logic for interactables, if any are needed
scr_interactables_managing();

// Determine first whether the interactable item is within range of the player's floor location
if instance_exists(obj_player) {
	var player_ = obj_player.playerGroundHurtbox;
	if point_distance(x, y, player_.x, player_.y) <= interactableRange {
		interactableWithinRange = true;
	}
	else {
		interactableWithinRange = false;
	}

	// If the player is in fact in range, execute interactable script in case the interact button is pressed
	if interactableWithinRange {
		var self_is_closest_basic_ = true;
		var self_is_closest_dialogue_ = true;
		var self_is_closest_menu_ = true;
		var self_ = self;
		with obj_interact {
			// Make sure this specific object is the closest to player. If it isn't, then make sure only the
			// closest interactable object runs the interactable code
			if (self_ != self) && (point_distance(self_.x, self_.y, player_.x, player_.y) > point_distance(self.x, self.y, player_.x, player_.y)) {
				if self_.interactableOpensDialogue {
					if self.interactableOpensDialogue {
						self_is_closest_dialogue_ = false;
					}
				}
				if self_.interactableOpensMenu {
					if self.interactableOpensMenu {
						self_is_closest_menu_ = false;
					}
				}
				if (!self_.interactableOpensDialogue) && (!self_.interactableOpensMenu) {
					self_is_closest_dialogue_ = false;
					self_is_closest_menu_ = false;
					if (!self.interactableOpensDialogue) && (!self.interactableOpensMenu) {
						self_is_closest_basic_ = false;
					}
				}
			}
		}
		// If the interactable either doesn't open anything, or opens a menu
		if obj_player.key_interact {
			// In case there are multiple interactables within range that are basic and open menus,
			// first prioritize basic interactables before interacting with menus.
			if (!interactableOpensMenu) && (!interactableOpensDialogue) && (self_is_closest_basic_) {
				interactableBasicActive = true;
			}
			else if (interactableOpensMenu) && (self_is_closest_menu_) {
				menuOpen = !menuOpen;
				interactableMenuActive = !interactableMenuActive;
			}
		}
		// Else if the interactable opens dialogue boxes - key_dialogue_choice_one is also the button used
		// to initially open optional dialogue options.
		else if obj_player.key_dialogue_choice_one {
			// Dialogue is seperated because dialogue relies on an entirely seperate button.
			if (interactableOpensDialogue) && (self_is_closest_dialogue_) {
				if !dialogueOpen {
					dialogueOpen = true;
					interactableDialogueTimer = interactableDialogueTimerStartTime;
				}
			}
		}
	}
}

// Actually run the scripts that control the interactables
if (interactableBasicActive) || (interactableMenuActive) || (interactableDialogueActive) {
	if (interactableOpensMenu) || (interactableOpensDialogue) {
		scr_interactables_with_menu();
	}
	else {
		scr_interactables_with_no_menu();
	}
}


