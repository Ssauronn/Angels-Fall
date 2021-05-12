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
			obj_skill_tree.ritualOfDeathActive = instance_create_depth(x, y, depth, obj_enemy);
			var resurrected_enemy_ = obj_skill_tree.ritualOfDeathActive;
			// Assign the archetype and name of the newly created object and reset the
			// "enemyStatsAndSpritesInitialized" variable for that enemy to make sure all variables for
			// that enemy have been created.
			// Set the new object's location to an empty location in case it spawned inside a
			// non-eligible location, and create the new object.
			var self_ = self.id;
			var resurrector_ = deadBodyResurrectedBy;
			with resurrected_enemy_ {
				event_perform(ev_create, 0);
				enemyName = self_.enemyName;
				// Assign the newly created object its combat status based on the ID of what resurrected it
				// (the ID of the resurrector is stored at the moment of casting the resurrection in the 
				// variable "deadBodyResurrectedBy")
				if (resurrector_.object_index == obj_player) || ((resurrector_.object_index == obj_enemy) && (resurrector_.combatFriendlyStatus == "Minion")) {
					combatFriendlyStatus = "Minion";
				}
				else if (resurrector_.object_index == obj_enemy) && (resurrector_.combatFriendlyStatus == "Enemy") {
					combatFriendlyStatus = "Enemy";
				}
				objectArchetype = self_.objectArchetype;
				event_perform(ev_step, ev_step_normal);
			}
			// Finally, after the new enemy has been created, destroy itself, so that the dead body is no
			// longer there.
			instance_destroy(self);
		}
	}
}

image_index = deadBodyImageIndex;


