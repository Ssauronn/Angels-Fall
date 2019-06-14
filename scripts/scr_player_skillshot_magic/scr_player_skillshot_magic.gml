///@description SkillshotMagicState
// Move around if needed
obtain_direction();
if (key_right && key_left && !key_down && !key_up) || (!key_right && !key_left && key_up && key_down) {
	apply_friction_to_movement_entity();
}
else if !key_nokey {
	add_movement(maxSpeed, acceleration, point_direction(0, 0, xinput, yinput));
}
else {
	apply_friction_to_movement_entity();
}
move_movement_entity(false);

// Create the playerHitbox after frame 6
if instance_exists(obj_player) {
	if (!hitboxCreated) && (playerImageIndex > 6) {
		hitboxCreated = true;
		var owner_ = id;
		switch (playerDirectionFacing) {
			case playerdirection.right:
				playerHitbox = instance_create_depth(x + lengthdir_x(32, playerHitboxDirection), y + lengthdir_y(32, playerHitboxDirection), -999, obj_hitbox);
				break;
			case playerdirection.up:
				playerHitbox = instance_create_depth(x + lengthdir_x(32, playerHitboxDirection), y + lengthdir_y(32, playerHitboxDirection), -999, obj_hitbox);
				break;
			case playerdirection.left:
				playerHitbox = instance_create_depth(x + lengthdir_x(32, playerHitboxDirection), y + lengthdir_y(32, playerHitboxDirection), -999, obj_hitbox);
				break;
			case playerdirection.down:
				playerHitbox = instance_create_depth(x + lengthdir_x(32, playerHitboxDirection), y + lengthdir_y(32, playerHitboxDirection), -999, obj_hitbox);
				break;
		}
		playerHitbox.sprite_index = spr_player_bullet_hitbox;
		playerHitbox.mask_index = spr_player_bullet_hitbox;
		playerHitbox.image_angle = playerHitboxDirection;
		playerHitbox.owner = owner_;
		playerHitbox.playerProjectileHitboxSpeed = playerProjectileHitboxSpeed;
		playerHitbox.playerHitboxDirection = playerHitboxDirection;
		playerHitbox.playerHitboxAttackType = "Projectile";
		playerHitbox.playerHitboxDamageType = "Ability";
		playerHitbox.playerHitboxAbilityOrigin = "Skillshot Magic";
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = playerBulletAttackValue;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = room_speed * 5;
		playerHitbox.playerHitboxCollidedWithWall = false;
		playerHitbox.playerHitboxPersistAfterCollision = false;
		// The next variable is the timer that determines when an object will apply damage again to
		// an object its colliding with repeatedly. This only takes effect if the hitbox's
		// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
		// destroyed upon colliding with the first object it can and no chance will be given for the
		// hitbox to deal damage repeatedly to the object.
		playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
		playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
		// This is the variable which will be an array of all objects the hitbox has collided with
		// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
		// it has collided with in the first place
		playerHitbox.playerHitboxTargetArray = noone;
		// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
		// that unless that hitbox collides with the exact object its meant for, it won't interact
		// with that object. If the hitbox has no specific target, this is set to noone.
		playerHitbox.playerHitboxSpecificTarget = noone;
		
		if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
			ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
		}
		else {
			obj_combat_controller.playerHitboxList = ds_list_create();
			ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
		}
	}
	// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
	if (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
		if currentSpeed == 0 {
			playerState = playerstates.idle;
			playerStateSprite = playerstates.idle;
			hitboxCreated = false;
		}
		else {
			playerState = playerstates.run;
			playerStateSprite = playerstates.run;
			hitboxCreated = false;
		}
	}
}


