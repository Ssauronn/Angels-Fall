///@description SkillshotMagicState
// Create the playerBulletHitbox after frame 2
if instance_exists(obj_player) {
	if (instance_exists(playerBulletHitbox)) && (hitboxCreated == false) {
		instance_destroy(playerBulletHitbox);
	}
	if (hitboxCreated == false) && (playerImageIndex > 6) {
		hitboxCreated = true;
		var owner_ = id;
		var player_x_ = obj_player.x;
		var player_y_ = obj_player.y;
		var mouse_x_ = mouse_x;
		var mouse_y_ = mouse_y;
		switch (playerDirectionFacing) {
			case playerdirection.right:
				playerBulletHitbox = instance_create_depth(x + 32, y, -999, obj_bullet);
				playerBulletHitbox.sprite_index = spr_player_bullet_hitbox;
				playerBulletHitbox.mask_index = spr_player_bullet_hitbox;
				playerBulletHitbox.image_angle = playerBulletHitboxDirection;
				playerBulletHitbox.owner = owner_;
				break;
			case playerdirection.up:
				playerBulletHitbox = instance_create_depth(x, y - 32, -999, obj_bullet);
				playerBulletHitbox.sprite_index = spr_player_bullet_hitbox;
				playerBulletHitbox.mask_index = spr_player_bullet_hitbox;
				playerBulletHitbox.image_angle = playerBulletHitboxDirection;
				playerBulletHitbox.owner = owner_;
				break;
			case playerdirection.left:
				playerBulletHitbox = instance_create_depth(x - 32, y, -999, obj_bullet);
				playerBulletHitbox.sprite_index = spr_player_bullet_hitbox;
				playerBulletHitbox.mask_index = spr_player_bullet_hitbox;
				playerBulletHitbox.image_angle = playerBulletHitboxDirection;
				playerBulletHitbox.owner = owner_;
				break;
			case playerdirection.down:
				playerBulletHitbox = instance_create_depth(x, y + 32, -999, obj_bullet);
				playerBulletHitbox.sprite_index = spr_player_bullet_hitbox;
				playerBulletHitbox.mask_index = spr_player_bullet_hitbox;
				playerBulletHitbox.image_angle = playerBulletHitboxDirection;
				playerBulletHitbox.owner = owner_;
				break;
		}
	}
	// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
	if (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		hitboxCreated = false;
	}
}


