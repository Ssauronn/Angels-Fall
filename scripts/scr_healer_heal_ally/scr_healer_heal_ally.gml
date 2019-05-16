#region Create the Healing Field
if instance_exists(currentTargetToHeal) {
	if (!hitboxCreated) && (enemyImageIndex > 7) {
		// Set hitboxCreated to true so that the enemy only heals objects once in this script
		hitboxCreated = true;
		
		// Set local variables
		var owner_, target_, player_ground_hurtbox_;
		owner_ = self;
		target_ = currentTargetToHeal;
		player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
		// Set the local variable target_ to refer to the ground hurtbox of the target_, not the object itself
		if target_.object_index == obj_player {
			target_ = player_ground_hurtbox_;
		}
		else {
			target_ = target_.enemyGroundHurtbox;
		}
		
		// Set animation variables to their correct, respective values
		enemyAnimationSprite = spr_aoe_heal;
		enemyAnimationImageIndex = 0;
		enemyAnimationX = target_.x;
		enemyAnimationY = target_.y;
		
		// Hitbox information
		enemyHitbox = instance_create_depth(target_.x, target_.y, -999, obj_hitbox);
		enemyHitbox.sprite_index = spr_aoe_heal;
		enemyHitbox.mask_index =spr_aoe_heal;
		enemyHitbox.owner = owner_;
		enemyHitbox.enemyHitboxType = "Target AoE";
		enemyHitbox.enemyDamageTypeIsBasicMelee = false;
		enemyHitbox.enemyHitboxHeal = true;
		enemyHitbox.enemyHitboxValue = enemyHealValue;
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
// Else if the instance to heal doesn't even exist, then just revert back to idle state
else {
	hitboxCreated = false;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	enemyImageIndex = 0;
}
#endregion

// Send the enemy back to idle state after heal has finished
if instance_exists(self) {
	// If the instance calling this state has finished the animation, then revert back to idle state
	if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}


