// If the enemy is in idle state, it should not be moving
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
		// As long as Wrath of the Diaboli isn't active, make a decision. Stops decisions from being made otherwise
		if !obj_skill_tree.wrathOfTheDiaboliActive {
			// If the object calling this script has an enemy target to evaluate
			if (enemy_found_) && (self_in_combat_) {
				scr_ai_decisions();
				decisionMadeForTargetAndAction = true;
			}
		}
		// If the object calling this script has no enemy target to evaluate then it must be a minion
		// with no "Enemy" object on screen, and it should be following the player.
		if !ds_exists(objectIDsInBattle, ds_type_list) {
			// Redundant check making sure I only set an object to follow player if its a minion
			if combatFriendlyStatus == "Minion" {
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
				// Else if the player or allies is missing health and the object is a healer, then heal the player
				if (objectArchetype == "Healer") && (an_ally_needs_healing_) {
					// Set the state the enemy is going to, set the chosen engine, make sure a decision is made, 
					// and then heal the heal target. The actually chasing the target and healing is done in the
					// heal script.
					scr_healer_ai_out_of_combat_targeting();
					chosenEngine = "Heal Ally";
					decisionMadeForTargetAndAction = true;
					alreadyTriedToChase = false;
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

if ds_exists(objectIDsFollowingPlayer, ds_type_list) && !ds_exists(objectIDsInBattle, ds_type_list) {
	if combatFriendlyStatus == "Minion" {
		// Determine if any allies need healing
		var an_ally_needs_healing_ = false;
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
		// If all allies are at max HP, and/or the object isn't a healer, then just follow the player
		if (objectArchetype != "Healer") || ((objectArchetype == "Healer") && (!an_ally_needs_healing_)) {
			if variable_instance_exists(self, "enemyGroundHurtbox") {
				if instance_exists(enemyGroundHurtbox) {
					var player_ground_hurtbox_ = obj_player.playerGroundHurtbox;
					if scr_line_of_sight_exists(player_ground_hurtbox_.x, player_ground_hurtbox_.y, obj_wall) {
						if point_distance(enemyGroundHurtbox.x, enemyGroundHurtbox.y, player_ground_hurtbox_.x, player_ground_hurtbox_.y) > (tetherToPlayerOutOfCombatRange) {
							// As long as scr_line_of_sight didn't already send the enemy to the correct state,
							// then send to the correct state.
							if lineOfSightExists {
								// Set the target to move to a random location within a circle around
								// the player. This makes for enemies that, each time they move, choose
								// a different location in relation to the player, which makes them seem
								// more intelligent.
								var len_, dir_, k, p, collision_found_;
								dir_ = irandom_range(0, 359);
								len_ = tetherToPlayerOutOfCombatRange * 0.5;
								for (k = 0; k < 360; k++) {
									collision_found_ = false;
									for (p = 0; p <= array_length_1d(collisionObjects) - 1; p++) {
										if place_meeting(obj_player.x + lengthdir_x(len_, dir_), obj_player.y + lengthdir_y(len_, dir_), collisionObjects[p]) {
											collision_found_ = true;
											break;
										}
									}
									if !collision_found_ {
										len_ = tetherToPlayerOutOfCombatRange * 0.4;
										followingPlayerTargetX = obj_player.x + lengthdir_x(len_, dir_);
										followingPlayerTargetY = obj_player.y + lengthdir_y(len_, dir_);
										break;
									}
									else if collision_found_ {
										if k < 360 {
											dir_++;
											if dir_ >= 360 {
												dir_ -= 360;
											}
										}
									}
									// If there is absolutely no available location in a random position
									// around the player to move to, then just set the player as the target to move to.
									if (k == 359) && (collision_found_) {
										followingPlayerTarget = obj_player.id;
										break;
									}
								}
								followingPlayer = true;
								chosenEngine = "";
								decisionMadeForTargetAndAction = false;
								alreadyTriedToChase = false;
								enemyState = enemystates.moveWithinAttackRange;
								enemyStateSprite = enemystates.moveWithinAttackRange;
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
					}
				}
			}
		}
	}
}

// Stun and hitstun
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

if !obj_skill_tree.wrathOfTheDiaboliActive {
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
					if currentTargetToFocus.id == obj_player.id {
						var target_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
					}
					else {
						var target_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
					}
					if scr_line_of_sight_exists(target_ground_hurtbox_.x, target_ground_hurtbox_.y, obj_wall) {
						// If the obj_enemy is not within enemyHeavyMeleeAttackRange
						if point_distance(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y) > enemyHeavyMeleeAttackRange {
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
				}
				#endregion
				#region Light Melee
				else if chosenEngine == "Light Melee" {
					if currentTargetToFocus.id == obj_player.id {
						var target_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
					}
					else {
						var target_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
					}
					if scr_line_of_sight_exists(target_ground_hurtbox_.x, target_ground_hurtbox_.y, obj_wall) {
						// If the obj_enemy is not within enemyLightMeleeAttackRange
						if point_distance(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y) > enemyLightMeleeAttackRange {
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
				}
				#endregion
				#region Heavy Ranged
				else if chosenEngine == "Heavy Ranged" {
					if currentTargetToFocus.id == obj_player.id {
						var target_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
					}
					else {
						var target_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
					}
					if scr_line_of_sight_exists(target_ground_hurtbox_.x, target_ground_hurtbox_.y, obj_wall) { 
						// If the obj_enemy is not within enemyHeavyRangedAttackRange
						if point_distance(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y) > enemyHeavyRangedAttackRange {
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
				}
				#endregion
				#region Light Ranged
				else if chosenEngine == "Light Ranged" {
					if currentTargetToFocus.id == obj_player.id {
						var target_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
					}
					else {
						var target_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
					}
					if scr_line_of_sight_exists(target_ground_hurtbox_.x, target_ground_hurtbox_.y, obj_wall) {
						/*
						IF ANY OTHER ENGINE IS UNABLE TO BE EXECUTED I NEED ENEMY TO RUN TOWARDS TARGET; 
						THIS IS BECAUSE I SEND ALL FAILED ATTACKS FOR STAMINA AND MANA ABILITIES TO THIS STATE AND IF THOSE 
						FAIL, THAT MEANS THE obj_enemy'S STAMINA AND MANA REGEN HAVE BEEN DEBUFFED, LEAVING IT TOO WEAK TO FIGHT
						*/
						// If enemy is not within light ranged attack range
						if point_distance(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y) > enemyLightRangedAttackRange {
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
				}
				#endregion
			}
		}
		if objectArchetype == "Healer" {
			if currentTargetToHeal != noone {
				if instance_exists(currentTargetToHeal) {
					#region Heal Ally
					if chosenEngine == "Heal Ally" {
						// Set point direction right before sending to attack scripts
						pointDirection = point_direction(x, y, currentTargetToHeal.x, currentTargetToHeal.y);
						if currentTargetToHeal.id == obj_player.id {
							var target_ground_hurtbox_ = currentTargetToHeal.playerGroundHurtbox;
						}
						else {
							var target_ground_hurtbox_ = currentTargetToHeal.enemyGroundHurtbox;
						}
						// If line of sight exists, this script returns true and I can execute the script. If not,
						// this script immediately send the enemy to a chase script to chase the player.
						if scr_line_of_sight_exists(target_ground_hurtbox_.x, target_ground_hurtbox_.y, obj_wall) {
							// If the obj_enemy is not within enemyHealAllyRange
							if point_distance(x, y, target_ground_hurtbox_.x, target_ground_hurtbox_.y) > enemyHealAllyRange {
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
							else if 450 > enemyCurrentMana { //enemyHealManaCost > enemyCurrentMana {
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
								if enemyTimeUntilNextAttackUsableTimer < 0 {
									// execute heal ally script
									enemyCurrentMana -= enemyHealManaCost;
									enemyState = enemystates.healAlly;
									enemyStateSprite = enemystates.healAlly;
									chosenEngine = "";
									decisionMadeForTargetAndAction = false;
									enemyImageIndex = 0;
									enemyTimeUntilNextAttackUsableTimer = enemyTimeUntilNextAttackUsableTimerStartTime;
									alreadyTriedToChaseTimer = 0;
									alreadyTriedToChase = false;
									enemyTimeUntilNextManaAbilityUsableTimer = 0;
									enemyTimeUntilNextManaAbilityUsableTimerSet = false;
									healAllyEngineTimer = healAllyEngineTimerBaseTime;
								}
							}
						}
					}
					#endregion
				}
			}
		}
	}
}


