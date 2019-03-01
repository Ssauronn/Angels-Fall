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
		if (playerCurrentHP >= playerMaxHP) || (objectArchetype != "Healer") {
			Commented out code below is the code to use after a script passively_follow_player is implemented.
			Delete this and the comment above after implementing code below.
			
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
		}
		/*
		If the object follows player and no valid path is found, continue to search for path
		If no path is found and object exists screen view, destroy object
		If path is found and object exists screen view, start timer, if object enters screen again reset timer
		If timer reaches 0 and object still has not entered view, destroy object
		This will allow for minions that cannot follow player to not continue to take up processing power, and
		minions that are left too far behind player to not continue to take up processing power as well.
		*/
		/*
		else {
			chosenEngine = "Heal Ally";
			currentTargetToHeal = obj_player;
			decisionMadeForTargetAndAction = true;
		}
		*/
	}
}

// Determine if the enemy can fulfill various requirements to execute chosen action and if so, execute action
if chosenEngine != "" {
	if chosenEngine == "Heavy Melee" {
		if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyMeleeAttackRange {
			/*
			if alreadyTriedToChase == false {
				change state to try_to_chase
				set alreadyTriedToChase to true
				set a timer for chasing
				exit state once timer finishes, or exit immediately if no path to target is immediately found
			}
			else if alreadyTriedToChase = true {
				change chosenEngine = "Light Ranged";
			}
			*/
		}
		/*
		else if heavy melee stamina cost > enemyCurrentStamina {
			Evaluate current stamina and stamina regen vs heavy melee cost, set timer based on
			exact amount of frames + 1 needed to get to the stamina cost.
				-This timer needs to be reduced in obj_enemy step event to avoid longer wait times
				than necessary in case, for example, target walks out of range and the timer is no
				longer counting down because we're in try_to_chase state
			wait for stamina timer to reach <= 0
			if (stamina timer <= 0) && (enemyCurrentStamina < heavy melee stamina cost) {
			(if stamina still hasn't reached stamina cost, meaning regen has been debuffed)
				chosenEngine = "Light Ranged";
			}
		}
		else {
			execute melee attack script
			set chosenEngine = "" upon ending of attack script;
			set decisionMadeForTargetAndAction to false upon ending of attack script;
		}
		*/  
	}
	else if chosenEngine == "Light Melee" {
		
	}
	if chosenEngine == "Heavy Ranged" {
		/*
		IF THE LIGHT RANGED ENGINE IS UNABLE TO BE EXECUTED WE NEED ENEMY TO RUN; THIS IS BECAUSE
		WE SEND ALL FAILED ATTACKS FOR STAMINA ABILITIES TO THIS STATE AND IF THOSE FAIL, THAT MEANS
		THE obj_enemy'S STAMINA AND MANA REGEN HAVE BEEN DEBUFFED, LEAVING IT TOO WEAK TO FIGHT
		*/
	}
	else if chosenEngine == "Light Ranged" {
		
	}
	else if chosenEngine == "Heal Ally" {
		
	}
}


/*
After we send the object to a new state, the following variables need to be reset:

chosenEngine
decisionMadeForTargetAndAction

*/


