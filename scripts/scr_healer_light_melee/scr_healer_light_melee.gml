#region
if instance_exists(currentTargetToFocus) {
	if (!hitboxCreated) && (enemyImageIndex > 5) {
		hitboxCreated = true;
		var owner_, target_, point_direction_;
		owner_ = self;
		target_ = currentTargetToFocus;
		
		//Set the point direction the target is in
		point_direction_ = point_direction(x, y, target_.x, target_.y);
		// Create the bullet hitbox itself
		if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
			enemyHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_right_hitbox;
			enemyHitbox.mask_index = spr_player_attack_right_hitbox;
		}
		else if (point_direction_ <= 135) && (point_direction_ > 45) {
			enemyHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_up_hitbox;
			enemyHitbox.mask_index = spr_player_attack_up_hitbox;
		}
		else if (point_direction_ <= 235) && (point_direction_ > 135) {
			enemyHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_left_hitbox;
			enemyHitbox.mask_index = spr_player_attack_left_hitbox;
		}
		else if (point_direction_ <= 315) && (point_direction_ > 235) {
			enemyHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_down_hitbox;
			enemyHitbox.mask_index = spr_player_attack_down_hitbox;
		}
		
		// Set bullet hitbox variables
		enemyHitbox.owner = owner_;
		enemyHitbox.enemyHitboxType = "Melee";
		enemyHitbox.enemyHitboxHeal = false;
		enemyHitbox.enemyHitboxValue = enemyLightMeleeAttackDamage;
		enemyHitbox.enemyHitboxCollisionFound = false;
		enemyHitbox.enemyHitboxLifetime = 1;
		
		// Store bullet ID's in a ds_list for later use (to move and manipulate)
		if ds_exists(obj_combat_controller.enemyHitboxList, ds_type_list) {
			ds_list_set(obj_combat_controller.enemyHitboxList, ds_list_size(obj_combat_controller.enemyHitboxList), enemyHitbox);
		}
		else {
			obj_combat_controller.enemyHitboxList = ds_list_create();
			ds_list_set(obj_combat_controller.enemyHitboxList, 0, enemyHitbox);
		}
	}
}
#endregion

// Send the enemy back to idle state after melee attack has finished
if instance_exists(self) {
	if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}


