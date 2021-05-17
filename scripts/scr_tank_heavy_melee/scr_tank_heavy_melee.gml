function scr_tank_heavy_melee() {
#region
	if instance_exists(currentTargetToFocus) {
		if (!hitboxCreated) && (enemyImageIndex > 15) {
			hitboxCreated = true;
			var owner_;
			owner_ = self.id;
		
			// Create the bullet hitbox itself
			if ((pointDirection <= 45) && (pointDirection >= 0)) || ((pointDirection > 315) && (pointDirection < 360)) {
				enemyHitbox = instance_create_depth(x + 32, y, -999, obj_hitbox);
				enemyHitbox.sprite_index = spr_player_attack_right_hitbox;
				enemyHitbox.mask_index = spr_player_attack_right_hitbox;
			}
			else if (pointDirection <= 135) && (pointDirection > 45) {
				enemyHitbox = instance_create_depth(x, y - 32, -999, obj_hitbox);
				enemyHitbox.sprite_index = spr_player_attack_up_hitbox;
				enemyHitbox.mask_index = spr_player_attack_up_hitbox;
			}
			else if (pointDirection <= 235) && (pointDirection > 135) {
				enemyHitbox = instance_create_depth(x - 32, y, -999, obj_hitbox);
				enemyHitbox.sprite_index = spr_player_attack_left_hitbox;
				enemyHitbox.mask_index = spr_player_attack_left_hitbox;
			}
			else if (pointDirection <= 315) && (pointDirection > 235) {
				enemyHitbox = instance_create_depth(x, y + 32, -999, obj_hitbox);
				enemyHitbox.sprite_index = spr_player_attack_down_hitbox;
				enemyHitbox.mask_index = spr_player_attack_down_hitbox;
			}
		
			// Set bullet hitbox variables
			enemyHitbox.owner = owner_;
			enemyHitbox.enemyHitboxAttackType = "Melee";
			enemyHitbox.enemyHitboxDamageType = "Basic Melee";
			enemyHitbox.enemyHitboxAbilityOrigin = "Melee Attack";
			enemyHitbox.enemyHitboxHeal = false;
			enemyHitbox.enemyHitboxValue = enemyHeavyMeleeAttackDamage;
			enemyHitbox.enemyHitboxCollisionFound = false;
			enemyHitbox.enemyHitboxLifetime = 1;
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
#endregion

	// Send the enemy back to idle state after melee attack has finished
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
