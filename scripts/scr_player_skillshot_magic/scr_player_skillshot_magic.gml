///@description SkillshotMagicState
// Create the playerHitbox after frame 2
if instance_exists(obj_player) {
	if (!hitboxCreated) && (playerImageIndex > 6) {
		hitboxCreated = true;
		var owner_ = id;
		var player_x_ = obj_player.x;
		var player_y_ = obj_player.y;
		var mouse_x_ = mouse_x;
		var mouse_y_ = mouse_y;
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
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = 100;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = room_speed * 5;
		
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
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		hitboxCreated = false;
	}
}


