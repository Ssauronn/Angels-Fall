// If Glinting Blade is active before hitbox can be created, that means glinting blade was already
// active, and I need to handle it as such.
if playerImageIndex <= 5 {
	if obj_skill_tree.glintingBladeActive {
		// If Glinting Blade is attached to an enemy, then teleport to that enemy and apply damages
		if instance_exists(obj_skill_tree.glintingBladeAttachedToEnemy) {
			// Send player to new alternate attack state to teleport to the target and apply damage to 
			// that one enemy, deactivate all glinting blade variables, deactivate all Glinting Blade
			// variables on the target enemy, then send player back to idle state.
			// I apply damages to the one enemy and send player back to the idle state in the next script.
			var target_ = obj_skill_tree.glintingBladeAttachedToEnemy;
			playerImageIndex = 0;
			playerState = playerstates.glintingbladesingle;
			playerStateSprite = playerstates.glintingbladesingle;
			// This works because of the way enums work - I'm really just setting the direction equal
			// to the value the enum is equal to, and since both playerDirectionFacing and
			// enemyDirectionFacing have identical valued enums, even though they're named differently
			// they're still set the same way.
			playerDirectionFacing = target_.enemyDirectionFacing;
			switch (target_.enemyDirectionFacing) {
				case enemydirection.right:
					x = target_.x - (32 * 1.5);
					y = target_.y;
					break;
				case enemydirection.up:
					x = target_.x;
					y = target_.y + (32 * 1.5);
					break;
				case enemydirection.left:
					x = target_.x + (32 * 1.5);
					y = target_.y;
					break;
				case enemydirection.down:
					x = target_.x;
					y = target_.y - (32 * 1.5);
					break;
			}
			// I add just 3 onto the enemy timer so that the timer doesn't run out the exact moment
			// the player is supposed to deal damage, and reset variables so that the script throws
			// an error. Essentially lets the debuff last for 3 more frames, which is needed because 
			// there's a hitbox that's created 3 frames after these lines are run.
			target_.glintingBladeTimer += 3;
		}
		// Else if Glinting Blade is not attached to an enemy, then teleport to Glinting Blade's location
		// and deal AoE damage to anything around
		else {
			playerImageIndex = 0;
			// Send player to new alternate state to teleport to the target and apply AoE damage to
			// anything around, deactivate all glinting blade variables, then send player back to idle
			// state.
		}
	}
}
// if Glinting Blade isn't active before hitbox can be created, that means Glinting Blade can be created
// as a projectile.
if (!hitboxCreated) && (playerImageIndex > 5) {
	hitboxCreated = true;
	// Set the direction the player will face, and the direction the hitbox will face as well.
	// Then create the hitbox.
	var dir_ = point_direction(x, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos);
	var point_direction_;
	if dir_ >= 45 && dir_ < 135 {
		playerDirectionFacing = playerdirection.up;
		point_direction_ = point_direction(x, y - 32, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos)
		playerHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
	}
	else if dir_ >= 315 && dir_ < 360 {
		playerDirectionFacing = playerdirection.right;
		point_direction_ = point_direction(x + 32, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos)
		playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
	}
	else if dir_ >= 0 && dir_ < 45 {
		playerDirectionFacing = playerdirection.right;
		point_direction_ = point_direction(x + 32, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos)
		playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
	}
	else if dir_ >= 225 && dir_ < 315 {
		playerDirectionFacing = playerdirection.down;
		point_direction_ = point_direction(x, y + 32, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos)
		playerHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
	}
	else if dir_ >= 135 && dir_ < 225 {
		playerDirectionFacing = playerdirection.left;
		point_direction_ = point_direction(x - 32, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos)
		playerHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
	}
	
	// Set bullet hitbox variables
	playerHitbox.sprite_index = spr_glinting_blade_projectile;
	playerHitbox.mask_index = spr_glinting_blade_projectile;
	playerHitbox.image_angle = point_direction(x, y, obj_skill_tree.glintingBladeTargetXPos, obj_skill_tree.glintingBladeTargetYPos);
	playerHitbox.owner = self;
	playerHitbox.playerHitboxAttackType = "Projectile";
	playerHitbox.playerHitboxDamageType = "Ability";
	playerHitbox.playerHitboxAbilityOrigin = "Glinting Blade";
	playerHitbox.playerHitboxHeal = false;
	playerHitbox.playerProjectileHitboxDirection = point_direction_;
	obj_skill_tree.glintingBladeDirection = point_direction_;
	playerHitbox.playerProjectileHitboxSpeed = obj_skill_tree.glintingBladeSpeed;
	playerHitbox.playerHitboxValue = obj_skill_tree.glintingBladeDamage;
	playerHitbox.playerHitboxCollisionFound = false;
	playerHitbox.playerHitboxLifetime = room_speed * 5;
	playerHitbox.playerHitboxCollidedWithWall = false;
	playerHitbox.playerHitboxPersistAfterCollision = false;
	// The next variable is the timer that determines when an object will apply damage again to
	// an object its colliding with repeatedly. This only takes effect if the hitbox's
	// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
	// destroyed upon colliding with the first object it can and no chance will be given for the
	// hitbox to deal damage repeatedly to the object.
	playerHitbox.playerHitboxTicTimer = playerHitbox.playerHitboxLifetime;
	playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = true;
	// This is the variable which will be an array of all objects the hitbox has collided with
	// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
	// it has collided with in the first place
	playerHitbox.playerHitboxTargetArray = noone;
	// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
	// that unless that hitbox collides with the exact object its meant for, it won't interact
	// with that object. If the hitbox has no specific target, this is set to noone.
	playerHitbox.playerHitboxSpecificTarget = noone;
	
	// Store bullet ID's in a ds_list for later use (to move and manipulate)
	if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
		ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
	}
	else {
		obj_combat_controller.playerHitboxList = ds_list_create();
		ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
	}
}
if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
	playerState = playerstates.idle;
	playerStateSprite = playerstates.idle;
	hitboxCreated = false;
}


