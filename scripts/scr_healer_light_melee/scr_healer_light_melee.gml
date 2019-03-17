#region
if instance_exists(currentTargetToFocus) {
	if (!hitboxCreated) && (enemyImageIndex > 5) {
		hitboxCreated = true;
		var owner_, target_, point_direction_;
		owner_ = self;
		target_ = currentTargetToFocus;
		point_direction_ = point_direction(x, y, target_.x, target_.y);
		enemyHitbox = instance_create_depth(x + lengthdir_x(32, point_direction_), y + lengthdir_y(32, point_direction_), -999, obj_hitbox);
	}
}
#endregion

// Send the enemy back to idle state after melee attack has finished
if instance_exists(self) {
	if (enemyImageIndex <= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing] - 1)) {
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
	}
}


