#region Create The Projectile
if instance_exists(currentTargetToFocus) {
	if (!hitboxCreated) && (enemyImageIndex > 9) {
		hitboxCreated = true;
		var owner_, target_;
		owner_ = self;
		target_= currentTargetToFocus;
		
		// Set direction using linear interpolation (lerp function) to guess where the player will be at the moment of firing the projectile - equation boiled down is lerp(bullet.x, bullet.x + player currentSpeed, distance between bullet and player / bulletSpeed (this gives us how many frames it will take to reach the player)
		var point_direction_ = point_direction(x, y, lerp(target_.x, target_.x + lengthdir_x(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)), lerp(target_.y, target_.y + lengthdir_y(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)));
		// Create the bullet hitbox itself
		enemyHitbox = instance_create_depth(x + lengthdir_x(32, point_direction_), y + lengthdir_y(32, point_direction_), -999, obj_hitbox);
		
		// Set bullet hitbox variables
		enemyHitbox.sprite_index = spr_enemy_bullet_hitbox;
		enemyHitbox.mask_index = spr_enemy_bullet_hitbox;
		enemyHitbox.image_angle = point_direction(owner_.x, owner_.y, target_.x, target_.y);
		enemyHitbox.owner = owner_;
		enemyHitbox.enemyHitboxType = "Projectile";
		enemyHitbox.enemyHitboxHeal = false;
		enemyHitbox.enemyProjectileHitboxDirection = point_direction_;
		enemyHitbox.enemyProjectileHitboxSpeed = enemyProjectileHitboxSpeed;
		enemyHitbox.enemyHitboxValue = enemyLightRangedAttackDamage;
		enemyHitbox.enemyHitboxCollisionFound = false;
		enemyHitbox.enemyHitboxLifetime = room_speed * 5;
		enemyHitbox.enemyHitboxCollidedWithWall = false;
		enemyHitbox.enemyHitboxPersistAfterCollision = false;
		
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
else {
	hitboxCreated = false;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	enemyImageIndex = 0;
}
#endregion

// Send the enemy back to idle state after ranged attack has finished
if instance_exists(self) {
	if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}


