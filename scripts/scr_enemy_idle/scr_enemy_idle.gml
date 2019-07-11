// If the enemy is in idle state, it should not be moving
#region Determine whether to take an action
// This if statement stops the enemy from taking any action if the player is performing an action
// that needs all enemies to stop movement. Note, because this is only in idle state, it only stops
// enemies that have not yet made a decision or are waiting for timers or resources. It does not stop
// enemies that are currently in an attacking animation or chasing script.
if !obj_skill_tree.wrathOfTheDiaboliActive {
#endregion
#region Make Action Decision
if instance_exists(self) {
	// If the enemy has not yet made an action decision, make that decision based on the game
	// variables set right at the moment this is called
	if !decisionMadeForTargetAndAction {
		var instance_to_reference_, self_in_combat_, enemy_found_, i;
		enemy_found_ = false;
		self_in_combat_ = false;
		// If there are obj_enemy objects on screen, whether friendly or enemy
		if ds_exists(objectIDsInBattle, ds_type_list) {
			for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
				instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
				// If the object info I'm accessing to compare against this own object is not itself
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
		if (enemy_found_) && (self_in_combat_) {
			scr_ai_decisions();
			decisionMadeForTargetAndAction = true;
		}
		// If the object calling this script has no enemy target to evaluate then it must be a minion
		// with no "Enemy" object on screen, and it should be following the player.
		else {
			// Redundant check making sure I only set an object to follow player if its a minion
			if combatFriendlyStatus == "Minion" {
				// Checking to make sure there is no combat currently - if there is, do not just passively
				// follow player
				if !ds_exists(objectIDsInBattle, ds_type_list) {
					// Determine if any allies need healing
					var an_ally_needs_healing_ = false;
					if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
						var i;
						for (i = 0; i <= ds_list_size(objectIDsFollowingPlayer) - 1; i++) {
							var instance_to_reference_ = ds_list_find_value(objectIDsFollowingPlayer, i);
							if (instance_to_reference_.enemyCurrentHP / instance_to_reference_.enemyMaxHP) != 1 {
								an_ally_needs_healing_ = true;
							}
						}
						if (playerCurrentHP / playerMaxHP) != 1 {
							an_ally_needs_healing_ = true;
						}
					}
					// If all allies are at max HP, or the object isn't a healer, then just follow the player
					if (objectArchetype != "Healer") || ((objectArchetype == "Healer") && (!an_ally_needs_healing_)) {
						if point_distance(enemyGroundHurtbox.x, enemyGroundHurtbox.y, obj_player.x, obj_player.y) > tetherToPlayerOutOfCombatRange {
							chosenEngine = "";
							decisionMadeForTargetAndAction = false;
							alreadyTriedToChase = false;
							enemyState = enemystates.passivelyFollowPlayer;
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
					}
					/*
					If the object follows player and no valid path is found, continue to search for path
					If no path is found and object exists screen view, destroy object
					If path is found and object exists screen view, start timer, if object enters screen again reset timer
					If timer reaches 0 and object still has not entered view, destroy object
					This will allow for minions that cannot follow player to not continue to take up processing power, and
					minions that are left too far behind player to not continue to take up processing power as well.
					*/
					// Else if the player or allies is missing health and the object is a healer, then heal the player
					else if (objectArchetype == "Healer") && (an_ally_needs_healing_) {
						// Set the state the enemy is going to, set the chosen engine, make sure a decision is made, 
						// and then heal the heal target
						scr_healer_ai_out_of_combat_targeting();
						chosenEngine = "Heal Ally";
						decisionMadeForTargetAndAction = true;
						alreadyTriedToChase = false;
					}
				}
			}
		}
	}
}
else {
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}
if stunActive {
	enemyState = enemystates.stunned;
	enemyStateSprite = enemystates.stunned;
	enemyImageIndex = 0;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}
if hitstunActive {
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}
#endregion

// Resetting variables to make a new decision so that the AI doesn't get caught in a loop
if ((!instance_exists(currentTargetToFocus)) || (currentTargetToFocus == noone)) && ((chosenEngine == "Heavy Melee") || (chosenEngine == "Light Melee") || (chosenEngine == "Heavy Ranged") || (chosenEngine == "Light Ranged" )) {
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}
if ((!instance_exists(currentTargetToHeal)) || (currentTargetToHeal == noone)) && (objectArchetype == "Healer") && (chosenEngine == "Heal Ally") {
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}
if (chosenEngine == "") && (ds_exists(objectIDsInBattle, ds_type_list)) {
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}


/// Actually sending the AI to the correct states depending on the decision made and chosenEngine
// If the obj_enemy has chosen an engine to execute
if chosenEngine != "" {
	if currentTargetToFocus != noone {
		if instance_exists(currentTargetToFocus) {
			// Set point direction right before sending to attack scripts
			pointDirection = point_direction(x, y, currentTargetToFocus.x, currentTargetToFocus.y);
			#region Heavy Melee
			// If the chosen engine is a Heavy Melee attack
			if chosenEngine == "Heavy Melee" {
				// If the obj_enemy is not within enemyHeavyMeleeAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyMeleeAttackRange {
					// If the enemy hasn't already tried to chase it's target, then chase the target.
					if !alreadyTriedToChase { 
						enemyState = enemystates.moveWithinAttackRange;
						enemyStateSprite = enemystates.moveWithinAttackRange;
						alreadyTriedToChaseTimer = room_speed * 3;
						enemyImageIndex = 0;
					}
					// If the enemy has already tried to chase the target, then set the chosen engine to ranged
					// and don't try to continue to chase the target.
					else if alreadyTriedToChase {
						chosenEngine = "Light Ranged";
						decisionMadeForTargetAndAction = true;
						alreadyTriedToChase = false;
						alreadyTriedToChaseTimer = 0;
					}
				}
				// Else if the obj_enemy doesn't have enough stamina to execute attack
				else if enemyHeavyMeleeAttackStamCost > enemyCurrentStamina {
					// Evaluate current stamina and stamina regen vs heavy melee cost, set timer based on
					// exact amount of frames + 1 needed to get to the stamina cost.
					if !enemyTimeUntilNextStaminaAbilityUsableTimerSet {
						var time_to_get_required_stam_ = round((enemyHeavyMeleeAttackStamCost - enemyCurrentStamina) / enemyStaminaRegeneration) + 1;
						enemyTimeUntilNextStaminaAbilityUsableTimer = time_to_get_required_stam_;
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = true;
					}
					// If stamina still hasn't gotten above the required stamina cost, meaning regen has been
					// debuffed
					else if (enemyTimeUntilNextStaminaAbilityUsableTimer <= 0) && (enemyCurrentStamina < enemyHeavyMeleeAttackStamCost) && (enemyTimeUntilNextStaminaAbilityUsableTimerSet) {
						chosenEngine = "Light Ranged";
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough stamina to execute attack) then execute heavy melee attack
				else {
					// If the enemy has waited long enough to use another attack, then execute the attack.
					// I don't have an else statement connected to this timer because this timer will always count
					// down in 2.5 real world seconds or less, so the enemy will never really be waiting too long.
					if enemyTimeUntilNextAttackUsableTimer < 0 {
						// execute heavy melee attack script
						enemyCurrentStamina -= enemyHeavyMeleeAttackStamCost;
						enemyState = enemystates.heavyMeleeAttack;
						enemyStateSprite = enemystates.heavyMeleeAttack;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyImageIndex = 0;
						enemyTimeUntilNextAttackUsableTimer = enemyTimeUntilNextAttackUsableTimerStartTime;
						alreadyTriedToChaseTimer = 0;
						alreadyTriedToChase = false;
						enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
					}
				} 
			}
			#endregion
			#region Light Melee
			else if chosenEngine == "Light Melee" {
				// If the obj_enemy is not within enemyLightMeleeAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyLightMeleeAttackRange {
					// If the enemy hasn't already tried to chase it's target, then chase the target.
					if !alreadyTriedToChase { 
						enemyState = enemystates.moveWithinAttackRange;
						enemyStateSprite = enemystates.moveWithinAttackRange;
						alreadyTriedToChaseTimer = room_speed * 3;
						enemyImageIndex = 0;
					}
					// If the enemy has already tried to chase the target, then set the chosen engine to ranged
					// and don't try to continue to chase the target.
					else if alreadyTriedToChase {
						chosenEngine = "Light Ranged";
						decisionMadeForTargetAndAction = true;
						alreadyTriedToChase = false;
						alreadyTriedToChaseTimer = 0;
					}
				}
				// Else if the obj_enemy doesn't have enough stamina to execute attack
				else if enemyLightMeleeAttackStamCost > enemyCurrentStamina {
					// Evaluate current stamina and stamina regen vs light melee cost, set timer based on
					// exact amount of frames + 1 needed to get to the stamina cost.
					if !enemyTimeUntilNextStaminaAbilityUsableTimerSet {
						var time_to_get_required_stam_ = round((enemyLightMeleeAttackStamCost - enemyCurrentStamina) / enemyStaminaRegeneration) + 1;
						enemyTimeUntilNextStaminaAbilityUsableTimer = time_to_get_required_stam_;
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = true;
					}
					// If stamina still hasn't gotten above the required stamina cost, meaning regen has been
					// debuffed
					else if (enemyTimeUntilNextStaminaAbilityUsableTimer <= 0) && (enemyCurrentStamina < enemyLightMeleeAttackStamCost) && (enemyTimeUntilNextStaminaAbilityUsableTimerSet) {
						chosenEngine = "Light Ranged";
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough stamina to execute attack) then execute light melee attack
				else {
					// If the enemy has waited long enough to use another attack, then execute the attack.
					// I don't have an else statement connected to this timer because this timer will always count
					// down in 2.5 real world seconds or less, so the enemy will never really be waiting too long.
					if enemyTimeUntilNextAttackUsableTimer < 0 {
						// execute light melee attack script
						enemyCurrentStamina -= enemyLightMeleeAttackStamCost;
						enemyState = enemystates.lightMeleeAttack;
						enemyStateSprite = enemystates.lightMeleeAttack;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyImageIndex = 0;
						enemyTimeUntilNextAttackUsableTimer = enemyTimeUntilNextAttackUsableTimerStartTime;
						alreadyTriedToChaseTimer = 0;
						alreadyTriedToChase = false;
						enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
						enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
					}
				}
			}
			#endregion
			#region Heavy Ranged
			else if chosenEngine == "Heavy Ranged" {
				// If the obj_enemy is not within enemyHeavyRangedAttackRange
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyHeavyRangedAttackRange {
					// If the enemy hasn't already tried to chase it's target, then chase the target.
					if !alreadyTriedToChase { 
						enemyState = enemystates.moveWithinAttackRange;
						enemyStateSprite = enemystates.moveWithinAttackRange;
						alreadyTriedToChaseTimer = room_speed * 3;
						enemyImageIndex = 0;
					}
					// If the enemy has already tried to chase the target, then set the chosen engine to ranged
					// and don't try to continue to chase the target.
					else if alreadyTriedToChase {
						chosenEngine = "Light Ranged";
						decisionMadeForTargetAndAction = true;
						alreadyTriedToChase = false;
						alreadyTriedToChaseTimer = 0;
					}
				}
				// Else if the obj_enemy doesn't have enough mana to execute attack
				else if enemyHeavyRangedAttackManaCost > enemyCurrentMana {
					// Evaluate current mana and mana regen vs heavy ranged cost, set timer based on
					// exact amount of frames + 1 needed to get to the mana cost.
					if !enemyTimeUntilNextManaAbilityUsableTimerSet {
						var time_to_get_required_mana_ = round((enemyHeavyRangedAttackManaCost - enemyCurrentMana) / enemyManaRegeneration) + 1;
						enemyTimeUntilNextManaAbilityUsableTimer = time_to_get_required_mana_;
						enemyTimeUntilNextManaAbilityUsableTimerSet = true;
					}
					// If mana still hasn't gotten above the required mana cost, meaning regen has been
					// debuffed
					else if (enemyTimeUntilNextManaAbilityUsableTimer <= 0) && (enemyCurrentMana < enemyHeavyRangedAttackManaCost) && (enemyTimeUntilNextManaAbilityUsableTimerSet) {
						chosenEngine = "Light Ranged";
						enemyTimeUntilNextManaAbilityUsableTimerSet = false;
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough mana to execute attack) then execute heavy ranged attack
				else {
					// If the enemy has waited long enough to use another attack, then execute the attack.
					// I don't have an else statement connected to this timer because this timer will always count
					// down in 2.5 real world seconds or less, so the enemy will never really be waiting too long.
					if enemyTimeUntilNextAttackUsableTimer < 0 {
						// execute heavy ranged attack script
						enemyCurrentMana -= enemyHeavyRangedAttackManaCost;
						enemyState = enemystates.heavyRangedAttack;
						enemyStateSprite = enemystates.heavyRangedAttack;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyImageIndex = 0;
						enemyTimeUntilNextAttackUsableTimer = enemyTimeUntilNextAttackUsableTimerStartTime;
						alreadyTriedToChaseTimer = 0;
						alreadyTriedToChase = false;
						enemyTimeUntilNextManaAbilityUsableTimer = 0;
						enemyTimeUntilNextManaAbilityUsableTimerSet = false;
					}
				}
			}
			#endregion
			#region Light Ranged
			else if chosenEngine == "Light Ranged" {
				/*
				IF ANY OTHER ENGINE IS UNABLE TO BE EXECUTED I NEED ENEMY TO RUN EITHER TOWARDS OR AWAY FROM TARGET; 
				THIS IS BECAUSE I SEND ALL FAILED ATTACKS FOR STAMINA AND MANA ABILITIES TO THIS STATE AND IF THOSE 
				FAIL, THAT MEANS THE obj_enemy'S STAMINA AND MANA REGEN HAVE BEEN DEBUFFED, LEAVING IT TOO WEAK TO FIGHT
				*/
				// If enemy is not within light ranged attack range
				if point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) > enemyLightRangedAttackRange {
					// If the enemy hasn't already tried to chase it's target, then chase the target.
					if !alreadyTriedToChase { 
						enemyState = enemystates.moveWithinAttackRange;
						enemyStateSprite = enemystates.moveWithinAttackRange;
						alreadyTriedToChaseTimer = room_speed * 3;
						enemyImageIndex = 0;
					}
					// If obj_enemy cannot execute light ranged attack
					else if alreadyTriedToChase {
						// Last checks to see if any other attack can be executed - if not, the very last statement
						// is executed, resetting decision making process.
						
						// If obj_enemy is within range, change the chosenEngine = "Heavy Ranged"
						if (point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= enemyHeavyRangedAttackRange) {
							chosenEngine = "Heavy Ranged";
						}
						// Else if obj_enemy is a healer and the heal target doesn't have max HP, change chosenEngine =
						// "Heal Ally".
						else if objectArchetype == "Healer" {
							// As long as a heal target exists
							if instance_exists(currentTargetToHeal) {
								// If the heal target is a player, set local variables to player values. Else, set
								// to enemy values.
								if currentTargetToHeal.object_index == obj_player {
									var current_target_to_heal_current_hp_ = playerCurrentHP;
									var current_target_to_heal_max_hp_ = playerMaxHP;
								}
								else {
									var current_target_to_heal_current_hp_ = currentTargetToHeal.enemyCurrentHP;
									var current_target_to_heal_max_hp_ = currentTargetToHeal.enemyMaxHP;
								}
								// As long as the object heal target has less than 100% HP,
								if (current_target_to_heal_current_hp_ / current_target_to_heal_max_hp_) < 1 {
									chosenEngine = "Heal Ally";
								}
							}
						}
						// Else if not a single other action can be executed, completely restart script and try to make
						// a new decision.
						else {
							chosenEngine = "";
							decisionMadeForTargetAndAction = false;
							alreadyTriedToChase = false;
							alreadyTriedToChaseTimer = 0;
							enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
							enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
							enemyTimeUntilNextManaAbilityUsableTimerSet = false;
							enemyTimeUntilNextManaAbilityUsableTimer = 0;
						}
					}
				}
				
				// If the light ranged engine cannot be executed because there is not enough mana
				// Else if the obj_enemy doesn't have enough mana to execute attack
				else if enemyLightRangedAttackManaCost > enemyCurrentMana {
					// Evaluate current mana and mana regen vs light ranged cost, set timer based on
					// exact amount of frames + 1 needed to get to the mana cost.
					if !enemyTimeUntilNextManaAbilityUsableTimerSet {
						var time_to_get_required_mana_ = round((enemyLightRangedAttackManaCost - enemyCurrentMana) / enemyManaRegeneration) + 1;
						enemyTimeUntilNextManaAbilityUsableTimer = time_to_get_required_mana_;
						enemyTimeUntilNextManaAbilityUsableTimerSet = true;
					}
					// If mana has not been regen'd enough, meaning regen was debuffed
					if (enemyTimeUntilNextManaAbilityUsableTimer <= 0) && (enemyCurrentMana < enemyLightRangedAttackManaCost) && (enemyTimeUntilNextManaAbilityUsableTimerSet) {
						// Last checks to see if any other attack can be executed - if not, the very last statement
						// is executed, resetting decision making process.
						
						// If obj_enemy is within range, change the chosenEngine = "Heavy Ranged"
						if (point_distance(x, y, currentTargetToFocus.x, currentTargetToFocus.y) <= enemyHeavyRangedAttackRange) {
							chosenEngine = "Heavy Ranged";
						}
						// Else if obj_enemy is a healer and the heal target doesn't have max HP, change chosenEngine =
						// "Heal Ally".
						else if objectArchetype == "Healer" {
							// As long as a heal target exists
							if instance_exists(currentTargetToHeal) {
								// If the heal target is a player, set local variables to player values. Else, set
								// to enemy values.
								if currentTargetToHeal.object_index == obj_player {
									var current_target_to_heal_current_hp_ = playerCurrentHP;
									var current_target_to_heal_max_hp_ = playerMaxHP;
								}
								else {
									var current_target_to_heal_current_hp_ = currentTargetToHeal.enemyCurrentHP;
									var current_target_to_heal_max_hp_ = currentTargetToHeal.enemyMaxHP;
								}
								// As long as the object heal target has less than 100% HP,
								if (current_target_to_heal_current_hp_ / current_target_to_heal_max_hp_) < 1 {
									chosenEngine = "Heal Ally";
								}
							}
						}
						// Else if not a single other action can be executed, completely restart script and try to make
						// a new decision.
						else {
							chosenEngine = "";
							decisionMadeForTargetAndAction = false;
							alreadyTriedToChase = false;
							alreadyTriedToChaseTimer = 0;
							enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
							enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
							enemyTimeUntilNextManaAbilityUsableTimerSet = false;
							enemyTimeUntilNextManaAbilityUsableTimer = 0;
						}
					}
				}
				// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
				// has enough mana to execute attack) then execute light ranged attack
				else {
					// If the enemy has waited long enough to use another attack, then execute the attack.
					// I don't have an else statement connected to this timer because this timer will always count
					// down in 2.5 real world seconds or less, so the enemy will never really be waiting too long.
					if enemyTimeUntilNextAttackUsableTimer < 0 {
						// execute light ranged attack script
						enemyCurrentMana -= enemyLightRangedAttackManaCost;
						enemyState = enemystates.lightRangedAttack;
						enemyStateSprite = enemystates.lightRangedAttack;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyImageIndex = 0;
						enemyTimeUntilNextAttackUsableTimer = enemyTimeUntilNextAttackUsableTimerStartTime;
						alreadyTriedToChaseTimer = 0;
						alreadyTriedToChase = false;
						enemyTimeUntilNextManaAbilityUsableTimer = 0;
						enemyTimeUntilNextManaAbilityUsableTimerSet = false;
					}
				}
			}
			#endregion
		}
	}
	if objectArchetype == "Healer" {
		if currentTargetToHeal != noone {
			if instance_exists(currentTargetToHeal) {
				// Set point direction right before sending to attack scripts
				pointDirection = point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y);
				#region Heal Ally
				if chosenEngine == "Heal Ally" {
					// If the obj_enemy is not within enemyHealAllyRange
					if point_distance(x, y, currentTargetToHeal.x, currentTargetToHeal.y) > enemyHealAllyRange {
						// If the enemy hasn't already tried to chase it's target, then chase the target.
						if !alreadyTriedToChase { 
							enemyState = enemystates.moveWithinAttackRange;
							enemyStateSprite = enemystates.moveWithinAttackRange;
							alreadyTriedToChaseTimer = room_speed * 3;
						}
						// If the enemy has already tried to chase the target, then set the chosen engine to ranged
						// and don't try to continue to chase the target.
						else if alreadyTriedToChase {
							chosenEngine = "Light Ranged";
							decisionMadeForTargetAndAction = true;
							alreadyTriedToChase = false;
							alreadyTriedToChaseTimer = 0;
						}
					}
					// Else if the obj_enemy doesn't have enough mana to execute heal
					else if enemyHealManaCost > enemyCurrentMana {
						// Evaluate current mana and mana regen vs heal ally cost, set timer based on
						// exact amount of frames + 1 needed to get to the mana cost.
						if !enemyTimeUntilNextManaAbilityUsableTimerSet {
							var time_to_get_required_mana_ = round((enemyHealManaCost - enemyCurrentMana) / enemyManaRegeneration) + 1;
							enemyTimeUntilNextManaAbilityUsableTimer = time_to_get_required_mana_;
							enemyTimeUntilNextManaAbilityUsableTimerSet = true;
						}
						// If mana still hasn't gotten above the required mana cost, meaning regen has been
						// debuffed
						else if (enemyTimeUntilNextManaAbilityUsableTimer <= 0) && (enemyCurrentMana < enemyHealManaCost) && (enemyTimeUntilNextManaAbilityUsableTimerSet) {
							chosenEngine = "Light Ranged";
							enemyTimeUntilNextManaAbilityUsableTimerSet = false;
						}
					}
					// Else if all conditions are satisfied (this engine is chosen, obj_enemy is within range and
					// has enough mana to execute heal) then execute heal
					else {
						// execute heal ally script
						enemyCurrentMana -= enemyHealManaCost;
						enemyState = enemystates.healAlly;
						enemyStateSprite = enemystates.healAlly;
						chosenEngine = "";
						decisionMadeForTargetAndAction = false;
						enemyImageIndex = 0;
						alreadyTriedToChaseTimer = 0;
						alreadyTriedToChase = false;
						enemyTimeUntilNextManaAbilityUsableTimer = 0;
						enemyTimeUntilNextManaAbilityUsableTimerSet = false;
						healAllyEngineTimer = healAllyEngineTimerBaseTime;
					}
				}
				#endregion
			}
		}
	}
}

#region Determine whether to move or take an action
}
#endregion

/*
After I send the object to a new state, the following variables need to be reset:

chosenEngine
decisionMadeForTargetAndAction
alreadyTriedToChase

*/


