/// Wrath of the Diaboli Attack Script
if !obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget {
	// Set obj_skill_tree variable
	obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget = true;
	var target_to_reference_ = obj_skill_tree.wrathOfTheDiaboliTargetArray[obj_skill_tree.wrathOfTheDiaboliTargetsHit];
	// Stun the enemy
	target_to_reference_.stunActive = true;
	// Set the timer equal to the exact amount of frames the attack will be active for
	target_to_reference_.stunTimer = playerImageIndexSpeed * (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]));
	// Set player variables
	playerDirectionFacing = target_to_reference_.enemyDirectionFacing;
	switch (target_to_reference_.enemyDirectionFacing) {
		case enemydirection.right: 
			x = target_to_reference_.x - (32 * 1.5);
			y = target_to_reference_.y;
			break;
		case enemydirection.up: 
			x = target_to_reference_.x;
			y = target_to_reference_.y + (32 * 1.5);
			break;
		case enemydirection.left: 
			x = target_to_reference_.x + (32 * 1.5);
			y = target_to_reference_.y;
			break;
		case enemydirection.down: 
			x = target_to_reference_.x;
			y = target_to_reference_.y - (32 * 1.5);
			break;
	}
}
// Create the playerHitbox after frame 2
if instance_exists(obj_player) {
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
		playerHitbox.playerHitboxAbilityOrigin = "Wrath of the Diaboli";
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = obj_skill_tree.wrathOfTheDiaboliDamage;
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

	// Return to idle playerState if the player has hit all targets possible and has finished attacking the last target
	if ((obj_skill_tree.wrathOfTheDiaboliTargetsHit + 1) == obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount) && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
		invincibile = false;
		x = obj_skill_tree.wrathOfTheDiaboliStartXPos;
		y = obj_skill_tree.wrathOfTheDiaboliStartYPos;
		playerDirectionFacing = obj_skill_tree.wrathOfTheDiaboliStartDirection;
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		hitboxCreated = false;
		obj_skill_tree.wrathOfTheDiaboliActive = false;
		obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount = 0;
		obj_skill_tree.wrathOfTheDiaboliTargetArray = noone;
		obj_skill_tree.wrathOfTheDiaboliTargetsHit = 0;
		obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget = false;
	}
	// Else if the player hasn't yet finished attacking all targets, then move to the next target and attack
	else if ((obj_skill_tree.wrathOfTheDiaboliTargetsHit + 1) < obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount) && (playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1)) {
		// Reset script, count up on targetsHit, reset necessary variables, and reset imageIndex
		obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget = false;
		obj_skill_tree.wrathOfTheDiaboliTargetsHit++;
		hitboxCreated = false;
		playerImageIndex = 0;
	}
}






