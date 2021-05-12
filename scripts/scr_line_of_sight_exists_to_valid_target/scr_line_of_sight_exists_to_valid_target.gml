///@description Determines if a line of sight exists to a valid target while in combat.
function scr_line_of_sight_exists_to_valid_target() {

	var line_of_sight_to_target_exists_ = false;
	if ds_exists(objectIDsInBattle, ds_type_list) {
		var i;
		if ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
			ds_list_destroy(validObjectIDsInLineOfSight);
			validObjectIDsInLineOfSight = noone;
		}
		for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
			var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
			var instance_to_reference_ground_hurtbox_ = instance_to_reference_.enemyGroundHurtbox;
			if instance_exists(instance_to_reference_) {
				if instance_to_reference_ != self.id {
					// If the current instance to reference is an enemy of the object running this code
					if (combatFriendlyStatus == "Minion" && instance_to_reference_.combatFriendlyStatus == "Enemy") || (combatFriendlyStatus == "Enemy" && instance_to_reference_.combatFriendlyStatus == "Minion") {
						// If a line of sight exists to the enemy target
						if !collision_line(x, y, instance_to_reference_ground_hurtbox_.x, instance_to_reference_ground_hurtbox_.y, obj_wall, true, true) {
							if !ds_exists(validObjectIDsInLineOfSight, ds_type_list) {
								validObjectIDsInLineOfSight = ds_list_create();
							}
							ds_list_add(validObjectIDsInLineOfSight, instance_to_reference_);
							line_of_sight_to_target_exists_ = true;
						}
					}
				}
			}
		}
		// After checking for enemies to the object running this code in line of sight, check for a line
		// of sight to the player.
		var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
		if combatFriendlyStatus == "Enemy" {
			playerIsAValidHealTargetInLineOfSight = false;
			if !collision_line(x, y, player_ground_hurtbox_.x, player_ground_hurtbox_.y, obj_wall, true, true) {
				playerIsAValidFocusTargetInLineOfSight = true;
				line_of_sight_to_target_exists_ = true;
			}
			else {
				playerIsAValidFocusTargetInLineOfSight = false;
			}
		}
		else if combatFriendlyStatus == "Minion" {
			playerIsAValidFocusTargetInLineOfSight = false;
			if !collision_line(x, y, player_ground_hurtbox_.x, player_ground_hurtbox_.y, obj_wall, true, true) {
				playerIsAValidHealTargetInLineOfSight = true;
				line_of_sight_to_target_exists_ = true;
			}
			else {
				playerIsAValidHealTargetInLineOfSight = false;
			}
		}
	}
	else if combatFriendlyStatus == "Minion" {
		playerIsAValidFocusTargetInLineOfSight = false;
		var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
		if !collision_line(x, y, player_ground_hurtbox_.x, player_ground_hurtbox_.y, obj_wall, true, true) {
			playerIsAValidHealTargetInLineOfSight = true;
			line_of_sight_to_target_exists_ = true;
		}
		else {
			playerIsAValidFocusTargetInLineOfSight = false;
		}
	}

	return line_of_sight_to_target_exists_;





}
