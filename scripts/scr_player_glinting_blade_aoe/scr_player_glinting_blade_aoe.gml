function scr_player_glinting_blade_aoe() {
	// Create the playerHitbox after frame 2
	// If the frame count is above 2 and the hitbox hasn't been created yet, create the hitbox
	if (!hitboxCreated) && (playerImageIndex > 2) {
		if ds_exists(objectIDsInBattle, ds_type_list) {
			var i;
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				var target_ = ds_list_find_value(objectIDsInBattle, i);
				if point_distance(target_.x, target_.y, obj_skill_tree.glintingBladeXPos, obj_skill_tree.glintingBladeYPos) <= obj_skill_tree.glintingBladeAoERange {
					create_dot_tic_hitbox(target_, obj_skill_tree.glintingBladeAoEDamage, true);
					// I don't need to type out the next two lines anyways, but I do just as a precaution.
					target_.glintingBladeActive = false;
					target_.glintingBladeTimer = -1;
				}
			}
		}
		hitboxCreated = true;
		// Mark the buff as deactivated inside obj_skill_tree
		obj_skill_tree.glintingBladeActive = false;
		obj_skill_tree.glintingBladeTimer = -1;
		// Reset all other variables located inside obj_skill_tree
		obj_skill_tree.glintingBladeAttachedToEnemy = noone;
		obj_skill_tree.glintingBladeArrivedAtTargetPos = false;
		obj_skill_tree.glintingBladeTargetXPos = 0;
		obj_skill_tree.glintingBladeTargetYPos = 0;
		obj_skill_tree.glintingBladeXPos = 0;
		obj_skill_tree.glintingBladeYPos = 0;
	}
	// If the frame count hits max, that means the animation has ended and its time to reset.
	if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
		playerImageIndex = 0;
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		hitboxCreated = false;
	}





}
