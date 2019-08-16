/*
First, move the player using dash script code towards the enemy, and stun the enemy while the player
is moving.
Include a timer, so that the player doesn't get stuck in a dash state forever if there is, for
example, a wall in the way.
Check if player is in melee range.
Once player is in melee range, set playerDirectionFacing one more time, just to make sure, and then
execute ability attack.
Depending on whether the player dashed or not, apply the melee or ranged damage to the hitbox. In
addition, also activate the dash damage multiplier in case the player did in fact dash (the dash
multiplier will be active until the next attack is executed).
Set rushdownDashed equal to false at the end of the script regardless of what happens, as well as 
resetting rushdownDashTimer to -1.
*/
var target_ = obj_skill_tree.rushdownTarget;
if instance_exists(target_) {
	// Move the player towards the target if needed
	if obj_skill_tree.rushdownDashed {
		// As long as the player still has time left to dash towards the target
		if obj_skill_tree.rushdownDashTimer > 0 {
			if point_distance(x, y, target_.x, target_.y) > obj_skill_tree.rushdownMeleeRange {
				// Stun the target, and set the sprite of the player equal to playerStateSprite for
				// as long as the player is dashing towards the target
				target_.stunActive = true;
				target_.stunTimer = 2;
				playerStateSprite = playerstates.dash;
				// Actually move the player
				currentSpeed = dashSpeed * playerTotalSpeed;
				currentDirection = point_direction(x, y, target_.x, target_.y);
				frictionAmount = baseFrictionAmount * (dashSpeed / maxSpeed) * playerTotalSpeed;
				move_movement_entity(false);
			}
		}
	}
	// If the player is not in the correct animation (meaning it has been dashing) - and the dash
	// has ended because the player couldn't reach its target, or the player reached its target, set
	// variables in preparation for hitbox creation
	if (playerStateSprite != playerstates.rushdown) && (((obj_skill_tree.rushdownDashTimer < 0) && (obj_skill_tree.rushdownDashed)) || (point_distance(x, y, target_.x, target_.y) <= obj_skill_tree.rushdownMeleeRange)) {
		obj_skill_tree.rushdownDashTimer = -1;
		playerImageIndex = 0;
		playerStateSprite = playerstates.rushdown;
		currentSpeed = 0;
		var dir_ = point_direction(x, y, target_.x, target_.y);
		if dir_ >= 45 && dir_ < 135 {
			playerDirectionFacing = playerdirection.up;
		}
		else if dir_ >= 315 && dir_ < 360 {
			playerDirectionFacing = playerdirection.right;
		}
		else if dir_ >= 0 && dir_ < 45 {
			playerDirectionFacing = playerdirection.right;
		}
		else if dir_ >= 225 && dir_ < 315 {
			playerDirectionFacing = playerdirection.down;
		}
		else if dir_ >= 135 && dir_ < 225 {
			playerDirectionFacing = playerdirection.left;
		}
	}
	// I check for this to create the hitbox, because the playerStateSprite, by the time this line
	// is read, will only be equal to playerstates.rushdown if the player is able to execute the attack.
	if playerStateSprite == playerstates.rushdown {
		// Create the hitbox if past frame 2
		if (!hitboxCreated) && (playerImageIndex > 2) {
			hitboxCreated = true;
			var owner_ = self;
			switch (playerDirectionFacing) {
				case playerdirection.right:
					playerHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
					playerHitbox.sprite_index = spr_player_attack_right_hitbox;
					playerHitbox.mask_index = spr_player_attack_right_hitbox;
					break;
				case playerdirection.up:
					playerHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
					playerHitbox.sprite_index = spr_player_attack_up_hitbox;
					playerHitbox.mask_index = spr_player_attack_up_hitbox;
					break;
				case playerdirection.left:
					playerHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
					playerHitbox.sprite_index = spr_player_attack_left_hitbox;
					playerHitbox.mask_index = spr_player_attack_left_hitbox;
					break;
				case playerdirection.down:
					playerHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
					playerHitbox.sprite_index = spr_player_attack_down_hitbox;
					playerHitbox.mask_index = spr_player_attack_down_hitbox;
					break;
			}
			playerHitbox.owner = owner_;
			playerHitbox.playerHitboxAttackType = "Melee";
			playerHitbox.playerHitboxDamageType = "Basic Melee";
			playerHitbox.playerHitboxAbilityOrigin = "Rushdown";
			playerHitbox.playerHitboxHeal = false;
			if obj_skill_tree.rushdownDashed {
				playerHitbox.playerHitboxValue = obj_skill_tree.rushdownDashDamage;
			}
			else {
				playerHitbox.playerHitboxValue = obj_skill_tree.rushdownMeleeDamage;
			}
			playerHitbox.playerHitboxCollisionFound = false;
			playerHitbox.playerHitboxLifetime = 1;
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
			obj_skill_tree.rushdownDashDamageMultiplierActive = true;
			obj_skill_tree.rushdownDashed = false;
			obj_skill_tree.rushdownDashTimer = -1;
		}
	}
}
else {
	playerState = playerstates.idle;
	playerStateSprite = playerstates.idle;
	hitboxCreated = false;
	obj_skill_tree.rushdownDashDamageMultiplierActive = false;
	obj_skill_tree.rushdownDashed = false;
	obj_skill_tree.rushdownDashTimer = -1;
}


