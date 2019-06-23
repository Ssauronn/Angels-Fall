/// @description Change Dead Body Variables
deadBodyImageIndexSpeed = deadBodyImageIndexBaseSpeed * userInterfaceGameSpeed;

if !obj_combat_controller.levelPaused && !obj_combat_controller.gamePaused {
	if deadBodyImageIndex < (deadBodyNumberOfFramesInDeathAnimation - 1) {
		deadBodyImageIndex += deadBodyImageIndexSpeed;
	}
	else {
		deadBodyImageIndex = deadBodyNumberOfFramesInDeathAnimation - 1;
	}
	if deadBodyBeingResurrected {
		if deadBodyImageIndex >= (sprite_get_number(deadBodyResurrectionSprite) - 1) {
			// Create the new obj_enemy object
			var resurrected_enemy_ = instance_create_depth(x, y, depth, obj_enemy);
			// Assign the newly created object its combat status based on the ID of what resurrected it
			// (the ID of the resurrector is stored at the moment of casting the resurrection in the 
			// variable "deadBodyResurrectedBy")
			if (deadBodyResurrectedBy.object_index == obj_player) || ((deadBodyResurrectedBy.object_index == obj_enemy) && (deadBodyResurrectedBy.combatFriendlyStatus == "Minion")) {
				resurrected_enemy_.combatFriendlyStatus = "Minion";
			}
			else if (deadBodyResurrectedBy.object_index == obj_enemy) && (deadBodyResurrectedBy.combatFriendlyStatus == "Enemy") {
				resurrected_enemy_.combatFriendlyStatus = "Enemy";
			}
			// Assign the archetype and name of the newly created object and reset the
			// "enemyStatsAndSpritesInitialized" variable for that enemy to make sure all variables for
			// that enemy have been created.
			resurrected_enemy_.objectArchetype = objectArchetype;
			resurrected_enemy_.enemyName = enemyName;
			resurrected_enemy_.enemyStatsAndSpritesInitialized = false;
			// Finally, after the new enemy has been created, destroy itself, so that the dead body is no
			// longer there.
			instance_destroy(self);
		}
	}
}

image_index = deadBodyImageIndex;


