/// @description Detect if within range and execute code
// First run animations for interactables, if any are needed
scr_interactables_animations_control();

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
		var self_is_closest_ = true;
		var self_ = self;
		with obj_interact {
			// Make sure this specific object is the closest to player. If it isn't, then make sure only the
			// closest interactable object runs the interactable code
			if (self_ != self) && (point_distance(self_.x, self_.y, player_.x, player_.y) > point_distance(self.x, self.y, player_.x, player_.y)) {
				self_is_closest_ = false;
			}
		}
		if self_is_closest_ {
			if obj_player.key_interact {
				interactableActive = !interactableActive;
				if interactableOpensMenu {
					menuOpen = !menuOpen;
				}
			}
		}
	}
}

// Actually run the scripts that control the interactables
if interactableActive {
	if interactableOpensMenu {
		scr_interactables_with_menu();
	}
	else {
		scr_interactables_with_no_menu();
	}
}


