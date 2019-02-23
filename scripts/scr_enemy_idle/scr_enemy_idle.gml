// If the enemy is in idle state, it should not be moving
set_movement_variables(0, currentDirection, maxSpeed);

// If the enemy has not yet made an action decision, make that decision based on the game
// variables set right at the moment this is called
if !decisionMadeForTargetAndAction {
	var instance_to_reference_, temporary_instance_to_reference_, enemy_found_, i;
	enemy_found_ = false;
	// If there are obj_enemy objects on screen, whether friendly or enemy
	if ds_exists(objectIDsInBattle, ds_type_list) {
		for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
			instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
			// If the object info we're accessing to compare against this own object is not itself
			if instance_to_reference_ != self {
				// If the object's combat status is a minion
				if self.combatFriendlyStatus == "Minion" {
					// If an enemy obj_enemy object exists, set enemy_found_ as true
					if instance_to_reference_.combatFriendlyStatus == "Enemy" {
						enemy_found_ = true;
					}
				}
			}
			// If the object info we're currently accessing is the object calling this script,
			// test to see if its an "Enemy". If so, enemy_found_ is auto set to true since
			// the player object will never be destroyed even in death, and obj_player is a perma
			// enemy of obj_enemy objects with combatFriendlyStatus set to "Enemy".
			else if instance_to_reference_.combatFriendlyStatus == "Enemy" {
				enemy_found_ = true;
			}
		}
	}
	// If the object calling this script has an enemy target to evaluate
	if enemy_found_ == true {
		scr_ai_decisions();
		decisionMadeForTargetAndAction = true;
	}
	// If the object calling this script has no enemy target to evaluate then it must be a minion
	// with no "Enemy" object on screen, and it should be following the player.
	else {
		/*
		enemystate = enemystates.passivelyfollowplayer;
		enemyStateSprite = enemystates.passivelyfollowplayer;
		if ((point_direction(x, y, obj_player.x, obj_player.y) >= 0) && (point_direction(x, y, obj_player.x, obj_player.y) < 45)) || ((point_direction(x, y, obj_player.x, obj_player.y) >= 315) && (point_direction(x, y, obj_player.x, obj_player.y) <= 360)) {
			enemyDirectionFacing = enemydirection.right;
		}
		else if ((point_direction(x, y, obj_player.x, obj_player.y) >= 45) && (point_direction(x, y, obj_player.x, obj_player.y) < 135)) {
			enemyDirectionFacing = enemydirection.up;
		}
		else if ((point_direction(x, y, obj_player.x, obj_player.y) >= 135) && (point_direction(x, y, obj_player.x, obj_player.y) < 225)) {
			enemyDirectionFacing = enemydirection.left;
		}
		else if ((point_direction(x, y, obj_player.x, obj_player.y) >= 225) && (point_direction(x, y, obj_player.x, obj_player.y) < 315)) {
			enemyDirectionFacing = enemydirection.down;
		}
		*/
	}
}

// Determine if the enemy has enough resources to use chosen action and if so, execute
// chosen action
if chosenEngine != "" {
	if !chosenEngineUnableToBeExecuted {
		if chosenEngine == "Heavy Melee" {
			// close distance for a set period of time, if target not reached, revert to an
			// alternate decision making process where only ranged attacks are usable for the next
			// action. if target reached, determine if current resource amount matches or exceeds
			// resource cost, if so, execute action, if not wait and continue moving towards target
			// if necessary until current resource reaches action resource cost, execute action,
			// reset everything.
			if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyMeleeAttackRange {
				
			}
		}
	}
	else {
		if chosenEngine == "Heavy Ranged" {
			
		}
		else if chosenEngine == "Light Ranged" {
			
		}
		else if chosenEngine == "Heal Ally" {
			
		}
	}
}


/*
After we send the object to a new state, the following variables need to be reset:

chosenEngine
decisionMadeForTargetAndAction

*/


