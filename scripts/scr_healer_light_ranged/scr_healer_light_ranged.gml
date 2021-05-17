function scr_healer_light_ranged() {
#region Create The Projectile
	if instance_exists(currentTargetToFocus) {
		if (!hitboxCreated) && (enemyImageIndex > 5) {
			hitboxCreated = true;
			var owner_, target_;
			owner_ = self.id;
			target_= currentTargetToFocus;
		
			// Set direction using linear interpolation (lerp function) to guess where the player will be at the moment of firing the projectile - equation boiled down is lerp(bullet.x, bullet.x + player currentSpeed, distance between bullet and player / bulletSpeed (this gives us how many frames it will take to reach the player)
			// If the lerp target is not within line of sight however (a wall is blocking target location)
			// then just fire the projectile normally. This should positively effect the intelligence of
			// the "Aiming AI".
			if !collision_line(x, y, lerp(target_.x, target_.x + lengthdir_x(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)), lerp(target_.y, target_.y + lengthdir_y(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)), obj_wall, true, true) {
				var point_direction_ = point_direction(x, y, lerp(target_.x, target_.x + lengthdir_x(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)), lerp(target_.y, target_.y + lengthdir_y(target_.currentSpeed, target_.currentDirection), (point_distance(x, y, target_.x, target_.y) / enemyProjectileHitboxSpeed)));
			}
			else {
				var point_direction_ = point_direction(x, y, target_.x, target_.y);
			}
			// And then, after determining this, if the target ends up trying to hide in a wall, set the new
			// point_direction_ equal to the ground hurtbox of the target, so the enemy won't hit the wall in
			// case the enemy is at a shallow angle, close to the wall.
			if collision_point(target_.x, target_.y, obj_wall, true, true) {
				var target_ground_hurtbox_;
				if target_.object_index == obj_player {
					target_ground_hurtbox_ = target_.playerGroundHurtbox;
				}
				else if target_.object_index == obj_enemy {
					target_ground_hurtbox_ = target_.enemyGroundHurtbox;
				}
				point_direction_ = point_direction(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y);
			}
			// Create the bullet hitbox itself
			enemyHitbox = instance_create_depth(x + lengthdir_x(32, point_direction_), y + lengthdir_y(32, point_direction_), -999, obj_hitbox);
		
			// Set bullet hitbox variables
			enemyHitbox.sprite_index = spr_enemy_bullet_hitbox;
			enemyHitbox.mask_index = spr_enemy_bullet_hitbox;
			enemyHitbox.image_angle = point_direction(owner_.x, owner_.y, target_.x, target_.y);
			enemyHitbox.owner = owner_;
			enemyHitbox.enemyHitboxAttackType = "Projectile";
			enemyHitbox.enemyHitboxDamageType = "Ability";
			enemyHitbox.enemyHitboxAbilityOrigin = "Skillshot Magic";
			enemyHitbox.enemyHitboxHeal = false;
			enemyHitbox.enemyProjectileHitboxDirection = point_direction_;
			enemyHitbox.enemyProjectileHitboxSpeed = enemyProjectileHitboxSpeed;
			enemyHitbox.enemyHitboxValue = enemyLightRangedAttackDamage;
			enemyHitbox.enemyHitboxCollisionFound = false;
			enemyHitbox.enemyHitboxLifetime = room_speed * 5;
			enemyHitbox.enemyHitboxCollidedWithWall = false;
			enemyHitbox.enemyHitboxPersistAfterCollision = false;
			// The next variable is the timer that determines when an object will apply damage again to
			// an object its colliding with repeatedly. This only takes effect if the hitbox's
			// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
			// destroyed upon colliding with the first object it can and no chance will be given for the
			// hitbox to deal damage repeatedly to the object.
			enemyHitbox.enemyHitboxTicTimer = enemyHitbox.enemyHitboxLifetime;
			enemyHitbox.enemyHitboxCanBeTransferredThroughSoulTether = true;
			// This is the variable which will be an array of all objects the hitbox has collided with
			// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
			// it has collided with in the first place
			enemyHitbox.enemyHitboxTargetArray = noone;
			// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
			// that unless that hitbox collides with the exact object its meant for, it won't interact
			// with that object. If the hitbox has no specific target, this is set to noone.
			enemyHitbox.enemyHitboxSpecificTarget = noone;
		
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
	if instance_exists(self.id) {
		if (enemyImageIndex >= sprite_get_number(enemySprite[enemyStateSprite, enemyDirectionFacing]) - 1) {
			hitboxCreated = false;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
			enemyImageIndex = 0;
		}
	}

	// If the object is stunned, immediately send this object to the stun script
	if stunActive {
		hitboxCreated = false;
		enemyState = enemystates.stunned;
		enemyStateSprite = enemystates.stunned;
		enemyImageIndex = 0;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	}

	if forceReturnToIdleState {
		forceReturnToIdleState = false;
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
		hitboxCreated = false;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		enemyImageIndex = 0;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	}





}
