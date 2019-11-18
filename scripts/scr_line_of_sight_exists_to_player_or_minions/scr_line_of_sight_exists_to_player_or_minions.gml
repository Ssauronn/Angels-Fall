///@description Check for a line of sight to player or any minions.

// Only run code if this is an enemy. Else if it isn't, there's no need because minions will be
// teleported back to player if out of sight long enough.
if combatFriendlyStatus == "Enemy" {
	/// SET UP VARIABLES
	var self_ = self;
	var current_x_ = self_.enemyGroundHurtbox;
	current_x_ = current_x_.x;
	var current_y_ = self_.enemyGroundHurtbox;
	current_y_ = current_y_.y;
	var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
	var target_x_ = player_ground_hurtbox_.x;
	var target_y_ = player_ground_hurtbox_.y;


	var valid_line_of_sight_exists_ = false;
	// If a line of sight exists for the enemy vs player, then mark it as a valid line of sight exists.
	if !collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
		valid_line_of_sight_exists_ = true;
	}
	
	// If a line of sight exists for any minion, then mark it as a valid line of sight exists.
	with obj_enemy {
		var target_ = self;
		if target_.id != self_.id {
			if target_.combatFriendlyStatus == "Minion" {
				var variable_exists_ = false;
				with target_ {
					if variable_instance_exists(target_, "enemyGroundHurtbox") {
						if instance_exists(target_.enemyGroundHurtbox) {
							variable_exists_ = true;
						}
					}
				}
				if variable_exists_ {
					target_ = target_.enemyGroundHurtbox;
					target_x_ = target_.x;
					target_y_ = target_.y;
					if !collision_line(current_x_, current_y_, target_x_, target_y_, obj_wall, false, true) {
						valid_line_of_sight_exists_ = true;
					}
				}
			}
		}
	}
	return valid_line_of_sight_exists_;
}
else {
	return true;
}


