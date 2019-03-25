/// Targeting engine for minion healers out of combat
// Check to make sure combat is not active
if !ds_exists(objectIDsInBattle, ds_type_list) {
	// Check to make sure there are objects following the player
	if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
		// Set up local variables we'll be manipulating
		var i, instance_to_reference_, object_to_target_, potential_targets_hp_percentage_;
		object_to_target_ = noone;
		// Set default target hp percentage to the player hp percentage
		potential_targets_hp_percentage_ = playerCurrentHP / playerMaxHP;
		// As long as the player isn't full hp, set the object to target equal to the player
		if potential_targets_hp_percentage_ != 1 {
			object_to_target_ = obj_player;
		}
		for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
			instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
			// If any object has less health than the previously set heal target, then set that object
			// as the new heal target.
			if (instance_to_reference_.enemyCurrentHP / instance_to_reference_.enemyMaxHP) < potential_targets_hp_percentage_ {
				potential_targets_hp_percentage_ = (instance_to_reference_.enemyCurrentHP / instance_to_reference_.enemyMaxHP);
				object_to_target_ = instance_to_reference_;
			}
		}
		// If a heal target exists
		if object_to_target_ != noone {
			currentTargetToHeal = object_to_target_;
		}
		// Else if no heal target exists, then reset variables and send object back to idle state
		if potential_targets_hp_percentage_ == 1 {
			chosenEngine = "";
			decisionMadeForTargetAndAction = false;
			enemyImageIndex = 0;
			alreadyTriedToChaseTimer = 0;
			alreadyTriedToChase = false;
			enemyTimeUntilNextManaAbilityUsableTimer = 0;
			enemyTimeUntilNextManaAbilityUsableTimerSet = false;
			enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
			enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
		}
	}
}


