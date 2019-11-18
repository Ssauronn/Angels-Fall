// If Glinting Blade is active before hitbox can be created, that means glinting blade was already
// active, and I need to handle it as such.
if playerImageIndex <= 5 {
	// Check to see if Glinting Blade is active either on the ground, or active on an enemy.
	var j;
	var glinting_blade_active_ = false;
	// If its active on the ground, we don't have to check for activity on an enemy.
	if obj_skill_tree.glintingBladeActive {
		glinting_blade_active_ = true;
	}
	// Otherwise, if its not active on the ground, we do need to check for activity on an enemy
	// in battle.
	else {
		if ds_exists(objectIDsInBattle, ds_type_list) {
			for (j = 0; j <= ds_list_size(objectIDsInBattle) - 1; j++) {
				var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, j);
				if instance_to_reference_.glintingBladeActive {
					glinting_blade_active_ = true;
				}
			}
		}
	}
	// If Glinting Blade is active either on the ground, OR on an enemy, then send the player to the 
	// correct attack script and finish out the Glinting Blade debuff/buff.
	if glinting_blade_active_ {
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
					with playerGroundHurtbox {
						obj_player.playerDirectionFacing += teleport_to_nearest_empty_location(target_.x - (32 * 1.5), target_.y + 13, target_.x, target_.y + 13, obj_ground_hurtbox, obj_wall);
					}
					break;
				case enemydirection.up:
					with playerGroundHurtbox {
						obj_player.playerDirectionFacing += teleport_to_nearest_empty_location(target_.x, target_.y + (32 * 1.5) + 13, target_.x, target_.y + 13, obj_ground_hurtbox, obj_wall);
					}
					break;
				case enemydirection.left:
					with playerGroundHurtbox {
						obj_player.playerDirectionFacing += teleport_to_nearest_empty_location(target_.x + (32 * 1.5), target_.y + 13, target_.x, target_.y + 13, obj_ground_hurtbox, obj_wall);
					}
					break;
				case enemydirection.down:
					with playerGroundHurtbox {
						obj_player.playerDirectionFacing += teleport_to_nearest_empty_location(target_.x, target_.y - (32 * 1.5) + 13, target_.x, target_.y + 13, obj_ground_hurtbox, obj_wall);
					}
					break;
			}
			if playerDirectionFacing > 3 {
				playerDirectionFacing -= 4;
			}
			else if playerDirectionFacing < 0 {
				playerDirectionFacing += 4;
			}
			// I add just 3 onto the enemy timer so that the timer doesn't run out the exact moment
			// the player is supposed to deal damage, and reset variables so that the script throws
			// an error. Essentially lets the debuff last for 3 more frames, which is needed because 
			// there's a hitbox that's created 3 frames after these lines are run.
			target_.glintingBladeTimer += 3;
			// Stun the target as the player attacks, so that the target cannot rotate
			// to immediately react with an attack
			target_.stunActive = true;
			target_.stunTimer = room_speed * 1;
		}
		// Else if Glinting Blade is not attached to an enemy, then teleport to Glinting Blade's location
		// and deal AoE damage to anything around
		else {
			// Send player to new alternate state to teleport to the target and apply AoE damage to
			// anything around, deactivate all glinting blade variables, then send player back to idle
			// state.
			playerImageIndex = 0;
			var target_location_x_ = obj_skill_tree.glintingBladeTargetXPos;
			var target_location_y_ = obj_skill_tree.glintingBladeTargetYPos;
			playerState = playerstates.glintingbladeaoe;
			playerStateSprite = playerstates.glintingbladeaoe;
			var point_direction_ = point_direction(x, y, target_location_x_, target_location_y_);
			if point_direction_ >= 45 && point_direction_ < 135 {
				playerDirectionFacing = playerdirection.up;
			}
		    else if point_direction_ >= 315 && point_direction_ < 360 {
				playerDirectionFacing = playerdirection.right;
			}
		    else if point_direction_ >= 0 && point_direction_ < 45 {
				playerDirectionFacing = playerdirection.right;
			}
		    else if point_direction_ >= 225 && point_direction_ < 315 {
				playerDirectionFacing = playerdirection.down;
			}
		    else if point_direction_ >= 135 && point_direction_ < 225 {
				playerDirectionFacing = playerdirection.left;
			}
			with playerGroundHurtbox {
				teleport_to_nearest_empty_location(target_location_x_, target_location_y_, target_location_x_, target_location_y_ + 13, obj_wall, obj_ground_hurtbox);
			}
			//teleport_to_nearest_empty_location(target_location_x_, target_location_y_, target_location_x_, target_location_y_ + 17, obj_wall, obj_ground_hurtbox);
			// I add just 3 onto the enemy timer so that the timer doesn't run out the exact moment
			// the player is supposed to deal damage, and reset variables so that the script throws
			// an error. Essentially lets the debuff last for 3 more frames, which is needed because 
			// there's a hitbox that's created 3 frames after these lines are run.
			obj_skill_tree.glintingBladeTimer += 3;
		}
	}
	else if (playerCurrentStamina < obj_skill_tree.glintingBladeStaminaCost) || (playerCurrentMana < obj_skill_tree.glintingBladeManaCost) {
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		hitboxCreated = false;
	}
}
// if Glinting Blade isn't active before hitbox can be created, that means Glinting Blade can be created
// as a projectile.
if (!hitboxCreated) && (playerImageIndex > 5) {
	playerCurrentStamina -= obj_skill_tree.glintingBladeStaminaCost;
	playerCurrentStamina += obj_skill_tree.glintingBladeStaminaRegen;
	playerCurrentMana -= obj_skill_tree.glintingBladeManaCost;
	playerCurrentMana += obj_skill_tree.glintingBladeManaRegen;
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


