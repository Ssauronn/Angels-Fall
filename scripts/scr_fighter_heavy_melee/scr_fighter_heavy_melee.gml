#region
if instance_exists(currentTargetToFocus) {
	if (!hitboxCreated) && (enemyImageIndex > 10) {
		hitboxCreated = true;
		var owner_;
		owner_ = self;
		
		// Create the bullet hitbox itself
		if ((pointDirection <= 45) && (pointDirection >= 0)) || ((pointDirection > 315) && (pointDirection < 360)) {
			enemyHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_right_hitbox;
			enemyHitbox.mask_index = spr_player_attack_right_hitbox;
		}
		else if (pointDirection <= 135) && (pointDirection > 45) {
			enemyHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_up_hitbox;
			enemyHitbox.mask_index = spr_player_attack_up_hitbox;
		}
		else if (pointDirection <= 235) && (pointDirection > 135) {
			enemyHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_left_hitbox;
			enemyHitbox.mask_index = spr_player_attack_left_hitbox;
		}
		else if (pointDirection <= 315) && (pointDirection > 235) {
			enemyHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
			enemyHitbox.sprite_index = spr_player_attack_down_hitbox;
			enemyHitbox.mask_index = spr_player_attack_down_hitbox;
		}
		
		// Set bullet hitbox variables
		enemyHitbox.owner = owner_;
		enemyHitbox.enemyHitboxType = "Melee";
		enemyHitbox.enemyDamageTypeIsBasicMelee = true;
		enemyHitbox.enemyHitboxHeal = false;
		enemyHitbox.enemyHitboxValue = enemyHeavyMeleeAttackDamage;
		enemyHitbox.enemyHitboxCollisionFound = false;
		enemyHitbox.enemyHitboxLifetime = 1;
		enemyHitbox.enemyHitboxCollidedWithWall = false;
		enemyHitbox.enemyHitboxPersistAfterCollision = false;
		enemyHitbox.enemyHitboxTicTimer = enemyHitbox.enemyHitboxLifetime;
		enemyHitbox.enemyHitboxTargetArray = noone;
		
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