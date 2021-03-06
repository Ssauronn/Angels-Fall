function execute_attacks() {
	switch (lastAttackButtonPressed) {
	#region Basic Attacks
		case "Attack Right 1":
		case "Attack Up 1":
		case "Attack Left 1":
		case "Attack Down 1":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			//set_movement_variables(0, playerDirectionFacing, maxSpeed);
			playerState = playerstates.attack1;
			playerStateSprite = playerstates.attack1;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Attack Right 2":
		case "Attack Up 2":
		case "Attack Left 2":
		case "Attack Down 2":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			//set_movement_variables(0, playerDirectionFacing, maxSpeed);
			playerState = playerstates.attack2;
			playerStateSprite = playerstates.attack2;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Attack Right 3":
		case "Attack Up 3":
		case "Attack Left 3":
		case "Attack Down 3":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			//set_movement_variables(0, playerDirectionFacing, maxSpeed);
			playerState = playerstates.attack3;
			playerStateSprite = playerstates.attack3;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Attack Right 4":
		case "Attack Up 4":
		case "Attack Left 4":
		case "Attack Down 4":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			//set_movement_variables(0, playerDirectionFacing, maxSpeed);
			playerState = playerstates.attack4;
			playerStateSprite = playerstates.attack4;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Attack Right 5":
		case "Attack Up 5":
		case "Attack Left 5":
		case "Attack Down 5":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			//set_movement_variables(0, playerDirectionFacing, maxSpeed);
			playerState = playerstates.attack5;
			playerStateSprite = playerstates.attack5;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
	#endregion
	
	#region Diabolus Abilities
		case "Wrath of the Diaboli":
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount = 0;
					// Determine whether there are targets for wrath of the diaboli, and set those targets
					var i, target_exists_;
					target_exists_ = false;
					for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						// As long as the potential target exists
						if instance_exists(instance_to_reference_) {
							// If the potential target is an enemy
							if instance_to_reference_.combatFriendlyStatus == "Enemy" {
								// And if the potential target is close enough
								if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.wrathOfTheDiaboliRange {
									target_exists_ = true;
									// And if the player hasn't exceeded the max amount of targets for Wrath
									// of the Diaboli
									if obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount < obj_skill_tree.wrathOfTheDiaboliMaxTargetCount {
										obj_skill_tree.wrathOfTheDiaboliTargetArray[obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount] = instance_to_reference_;
										obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount++;
										obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount = obj_skill_tree.wrathOfTheDiaboliCurrentTargetCount;
									}
								}
							}
						}
					}
					// If a target is found to attack with this ability
					if target_exists_ {
						if comboTrue != "" {
							comboTrue = "";
							playerDirectionFacing = comboPlayerDirectionFacing;
							comboPlayerDirectionFacing = -1;
							playerImageIndex = 0;
						}
						else {
							playerImageIndex = 0;
						}
						if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
							obj_skill_tree.parrySuccessfullyCombod = false;
							dashSuccessfullyCombod = false;
							playerImageIndex = 2;
						}
						invincibile = true;
						obj_skill_tree.wrathOfTheDiaboliActive = true;
						playerState = playerstates.wrathofthediaboli;
						playerStateSprite = playerstates.wrathofthediaboli;
						lastAttackButtonPressed = "";
						playerCurrentStamina -= obj_skill_tree.wrathOfTheDiaboliStaminaCost;
						playerCurrentStamina += obj_skill_tree.wrathOfTheDiaboliStaminaRegen;
						obj_skill_tree.wrathOfTheDiaboliTargetsHit = 0;
						obj_skill_tree.wrathOfTheDiaboliStartXPos = x;
						obj_skill_tree.wrathOfTheDiaboliStartYPos = y;
						obj_skill_tree.wrathOfTheDiaboliStartDirection = playerDirectionFacing;
						obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget = false;
						comboAbilityButton = 0;
						comboTrueTimer = -1;
					}
				}
			}
			break;
		case "Glinting Blade":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			/*---I don't reduce and add to player resources here, because that's done in the attack script
			only if Glinting Blade wasn't already active---*/
			playerState = playerstates.glintingblade;
			playerStateSprite = playerstates.glintingblade;
			lastAttackButtonPressed = "";
			currentSpeed = 0;
			// If Glinting Blade is not currently flying through the air, and is not already active
			// elsewhere either attached on the ground or on an enemy, then create the hitbox.
			if (!obj_skill_tree.glintingBladeActive) && (!instance_exists(obj_skill_tree.glintingBladeAttachedToEnemy)) {
				if ds_exists(obj_combat_controller.playerHitboxList, ds_type_list) {
					var k, hitbox_to_reference_, hitbox_exists_;
					hitbox_exists_ = false;
					for (k = 0; k <= ds_list_size(obj_combat_controller.playerHitboxList) - 1; k++) {
						hitbox_to_reference_ = ds_list_find_value(obj_combat_controller.playerHitboxList, k);
						if instance_exists(hitbox_to_reference_) {
							if hitbox_to_reference_.playerHitboxAbilityOrigin == "Glinting Blade" {
								hitbox_exists_ = true;
							}
						}
					}
					if !hitbox_exists_ {
						obj_skill_tree.glintingBladeArrivedAtTargetPos = false;
						obj_skill_tree.glintingBladeAttachedToEnemy = noone;
						obj_skill_tree.glintingBladeTargetXPos = mouse_x;
						obj_skill_tree.glintingBladeTargetYPos = mouse_y;
					}
				}
				else {
					obj_skill_tree.glintingBladeArrivedAtTargetPos = false;
					obj_skill_tree.glintingBladeAttachedToEnemy = noone;
					obj_skill_tree.glintingBladeTargetXPos = mouse_x;
					obj_skill_tree.glintingBladeTargetYPos = mouse_y;
				}
			}
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Hellish Landscape":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.hellishlandscape;
			playerStateSprite = playerstates.hellishlandscape;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.hellishLandscapeStaminaCost;
			playerCurrentStamina += obj_skill_tree.hellishLandscapeStaminaRegen;
			obj_skill_tree.hellishLandscapeTargetX = mouse_x;
			obj_skill_tree.hellishLandscapeTargetY = mouse_y;
			var dir_ = point_direction(x, y, mouse_x, mouse_y);
		    if dir_ >= 45 && dir_ < 135 {
				playerDirectionFacing = playerdirection.up;
			}
		    else if dir_ >= 315 && dir_ < 360 {
				playerDirectionFacing = playerdirection.right;
			}
		    else if dir_ >= 0 && dir_ < 45 {
				playerDirectionFacing = playerdirection.right;
			}
		    else if dir_ >= 225 && dir_ < 315 {
				playerDirectionFacing = playerdirection.down;
			}
		    else if dir_ >= 135 && dir_ < 225 {
				playerDirectionFacing = playerdirection.left;
			}
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Hidden Dagger":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.hiddendagger;
			playerStateSprite = playerstates.hiddendagger;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.hiddenDaggerStaminaCost;
			playerCurrentStamina += obj_skill_tree.hiddenDaggerStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "All Out Attack":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.alloutattack;
			playerStateSprite = playerstates.alloutattack;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.allOutAttackStaminaCost;
			playerCurrentStamina += obj_skill_tree.allOutAttackStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Exploit Weakness":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.exploitweakness;
			playerStateSprite = playerstates.exploitweakness;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.exploitWeaknessStaminaCost;
			playerCurrentStamina += obj_skill_tree.exploitWeaknessStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Purifying Rage":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.purifyingrage;
			playerStateSprite = playerstates.purifyingrage;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.purifyingRageStaminaCost;
			playerCurrentStamina += obj_skill_tree.purifyingRageStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Rushdown":
			// Determine whether there are targets for rushdown, and set that target
			var i;
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					obj_skill_tree.rushdownTarget = noone;
					for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
						var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
						// As long as the potential target exists
						if instance_exists(instance_to_reference_) {
							// If the potential target is an enemy
							if instance_to_reference_.combatFriendlyStatus == "Enemy" {
								// And if the potential target is close enough
								if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.rushdownRange {
									// And if the potential target is closer than any other potential target,
									// then set the new potential target as the current target
									var current_target_ = obj_skill_tree.rushdownTarget;
									if instance_exists(current_target_) {
										if (!collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_wall, true, true)) && (!collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_chasm, true, true)) {
											if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < point_distance(x, y, current_target_.x, current_target_.y) {
												obj_skill_tree.rushdownTarget = instance_to_reference_;
												current_target_ = instance_to_reference_;
											}
										}
									}
									// Else if a target for rushdown doesn't even exist yet, set the target
									// automatically to the first enemy detected within range.
									else {
										if (!collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_wall, true, true)) && (!collision_line(x, y, instance_to_reference_.x, instance_to_reference_.y, obj_chasm, true, true)) {
											obj_skill_tree.rushdownTarget = instance_to_reference_;
											current_target_ = instance_to_reference_;
										}
									}
								}
							}
						}
					}
				}
			}
			if instance_exists(obj_skill_tree.rushdownTarget) {
				var instance_to_reference_ = obj_skill_tree.rushdownTarget;
				if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) > obj_skill_tree.rushdownMeleeRange {
					obj_skill_tree.rushdownDashed = true;
					obj_skill_tree.rushdownDashTimer = obj_skill_tree.rushdownDashTimerStartTime;
				}
				// Set player direction facing based on the direction the current rushdown target is in
				var dir_ = point_direction(x, y, instance_to_reference_.x, instance_to_reference_.y);
			    if dir_ >= 45 && dir_ < 135 {
					playerDirectionFacing = playerdirection.up;
				}
			    else if dir_ >= 315 && dir_ < 360 {
					playerDirectionFacing = playerdirection.right;
				}
			    else if dir_ >= 0 && dir_ < 45 {
					playerDirectionFacing = playerdirection.right;
				}
			    else if dir_ >= 225 && dir_ < 315 {
					playerDirectionFacing = playerdirection.down;
				}
			    else if dir_ >= 135 && dir_ < 225 {
					playerDirectionFacing = playerdirection.left;
				}
				if comboTrue != "" {
					comboTrue = "";
					playerDirectionFacing = comboPlayerDirectionFacing;
					comboPlayerDirectionFacing = -1;
					playerImageIndex = 0;
				}
				else {
					playerImageIndex = 0;
				}
				if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
					obj_skill_tree.parrySuccessfullyCombod = false;
					dashSuccessfullyCombod = false;
					playerImageIndex = 2;
				}
				playerState = playerstates.rushdown;
				playerStateSprite = playerstates.rushdown;
				lastAttackButtonPressed = "";
				playerCurrentStamina -= obj_skill_tree.rushdownStaminaCost;
				playerCurrentStamina += obj_skill_tree.rushdownStaminaRegen;
				comboAbilityButton = 0;
				comboTrueTimer = -1;
			}
			break;
		case "Diabolus Blast":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.diabolusblast;
			playerStateSprite = playerstates.diabolusblast;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.diabolusBlastStaminaCost;
			playerCurrentStamina += obj_skill_tree.diabolusBlastStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
	#endregion
	#region Caelesti Abilities
		case "True Caelesti Wings":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.truecaelestiwings;
			playerStateSprite = playerstates.truecaelestiwings;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.trueCaelestiWingsStaminaCost;
			playerCurrentStamina += obj_skill_tree.trueCaelestiWingsStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Bindings of the Caelesti":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.bindingsofthecaelesti;
			playerStateSprite = playerstates.bindingsofthecaelesti;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.bindingsOfTheCaelestiStaminaCost;
			playerCurrentStamina += obj_skill_tree.bindingsOfTheCaelestiStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Armor of the Caelesti":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.armorofthecaelesti;
			playerStateSprite = playerstates.armorofthecaelesti;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.armorOfTheCaelestiStaminaCost;
			playerCurrentStamina += obj_skill_tree.armorOfTheCaelestiStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Holy Defense":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.holydefense;
			playerStateSprite = playerstates.holydefense;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.holyDefenseStaminaCost;
			playerCurrentStamina += obj_skill_tree.holyDefenseStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Wrath of the Repentant":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.wrathoftherepentant;
			playerStateSprite = playerstates.wrathoftherepentant;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.wrathOfTheRepentantStaminaCost;
			playerCurrentStamina += obj_skill_tree.wrathOfTheRepentantStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "The One Power":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.theonepower;
			playerStateSprite = playerstates.theonepower;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.theOnePowerStaminaCost;
			playerCurrentStamina += obj_skill_tree.theOnePowerStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Lightning Spear":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.lightningspear;
			playerStateSprite = playerstates.lightningspear;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.lightningSpearStaminaCost;
			playerCurrentStamina += obj_skill_tree.lightningSpearStaminaRegen;
			obj_skill_tree.lightningSpearTargetXPos = mouse_x;
			obj_skill_tree.lightningSpearTargetYPos = mouse_y;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Angelic Barrage":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.angelicbarrage;
			playerStateSprite = playerstates.angelicbarrage;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.angelicBarrageStaminaCost;
			playerCurrentStamina += obj_skill_tree.angelicBarrageStaminaRegen;
			obj_skill_tree.angelicBarrageTargetXPos = mouse_x;
			obj_skill_tree.angelicBarrageTargetYPos = mouse_y;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Whirlwind":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.whirlwind;
			playerStateSprite = playerstates.whirlwind;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.whirlwindStaminaCost;
			playerCurrentStamina += obj_skill_tree.whirlwindStaminaRegen;
			obj_skill_tree.whirlwindTargetXPos = mouse_x;
			obj_skill_tree.whirlwindTargetYPos = mouse_y;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
	#endregion
	#region Necromancy Abilities
		case "Death Incarnate":
			if !obj_skill_tree.deathIncarnateFirstPhaseActive {
				if !obj_skill_tree.deathIncarnateSecondPhaseActive {
					if comboTrue != "" {
						comboTrue = "";
						playerDirectionFacing = comboPlayerDirectionFacing;
						comboPlayerDirectionFacing = -1;
						playerImageIndex = 0;
					}
					else {
						playerImageIndex = 0;
					}
					playerState = playerstates.deathincarnate;
					playerStateSprite = playerstates.deathincarnate;
					lastAttackButtonPressed = "";
					playerCurrentStamina -= obj_skill_tree.deathIncarnateStaminaCost;
					playerCurrentStamina += obj_skill_tree.deathIncarnateStaminaRegen;
					obj_skill_tree.deathIncarnateFirstPhaseTargetXPos = mouse_x;
					obj_skill_tree.deathIncarnateFirstPhaseTargetYPos = mouse_y;
					obj_skill_tree.deathIncarnateSecondPhaseCurrentTarget = noone;
					if ds_exists(obj_skill_tree.deathIncarnateSecondPhaseTargetList, ds_type_list) {
						ds_list_destroy(obj_skill_tree.deathIncarnateSecondPhaseTargetList);
						obj_skill_tree.deathIncarnateSecondPhaseTargetList = noone;
					}
					comboAbilityButton = 0;
					comboTrueTimer = -1;
				}
			}
			else {
				if comboTrue != "" {
					comboTrue = "";
					playerDirectionFacing = comboPlayerDirectionFacing;
					comboPlayerDirectionFacing = -1;
					playerImageIndex = 0;
				}
				else {
					playerImageIndex = 0;
				}
				if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
					obj_skill_tree.parrySuccessfullyCombod = false;
					dashSuccessfullyCombod = false;
					playerImageIndex = 2;
				}
				playerState = playerstates.deathincarnate;
				playerStateSprite = playerstates.deathincarnate;
				lastAttackButtonPressed = "";
				obj_skill_tree.deathIncarnateSecondPhaseCurrentTarget = noone;
				if ds_exists(obj_skill_tree.deathIncarnateSecondPhaseTargetList, ds_type_list) {
					ds_list_destroy(obj_skill_tree.deathIncarnateSecondPhaseTargetList);
					obj_skill_tree.deathIncarnateSecondPhaseTargetList = noone;
				}
				comboAbilityButton = 0;
				comboTrueTimer = -1;
			}
			break;
		case "Ritual of Imperfection":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.ritualofimperfection;
			playerStateSprite = playerstates.ritualofimperfection;
			lastAttackButtonPressed = "";
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			// I'll subtract the stamina from the player inside the attack script based on how long the
			// button is held (meaning how much stamina the player dedicates to the summoning)
			break;
		case "Ritual of Death":
			// Determine if the player's current Stamina, after 7 more frames of regeneration,
			// will be enough to cast the spell, and if so, cast it.
			if ((playerCurrentStamina + (playerStaminaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathStaminaCost) {
				if comboTrue != "" {
					comboTrue = "";
					playerDirectionFacing = comboPlayerDirectionFacing;
					comboPlayerDirectionFacing = -1;
					playerImageIndex = 0;
				}
				else {
					playerImageIndex = 0;
				}
				if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
					obj_skill_tree.parrySuccessfullyCombod = false;
					dashSuccessfullyCombod = false;
					playerImageIndex = 2;
				}
				playerState = playerstates.ritualofdeath;
				playerStateSprite = playerstates.ritualofdeath;
				lastAttackButtonPressed = "";
				comboAbilityButton = 0;
				comboTrueTimer = -1;
			}
			break;
		case "Soul Tether":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.soultether;
			playerStateSprite = playerstates.soultether;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.soulTetherStaminaCost;
			playerCurrentStamina += obj_skill_tree.soulTetherStaminaRegen;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Dinner is Served":
			if instance_exists(obj_dead_body) {
				var nearest_dead_body_ = instance_nearest(x, y, obj_dead_body);
				if point_distance(x, y, nearest_dead_body_.x, nearest_dead_body_.y) <= obj_skill_tree.dinnerIsServedRange {
					if ds_exists(objectIDsInBattle, ds_type_list) {
						var i;
						var target_found_ = false;
						for (i = 0; i <= ds_list_size(objectIDsInBattle) -1; i++) {
							var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
							if instance_exists(instance_to_reference_) {
								if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) <= obj_skill_tree.dinnerIsServedRange {
									target_found_ = true;
								}
							}
						}
						if target_found_ {
							if comboTrue != "" {
								comboTrue = "";
								playerDirectionFacing = comboPlayerDirectionFacing;
								comboPlayerDirectionFacing = -1;
								playerImageIndex = 0;
							}
							else {
								playerImageIndex = 0;
							}
							if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
								obj_skill_tree.parrySuccessfullyCombod = false;
								dashSuccessfullyCombod = false;
								playerImageIndex = 2;
							}
							playerState = playerstates.dinnerisserved;
							playerStateSprite = playerstates.dinnerisserved;
							lastAttackButtonPressed = "";
							playerCurrentStamina -= obj_skill_tree.dinnerIsServedStaminaCost;
							playerCurrentStamina += obj_skill_tree.dinnerIsServedStaminaRegen;
							comboAbilityButton = 0;
							comboTrueTimer = -1;
						}
					}
				}
			}
			break;
		case "Final Parting":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.finalparting;
			playerStateSprite = playerstates.finalparting;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.finalPartingStaminaCost;
			playerCurrentStamina += obj_skill_tree.finalPartingStaminaRegen;
			obj_skill_tree.finalPartingTargetXPos = mouse_x;
			obj_skill_tree.finalPartingTargetYPos = mouse_y;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Risk of Life":
			if comboTrue != "" {
				comboTrue = "";
				playerDirectionFacing = comboPlayerDirectionFacing;
				comboPlayerDirectionFacing = -1;
				playerImageIndex = 0;
			}
			else {
				playerImageIndex = 0;
			}
			if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
				obj_skill_tree.parrySuccessfullyCombod = false;
				dashSuccessfullyCombod = false;
				playerImageIndex = 2;
			}
			playerState = playerstates.riskoflife;
			playerStateSprite = playerstates.riskoflife;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.riskOfLifeStaminaCost;
			playerCurrentStamina += obj_skill_tree.riskOfLifeStaminaRegen;
			obj_skill_tree.riskOfLifeTargetXPos = mouse_x;
			obj_skill_tree.riskOfLifeTargetYPos = mouse_y;
			comboAbilityButton = 0;
			comboTrueTimer = -1;
			break;
		case "Taken for Pain":
			if !obj_skill_tree.takenForPainFirstPhaseActive && !obj_skill_tree.takenForPainSecondPhaseActive {
				if (playerCurrentStamina >= obj_skill_tree.takenForPainStaminaCost) {
					if comboTrue != "" {
						comboTrue = "";
						playerDirectionFacing = comboPlayerDirectionFacing;
						comboPlayerDirectionFacing = -1;
						playerImageIndex = 0;
					}
					else {
						playerImageIndex = 0;
					}
					if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
						obj_skill_tree.parrySuccessfullyCombod = false;
						dashSuccessfullyCombod = false;
						playerImageIndex = 2;
					}
					playerState = playerstates.takenforpain;
					playerStateSprite = playerstates.takenforpain;
					lastAttackButtonPressed = "";
					playerCurrentStamina -= obj_skill_tree.takenForPainStaminaCost;
					playerCurrentStamina += obj_skill_tree.takenForPainStaminaRegen;
					comboAbilityButton = 0;
					comboTrueTimer = -1;
				}
			}
			break;
		case "Sickly Proposition":
			if (playerCurrentStamina >= obj_skill_tree.sicklyPropositionStaminaCost) {
				if comboTrue != "" {
					comboTrue = "";
					playerDirectionFacing = comboPlayerDirectionFacing;
					comboPlayerDirectionFacing = -1;
					playerImageIndex = 0;
				}
				else {
					playerImageIndex = 0;
				}
				if (obj_skill_tree.parrySuccessfullyCombod) || (dashSuccessfullyCombod) {
					obj_skill_tree.parrySuccessfullyCombod = false;
					dashSuccessfullyCombod = false;
					playerImageIndex = 2;
				}
				playerState = playerstates.sicklyproposition;
				playerStateSprite = playerstates.sicklyproposition;
				lastAttackButtonPressed = "";
				playerCurrentStamina -= obj_skill_tree.sicklyPropositionStaminaCost;
				playerCurrentStamina += obj_skill_tree.sicklyPropositionStaminaRegen;
				obj_skill_tree.sicklyPropositionTargetXPos = mouse_x;
				obj_skill_tree.sicklyPropositionTargetYPos = mouse_y;
				comboAbilityButton = 0;
				comboTrueTimer = -1;
			}
			break;
	#endregion
	}





}
