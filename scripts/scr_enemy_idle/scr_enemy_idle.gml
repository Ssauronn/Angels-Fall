// If the enemy is in idle state, it should not be moving
set_movement_variables(0, currentDirection, maxSpeed);

// If the enemy has not yet made an action decision, make that decision based on the game
// variables set right at the moment this is called
if !decisionMadeForTargetAndAction {
	var instance_to_reference_, self_in_combat_, temporary_instance_to_reference_, enemy_found_, i;
	enemy_found_ = false;
	self_in_combat_ = false;
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
						self_in_combat_ = true;
					}
				}
				else if self.combatFriendlyStatus == "Enemy" {
					enemy_found_ = true;
					self_in_combat_ = true;
				}
			}
			// If the instance_to_reference_ is the object calling this script, then the object is in combat
			// (since this line won't even run unless an obj_enemy with combatFriendlyStatus set to == 
			// "Enemy" is within tether range).
			else if instance_to_reference_ == self {
				if combatFriendlyStatus == "Enemy" { 
					enemy_found_ = true;
					self_in_combat_ = true;
				}
			}
		}
	}
	// If the object calling this script has an enemy target to evaluate
	if (enemy_found_ == true) && (self_in_combat_) {
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
			
			enemystate = enemystates.passivelyFollowPlayer;
			enemyStateSprite = enemystates.passivelyFollowPlayer;
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

// If the obj_enemy has chosen an engine to execute
if chosenEngine != "" {
	if currentTargetToFocus != noone {
		if instance_exists(currentTargetToFocus) {
			// If the chosen engine is a Heavy Melee attack
			if chosenEngine == "Heavy Melee" {
				// If the obj_enemy is not within enemyHeavyMeleeAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyMeleeAttackRange {
				/*
					if alreadyTriedToChase == false {
						enemyState = enemystates.moveWithinAttackRange
						set alreadyTriedToChase to true at the end of the script
						set a timer for chasing
						exit state once timer finishes, or exit immediately if no path to target is immediately found
							-This timer needs to be reduced in obj_enemy step event
					}
					else if alreadyTriedToChase = true {
						cchosenEngine = "Light Ranged";
					}
					*/
				}
				/*
				// Else if the obj_enemy doesn't have enough stamina to execute attack
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
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough stamina to execute attack) then execute heavy melee attack
				else {
					execute heavy melee attack script
					set chosenEngine = "" upon ending of attack script;
					set decisionMadeForTargetAndAction to false upon ending of attack script;
					enemyState = enemyestates.heavyMeleeAttack;
					enemyStateSprite = enemystates.heavyMeleeAttack;
					if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 0) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 45)) || ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 315) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= 360)) {
						enemyDirectionFacing = enemydirection.right;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 45) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 135)) {
						enemyDirectionFacing = enemydirection.up;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 135) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 225)) {
						enemyDirectionFacing = enemydirection.left;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 225) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 315)) {
						enemyDirectionFacing = enemydirection.down;
					}
				}
				*/  
			}
			else if chosenEngine == "Light Melee" {
				// If the obj_enemy is not within enemyLightMeleeAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyLightMeleeAttackRange {
					/*
					if alreadyTriedToChase == false {
						change state to try_to_chase
						set alreadyTriedToChase to true
						set a timer for chasing
						exit state once timer finishes, or exit immediately if no path to target is immediately found
							-This timer needs to be reduced in obj_enemy step event
					}
					else if alreadyTriedToChase = true {
						change chosenEngine = "Light Ranged";
					}
					*/
				}
				/*
				// Else if the obj_enemy doesn't have enough stamina to execute attack
				else if light melee stamina cost > enemyCurrentStamina {
					Evaluate current stamina and stamina regen vs light melee cost, set timer based on
					exact amount of frames + 1 needed to get to the stamina cost.
						-This timer needs to be reduced in obj_enemy step event to avoid longer wait times
						than necessary in case, for example, target walks out of range and the timer is no
						longer counting down because we're in try_to_chase state
					wait for stamina timer to reach <= 0
					if (stamina timer <= 0) && (enemyCurrentStamina < light melee stamina cost) {
					(if stamina still hasn't reached stamina cost, meaning regen has been debuffed)
						chosenEngine = "Light Ranged";
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough stamina to execute attack) then execute light melee attack
				else {
					execute light melee attack script
					set chosenEngine = "" upon ending of attack script;
					set decisionMadeForTargetAndAction to false upon ending of attack script;
					enemyState = enemyestates.lightMeleeAttack;
					enemyStateSprite = enemystates.lightMeleeAttack;
					if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 0) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 45)) || ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 315) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= 360)) {
						enemyDirectionFacing = enemydirection.right;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 45) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 135)) {
						enemyDirectionFacing = enemydirection.up;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 135) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 225)) {
						enemyDirectionFacing = enemydirection.left;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 225) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 315)) {
						enemyDirectionFacing = enemydirection.down;
					}
				}
				*/
			}
			else if chosenEngine == "Heavy Ranged" {
				// If the obj_enemy is not within enemyHeavyRangedAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyRangedAttackRange {
					/*
					if alreadyTriedToChase == false {
						change state to try_to_chase
						set alreadyTriedToChase to true
						set a timer for chasing
						exit state once timer finishes, or exit immediately if no path to target is immediately found
							-This timer needs to be reduced in obj_enemy step event
					}
					else if alreadyTriedToChase = true {
						change chosenEngine = "Light Ranged";
					}
					*/
				}
				/*
				// Else if the obj_enemy doesn't have enough mana to execute attack
				else if heavy ranged mana cost > enemyCurrentMana {
					Evaluate current mana and mana regen vs heavy ranged cost, set timer based on
					exact amount of frames + 1 needed to get to the mana cost.
						-This timer needs to be reduced in obj_enemy step event to avoid longer wait times
						than necessary in case, for example, target walks out of range and the timer is no
						longer counting down because we're in try_to_chase state
					wait for mana timer to reach <= 0
					if (mana timer <= 0) && (enemyCurrentMana < heavy ranged mana cost) {
					(if mana still hasn't reached mana cost, meaning regen has been debuffed)
						chosenEngine = "Light Ranged";
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough mana to execute attack) then execute heavy ranged attack
				else {
					execute heavy ranged attack script
					set chosenEngine = "" upon ending of attack script;
					set decisionMadeForTargetAndAction to false upon ending of attack script;
					enemyState = enemyestates.heavyRangedAttack;
					enemyStateSprite = enemystates.heavyRangedAttack;
					if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 0) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 45)) || ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 315) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= 360)) {
						enemyDirectionFacing = enemydirection.right;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 45) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 135)) {
						enemyDirectionFacing = enemydirection.up;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 135) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 225)) {
						enemyDirectionFacing = enemydirection.left;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 225) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 315)) {
						enemyDirectionFacing = enemydirection.down;
					}
				}
				*/
			}
			else if chosenEngine == "Light Ranged" {
				/*
				IF ANY OTHER ENGINE IS UNABLE TO BE EXECUTED WE NEED ENEMY TO RUN EITHER TOWARDS OR AWAY FROM TARGET; 
				THIS IS BECAUSE WE SEND ALL FAILED ATTACKS FOR STAMINA AND MANA ABILITIES TO THIS STATE AND IF THOSE 
				FAIL, THAT MEANS THE obj_enemy'S STAMINA AND MANA REGEN HAVE BEEN DEBUFFED, LEAVING IT TOO WEAK TO FIGHT
				*/
				/*
				// If enemy is not within light ranged attack range
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyLightRangedAttackRange {
					if alreadyTriedToChase == false {
						change state to try_to_chase
						set alreadyTriedToChase to true
						set a timer for chasing
						exit state once timer finishes, or exit immediately if no path to target is immediately found
							-This timer needs to be reduced in obj_enemy step event
					}
					// If obj_enemy cannot execute light ranged attack
					else if alreadyTriedToChase = true {
						// Last checks to see if any other attack can be executed - if not, the very last statement
						// is executed, resetting decision making process.
				
						// If obj_enemy is within range and has the mana, change the chosenEngine = "Heavy Ranged"
						if (point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= enemyHeavyRangedAttackRange) && (enemyCurrentMana >= heavy ranged mana cost) {
							chosenEngine = "Heavy Ranged";
						}
						// Else if obj_enemy has the stamina (its obviously already within range since melee attack
						// range is inherently less than light ranged attack range), change the chosenEngine = "Heavy 
						// Melee"
						else if enemyCurrentStamina >= heavy melee stamina cost {
							chosenEngine = "Heavy Melee";
						}
						// Else if obj_enemy has the stamina (its obviously already within range since melee attack
						// range is inherently less than light ranged attack range), change the chosenEngine = "Light 
						// Melee"
						else if enemyCurrentStamina >= light melee stamina cost {
							chosenEngine = "Light Melee";
						}
						// Else if obj_enemy is a healer, is within enemyHealRange, and has the mana required, change
						// the chosenEngine = "Heal Ally"
						else if objectArchetype == "Healer" {
							if (point_distance(x, y, currentTargetToHeal.x, currentTargetToHeal.y) <= enemyHealRange) && (enemyCurrentMana >= enemyHealManaCost) {
								chosenEngine = "Heal Ally";
							}
						}
						// Else if not a single other action can be executed, completely restart script and try to make
						// a new decision.
						else {
							chosenEngine = "";
							decisionMadeForTargetAndAction = false;
							alreadyTriedToChase = false;
							exit;
						}
					}
				}
				// If the light ranged engine cannot be executed because there is not enough mana
				else if light ranged mana cost > enemyCurrentMana {
					Evaluate current mana and mana regen vs heavy ranged cost, set timer based on
					exact amount of frames + 1 needed to get to the mana cost.
						-This timer needs to be reduced in obj_enemy step event to avoid longer wait times
						than necessary in case, for example, target walks out of range and the timer is no
						longer counting down because we're in try_to_chase state
					wait for mana timer to reach <= 0
					if (mana timer <= 0) && (enemyCurrentMana < heavy ranged mana cost) {
					(if mana still hasn't reached mana cost, meaning regen has been debuffed)
						// Last checks to see if any other attack can be executed - if not, the very last statement
						// is executed, resetting decision making process.
				
						// If obj_enemy is within range and has the mana, change the chosenEngine = "Heavy Ranged"
						if (point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= enemyHeavyRangedAttackRange) && (enemyCurrentMana >= heavy ranged mana cost) {
							chosenEngine = "Heavy Ranged";
						}
						// Else if obj_enemy has the stamina (its obviously already within range since melee attack
						// range is inherently less than light ranged attack range), change the chosenEngine = "Heavy 
						// Melee"
						else if enemyCurrentStamina >= heavy melee stamina cost {
							chosenEngine = "Heavy Melee";
						}
						// Else if obj_enemy has the stamina (its obviously already within range since melee attack
						// range is inherently less than light ranged attack range), change the chosenEngine = "Light 
						// Melee"
						else if enemyCurrentStamina >= light melee stamina cost {
							chosenEngine = "Light Melee";
						}
						// Else if obj_enemy is a healer, is within enemyHealRange, and has the mana required, change
						// the chosenEngine = "Heal Ally"
						else if objectArchetype == "Healer" {
							if (point_distance(x, y, currentTargetToHeal.x, currentTargetToHeal.y) <= enemyHealRange) && (enemyCurrentMana >= enemyHealManaCost) {
								chosenEngine = "Heal Ally";
							}
						}
						// Else if not a single other action can be executed, completely restart script and try to make
						// a new decision.
						else {
							chosenEngine = "";
							decisionMadeForTargetAndAction = false;
							alreadyTriedToChase = false;
							exit;
						}
					}
				}
				else {
					execute light ranged attack script
					set chosenEngine = "" upon ending of attack script;
					set decisionMadeForTargetAndAction to false upon ending of attack script;
					enemyState = enemyestates.lightRangedAttack;
					enemyStateSprite = enemystates.lightRangedAttack;
					if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 0) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 45)) || ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 315) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= 360)) {
						enemyDirectionFacing = enemydirection.right;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 45) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 135)) {
						enemyDirectionFacing = enemydirection.up;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 135) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 225)) {
						enemyDirectionFacing = enemydirection.left;
					}
					else if ((point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) >= 225) && (point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y) < 315)) {
						enemyDirectionFacing = enemydirection.down;
					}
				}
				*/
			}
		}
	}
	if objectArchetype == "Healer" {
		if currentTargetToHeal != noone {
			if instance_exists(currentTargetToHeal) {
				if chosenEngine == "Heal Ally" {
					// If the obj_enemy is not within enemyHealRange
					if point_distance(x, y, currentTargetToHeal.x, currentTargetToHeal.y) > enemyHealRange {
						/*
						if alreadyTriedToChase == false {
							change state to try_to_chase
							set alreadyTriedToChase to true
							set a timer for chasing
							exit state once timer finishes, or exit immediately if no path to target is immediately found
								-This timer needs to be reduced in obj_enemy step event
						}
						else if alreadyTriedToChase = true {
							change chosenEngine = "Light Ranged";
						}
						*/
					}/*
					// Else if the obj_enemy doesn't have enough mana to execute heal
					else if heal mana cost > enemyCurrentMana {
						Evaluate current mana and mana regen vs heal cost, set timer based on
						exact amount of frames + 1 needed to get to the mana cost.
							-This timer needs to be reduced in obj_enemy step event to avoid longer wait times
							than necessary in case, for example, target walks out of range and the timer is no
							longer counting down because we're in try_to_chase state
						wait for mana timer to reach <= 0
						if (mana timer <= 0) && (enemyCurrentMana < heal mana cost) {
						(if mana still hasn't reached mana cost, meaning regen has been debuffed)
							chosenEngine = "Light Ranged";
						}
					}
					// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
					// has enough mana to execute heal) then execute heal
					else {
						execute heal currentTargetToHeal script
						set chosenEngine = "" upon ending of heal script;
						set decisionMadeForTargetAndAction to false upon ending of heal script;
						enemyState = enemyestates.healAlly;
						enemyStateSprite = enemystates.healAlly;
						if ((point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) >= 0) && (point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) < 45)) || ((point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) >= 315) && (point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) <= 360)) {
							enemyDirectionFacing = enemydirection.right;
						}
						else if ((point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) >= 45) && (point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) < 135)) {
							enemyDirectionFacing = enemydirection.up;
						}
						else if ((point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) >= 135) && (point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) < 225)) {
							enemyDirectionFacing = enemydirection.left;
						}
						else if ((point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) >= 225) && (point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y) < 315)) {
							enemyDirectionFacing = enemydirection.down;
						}
					}
					*/
				}
			}
		}
	}
}


/*
After we send the object to a new state, the following variables need to be reset:

chosenEngine
decisionMadeForTargetAndAction
alreadyTriedToChase

*/


