///@argument0TargetEnemyID
///@argument1 TotalTicDamage
///@argument2 CanBeTransferredThroughSoulTether
function create_dot_tic_hitbox(argument0, argument1, argument2) {
	var target_enemy_, total_damage_, can_be_transferred_to_others_;
	target_enemy_ = argument0;
	total_damage_ = argument1;
	can_be_transferred_to_others_ = argument2;
	with obj_player {
	#region Create Whole Hitbox
		playerHitbox = instance_create_depth(target_enemy_.x, target_enemy_.y, -999, obj_hitbox);
		playerHitbox.sprite_index = spr_single_hit;
		playerHitbox.mask_index = spr_single_hit;
		playerHitbox.owner = self.id;
		playerHitbox.playerHitboxAttackType = "DoT Tic";
		playerHitbox.playerHitboxDamageType = "Ability";
		playerHitbox.playerHitboxAbilityOrigin = "DoT Tic";
		playerHitbox.playerHitboxHeal = false;
		playerHitbox.playerHitboxValue = total_damage_;
		playerHitbox.playerHitboxCollisionFound = false;
		playerHitbox.playerHitboxLifetime = 1;
		playerHitbox.playerHitboxCollidedWithWall = false;
		playerHitbox.playerHitboxPersistAfterCollision = false;
		// The next variable is the timer that determines when an object will apply damage again to
		// an object its colliding with repeatedly. This only takes effect if the hitbox's
		// PersistAfterCollision variable (set above) is set to true. Otherwise, the hitbox will be
		// destroyed upon colliding with the first object it can and no chance will be given for the
		// hitbox to deal damage repeatedly to the object.
		playerHitbox.playerHitboxTicTimer = 1;
		playerHitbox.playerHitboxCanBeTransferredThroughSoulTether = can_be_transferred_to_others_;
		// This is the variable which will be an array of all objects the hitbox has collided with
		// during its lifetime, counting down the previously set playerHitboxTicTimer for each object
		// it has collided with in the first place
		playerHitbox.playerHitboxTargetArray = noone;
		// If the hitbox has a specific target to hit, this variable will be set to that ID, meaning
		// that unless that hitbox collides with the exact object its meant for, it won't interact
		// with that object. If the hitbox has no specific target, this is set to noone.
		playerHitbox.playerHitboxSpecificTarget = target_enemy_;
		
		if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
			ds_list_set(obj_combat_controller.playerHitboxList, ds_list_size(obj_combat_controller.playerHitboxList), playerHitbox);
		}
		else {
			obj_combat_controller.playerHitboxList = ds_list_create();
			ds_list_set(obj_combat_controller.playerHitboxList, 0, playerHitbox);
		}
	#endregion
	}





}
