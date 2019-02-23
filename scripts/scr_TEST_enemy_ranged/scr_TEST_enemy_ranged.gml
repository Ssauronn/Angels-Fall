#region Create Bullet Traveling Towards Player
if currentTargetToFocus != noone {
	if instance_exists(currentTargetToFocus) {
		if hitboxCreated == false {
			hitboxCreated = true;
			var owner_ = self;
			var enemy_x_ = x;
			var enemy_y_ = y;
			var player_x_ = currentTargetToFocus.x;
			var player_y_ = currentTargetToFocus.y;
			if ((point_direction(enemy_x_, enemy_y_, player_x_, player_y_) < 45) && (point_direction(enemy_x_, enemy_y_, player_x_, player_y_) >= 0)) || ((point_direction(enemy_x_, enemy_y_, player_x_, player_y_) <= 360) && (point_direction(enemy_x_, enemy_y_, player_x_, player_y_) >= 315)) {
				enemyDirectionFacing = enemydirection.right;
			}
			else if ((point_direction(enemy_x_, enemy_y_, player_x_, player_y_) >= 45) && (point_direction(enemy_x_, enemy_y_, player_x_, player_y_) < 135)) {
				enemyDirectionFacing = enemydirection.up;
			}
			else if ((point_direction(enemy_x_, enemy_y_, player_x_, player_y_) >= 135) && (point_direction(enemy_x_, enemy_y_, player_x_, player_y_) < 225)) {
				enemyDirectionFacing = enemydirection.left;
			}
			else if ((point_direction(enemy_x_, enemy_y_, player_x_, player_y_) >= 225) && (point_direction(enemy_x_, enemy_y_, player_x_, player_y_) < 315)) {
				enemyDirectionFacing = enemydirection.down;
			}
			switch (enemyDirectionFacing) {
				case enemydirection.right: enemyBulletHitbox = instance_create_depth(x + 32, y, -999, obj_bullet);
					break;
				case enemydirection.up: enemyBulletHitbox = instance_create_depth(x, y - 32, -999, obj_bullet);
					break;
				case enemydirection.left: enemyBulletHitbox = instance_create_depth(x - 32, y, -999, obj_bullet);
					break;
				case enemydirection.down: enemyBulletHitbox = instance_create_depth(x, y + 32, -999, obj_bullet);
					break;
			}
			enemyBulletHitbox.sprite_index = spr_enemy_bullet_hitbox;
			enemyBulletHitbox.mask_index = spr_enemy_bullet_hitbox;
			enemyBulletHitbox.image_angle = point_direction(enemy_x_, enemy_y_, player_x_, player_y_);
			enemyBulletHitbox.owner = owner_;
			// Set direction using linear interpolation (lerp function) to guess where the player will be at the moment of firing the projectile - equation boiled down is lerp(bullet.x, bullet.x + player currentSpeed, distance between bullet and player / bulletSpeed (this gives us how many frames it will take to reach the player)
			enemyBulletHitbox.enemyBulletHitboxDirection = point_direction(enemyBulletHitbox.x, enemyBulletHitbox.y, lerp(currentTargetToFocus.x, currentTargetToFocus.x + lengthdir_x(currentTargetToFocus.currentSpeed, currentTargetToFocus.currentDirection), (point_distance(enemyBulletHitbox.x, enemyBulletHitbox.y, currentTargetToFocus.x, currentTargetToFocus.y) / enemyBulletHitboxSpeed)), lerp(currentTargetToFocus.y, currentTargetToFocus.y + lengthdir_y(currentTargetToFocus.currentSpeed, currentTargetToFocus.currentDirection), (point_distance(enemyBulletHitbox.x, enemyBulletHitbox.y, currentTargetToFocus.x, currentTargetToFocus.y) / enemyBulletHitboxSpeed)))
			enemyBulletHitbox.enemyBulletHitboxSpeed = enemyBulletHitboxSpeed;
	
	
			// Create bullets and store their id's in a ds_list for later use
			if ds_exists(obj_combat_controller.enemyBulletHitboxList, ds_type_list) {
				ds_list_set(obj_combat_controller.enemyBulletHitboxList, ds_list_size(obj_combat_controller.enemyBulletHitboxList), enemyBulletHitbox);
			}
			else {
				obj_combat_controller.enemyBulletHitboxList = ds_list_create();
				ds_list_set(obj_combat_controller.enemyBulletHitboxList, 0, enemyBulletHitbox);
			}
		}
	}
}
#endregion

// Send the enemy back to idle state after bullet has been created
if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
	hitboxCreated = false;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
}


