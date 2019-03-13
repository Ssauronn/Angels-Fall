#region Create The Projectile
if instance_exists(currentTargetToFocus) {
	if (!hitboxCreated) && (enemyImageIndex > 5) {
		hitboxCreated = true;
		var owner_, target_;
		owner_ = self;
		target_= currentTargetToFocus;
		// Set direction using linear interpolation (lerp function) to guess where the player will be at the moment of firing the projectile - equation boiled down is lerp(bullet.x, bullet.x + player currentSpeed, distance between bullet and player / bulletSpeed (this gives us how many frames it will take to reach the player)
		var point_direction_ = point_direction(x, y, lerp(target_.x, target_.x + lengthdir_x(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyBulletHitboxSpeed)), lerp(target_.y, target_.y + lengthdir_y(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyBulletHitboxSpeed)));
		// Create the bullet hitbox itself
		if ((point_direction_ <= 45) && (point_direction_ >= 0)) || ((point_direction_ > 315) && (point_direction_ < 360)) {
			enemyBulletHitbox = instance_create_depth(x + 32, y, -999, obj_bullet);
		}
		else if (point_direction_ <= 135) && (point_direction_ > 45) {
			enemyBulletHitbox = instance_create_depth(x, y - 32, -999, obj_bullet);
		}
		else if (point_direction_ <= 235) && (point_direction_ > 135) {
			enemyBulletHitbox = instance_create_depth(x - 32, y, -999, obj_bullet);
		}
		else if (point_direction_ <= 315) && (point_direction_ > 235) {
			enemyBulletHitbox = instance_create_depth(x, y + 32, -999, obj_bullet);
		}
		// Set bullet hitbox variables
		enemyBulletHitbox.sprite_index = spr_enemy_bullet_hitbox;
		enemyBulletHitbox.mask_index = spr_enemy_bullet_hitbox;
		enemyBulletHitbox.image_angle = point_direction(owner_.x, owner_.y, target_.x, target_.y);
		enemyBulletHitbox.owner = owner_;
		enemyBulletHitbox.enemyBulletHitboxDirection = point_direction_;
		enemyBulletHitbox.enemyBulletHitboxSpeed = enemyBulletHitboxSpeed;
		
		
		
		// Store bullet ID's in a ds_list for later use (to move and manipulate)
		if ds_exists(obj_combat_controller.enemyBulletHitboxList, ds_type_list) {
			ds_list_set(obj_combat_controller.enemyBulletHitboxList, ds_list_size(obj_combat_controller.enemyBulletHitboxList), enemyBulletHitbox);
		}
		else {
			obj_combat_controller.enemyBulletHitboxList = ds_list_create();
			ds_list_set(obj_combat_controller.enemyBulletHitboxList, 0, enemyBulletHitbox);
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

// Send the enemy back to idle state after bullet has been created
if instance_exists(self) {
	if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}


