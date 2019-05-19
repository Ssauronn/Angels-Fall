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
		playerHitbox.playerHitboxType = "Projectile";
		playerHitbox.playerHitboxDamageTypeIsBasicMelee = false;
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = playerBulletAttackValue;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = room_speed * 5;
		playerHitbox.playerHitboxCollidedWithWall = false;
		playerHitbox.playerHitboxPersistAfterCollision = false;
		playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
		playerHitbox.playerHitboxTargetArray = noone;
		
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


