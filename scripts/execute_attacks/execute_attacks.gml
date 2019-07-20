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
		//set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack1;
		playerStateSprite = playerstates.attack1;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
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
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
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
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
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
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
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
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
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
					invincibile = true;
					obj_skill_tree.wrathOfTheDiaboliActive = true;
					playerState = playerstates.wrathofthediaboli;
					playerStateSprite = playerstates.wrathofthediaboli;
					lastAttackButtonPressed = "";
					playerCurrentStamina -= obj_skill_tree.wrathOfTheDiaboliStaminaCost;
					playerCurrentStamina += obj_skill_tree.wrathOfTheDiaboliStaminaRegen;
					playerCurrentMana -= obj_skill_tree.wrathOfTheDiaboliManaCost;
					playerCurrentMana += obj_skill_tree.wrathOfTheDiaboliManaRegen;
					obj_skill_tree.wrathOfTheDiaboliTargetsHit = 0;
					obj_skill_tree.wrathOfTheDiaboliStartXPos = x;
					obj_skill_tree.wrathOfTheDiaboliStartYPos = y;
					obj_skill_tree.wrathOfTheDiaboliStartDirection = playerDirectionFacing;
					obj_skill_tree.wrathOfTheDiaboliTeleportedToNextTarget = false;
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
		playerState = playerstates.hellishlandscape;
		playerStateSprite = playerstates.hellishlandscape;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.hellishLandscapeStaminaCost;
		playerCurrentStamina += obj_skill_tree.hellishLandscapeStaminaRegen;
		playerCurrentMana -= obj_skill_tree.hellishLandscapeManaCost;
		playerCurrentMana += obj_skill_tree.hellishLandscapeManaRegen;
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
		playerState = playerstates.hiddendagger;
		playerStateSprite = playerstates.hiddendagger;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.hiddenDaggerStaminaCost;
		playerCurrentStamina += obj_skill_tree.hiddenDaggerStaminaRegen;
		playerCurrentMana -= obj_skill_tree.hiddenDaggerManaCost;
		playerCurrentMana += obj_skill_tree.hiddenDaggerManaRegen;
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
		playerState = playerstates.alloutattack;
		playerStateSprite = playerstates.alloutattack;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.allOutAttackStaminaCost;
		playerCurrentStamina += obj_skill_tree.allOutAttackStaminaRegen;
		playerCurrentMana -= obj_skill_tree.allOutAttackManaCost;
		playerCurrentMana += obj_skill_tree.allOutAttackManaRegen;
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
		playerState = playerstates.exploitweakness;
		playerStateSprite = playerstates.exploitweakness;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.exploitWeaknessStaminaCost;
		playerCurrentStamina += obj_skill_tree.exploitWeaknessStaminaRegen;
		playerCurrentMana -= obj_skill_tree.exploitWeaknessManaCost;
		playerCurrentMana += obj_skill_tree.exploitWeaknessManaRegen;
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
		playerState = playerstates.purifyingrage;
		playerStateSprite = playerstates.purifyingrage;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.purifyingRageStaminaCost;
		playerCurrentStamina += obj_skill_tree.purifyingRageStaminaRegen;
		playerCurrentMana -= obj_skill_tree.purifyingRageManaCost;
		playerCurrentMana += obj_skill_tree.purifyingRageManaRegen;
		break;
	case "Rushdown":
		// Determine whether there are targets for rushdown, and set that target
		var i;
		if variable_global_exists("objectIDsInBattle") {
			if ds_exists(objectIDsInBattle, ds_type_list) {
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
									if point_distance(x, y, instance_to_reference_.x, instance_to_reference_.y) < point_distance(x, y, current_target_.x, current_target_.y) {
										obj_skill_tree.rushdownTarget = instance_to_reference_;
										current_target_ = instance_to_reference_;
									}
								}
								// Else if a target for rushdown doesn't even exist yet, set the target
								// automatically to the first enemy detected within range.
								else {
									obj_skill_tree.rushdownTarget = instance_to_reference_;
									current_target_ = instance_to_reference_;
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
			playerState = playerstates.rushdown;
			playerStateSprite = playerstates.rushdown;
			lastAttackButtonPressed = "";
			playerCurrentStamina -= obj_skill_tree.rushdownStaminaCost;
			playerCurrentStamina += obj_skill_tree.rushdownStaminaRegen;
			playerCurrentMana -= obj_skill_tree.rushdownManaCost;
			playerCurrentMana += obj_skill_tree.rushdownManaRegen;
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
		playerState = playerstates.diabolusblast;
		playerStateSprite = playerstates.diabolusblast;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.diabolusBlastStaminaCost;
		playerCurrentStamina += obj_skill_tree.diabolusBlastStaminaRegen;
		playerCurrentMana -= obj_skill_tree.diabolusBlastManaCost;
		playerCurrentMana += obj_skill_tree.diabolusBlastManaRegen;
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
		playerState = playerstates.truecaelestiwings;
		playerStateSprite = playerstates.truecaelestiwings;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.trueCaelestiWingsStaminaCost;
		playerCurrentStamina += obj_skill_tree.trueCaelestiWingsStaminaRegen;
		playerCurrentMana -= obj_skill_tree.trueCaelestiWingsManaCost;
		playerCurrentMana += obj_skill_tree.trueCaelestiWingsManaRegen;
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
		playerState = playerstates.bindingsofthecaelesti;
		playerStateSprite = playerstates.bindingsofthecaelesti;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.bindingsOfTheCaelestiStaminaCost;
		playerCurrentStamina += obj_skill_tree.bindingsOfTheCaelestiStaminaRegen;
		playerCurrentMana -= obj_skill_tree.bindingsOfTheCaelestiManaCost;
		playerCurrentMana += obj_skill_tree.bindingsOfTheCaelestiManaRegen;
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
		playerState = playerstates.armorofthecaelesti;
		playerStateSprite = playerstates.armorofthecaelesti;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.armorOfTheCaelestiStaminaCost;
		playerCurrentStamina += obj_skill_tree.armorOfTheCaelestiStaminaRegen;
		playerCurrentMana -= obj_skill_tree.armorOfTheCaelestiManaCost;
		playerCurrentMana += obj_skill_tree.armorOfTheCaelestiManaRegen;
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
		playerState = playerstates.holydefense;
		playerStateSprite = playerstates.holydefense;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.holyDefenseStaminaCost;
		playerCurrentStamina += obj_skill_tree.holyDefenseStaminaRegen;
		playerCurrentMana -= obj_skill_tree.holyDefenseManaCost;
		playerCurrentMana += obj_skill_tree.holyDefenseManaRegen;
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
		playerState = playerstates.wrathoftherepentant;
		playerStateSprite = playerstates.wrathoftherepentant;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.wrathOfTheRepentantStaminaCost;
		playerCurrentStamina += obj_skill_tree.wrathOfTheRepentantStaminaRegen;
		playerCurrentMana -= obj_skill_tree.wrathOfTheRepentantManaCost;
		playerCurrentMana += obj_skill_tree.wrathOfTheRepentantManaRegen;
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
		playerState = playerstates.theonepower;
		playerStateSprite = playerstates.theonepower;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.theOnePowerStaminaCost;
		playerCurrentStamina += obj_skill_tree.theOnePowerStaminaRegen;
		playerCurrentMana -= obj_skill_tree.theOnePowerManaCost;
		playerCurrentMana += obj_skill_tree.theOnePowerManaRegen;
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
		playerState = playerstates.lightningspear;
		playerStateSprite = playerstates.lightningspear;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.lightningSpearStaminaCost;
		playerCurrentStamina += obj_skill_tree.lightningSpearStaminaRegen;
		playerCurrentMana -= obj_skill_tree.lightningSpearManaCost;
		playerCurrentMana += obj_skill_tree.lightningSpearManaRegen;
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
		playerState = playerstates.angelicbarrage;
		playerStateSprite = playerstates.angelicbarrage;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.angelicBarrageStaminaCost;
		playerCurrentStamina += obj_skill_tree.angelicBarrageStaminaRegen;
		playerCurrentMana -= obj_skill_tree.angelicBarrageManaCost;
		playerCurrentMana += obj_skill_tree.angelicBarrageManaRegen;
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
		playerState = playerstates.whirlwind;
		playerStateSprite = playerstates.whirlwind;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.whirlwindStaminaCost;
		playerCurrentStamina += obj_skill_tree.whirlwindStaminaRegen;
		playerCurrentMana -= obj_skill_tree.whirlwindManaCost;
		playerCurrentMana += obj_skill_tree.whirlwindManaRegen;
		break;
	#endregion
	#region Necromancy Abilities
	case "Death Incarnate":
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
		playerCurrentMana -= obj_skill_tree.deathIncarnateManaCost;
		playerCurrentMana += obj_skill_tree.deathIncarnateManaRegen;
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
		playerState = playerstates.ritualofimperfection;
		playerStateSprite = playerstates.ritualofimperfection;
		lastAttackButtonPressed = "";
		// I'll subtract the mana from the player inside the attack script based on how long the
		// button is held (meaning how much mana the player dedicates to the summoning)
		break;
	case "Ritual of Death":
		if comboTrue != "" {
			comboTrue = "";
			playerDirectionFacing = comboPlayerDirectionFacing;
			comboPlayerDirectionFacing = -1;
			playerImageIndex = 0;
		}
		else {
			playerImageIndex = 0;
		}
		playerState = playerstates.ritualofdeath;
		playerStateSprite = playerstates.ritualofdeath;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.ritualOfDeathStaminaCost;
		playerCurrentStamina += obj_skill_tree.ritualOfDeathStaminaRegen;
		playerCurrentMana -= obj_skill_tree.ritualOfDeathManaCost;
		playerCurrentMana += obj_skill_tree.ritualOfDeathManaRegen;
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
		playerState = playerstates.soultether;
		playerStateSprite = playerstates.soultether;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.soulTetherStaminaCost;
		playerCurrentStamina += obj_skill_tree.soulTetherStaminaRegen;
		playerCurrentMana -= obj_skill_tree.soulTetherManaCost;
		playerCurrentMana += obj_skill_tree.soulTetherManaRegen;
		break;
	case "Dinner is Served":
		if comboTrue != "" {
			comboTrue = "";
			playerDirectionFacing = comboPlayerDirectionFacing;
			comboPlayerDirectionFacing = -1;
			playerImageIndex = 0;
		}
		else {
			playerImageIndex = 0;
		}
		playerState = playerstates.dinnerisserved;
		playerStateSprite = playerstates.dinnerisserved;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.dinnerIsServedStaminaCost;
		playerCurrentStamina += obj_skill_tree.dinnerIsServedStaminaRegen;
		playerCurrentMana -= obj_skill_tree.dinnerIsServedManaCost;
		playerCurrentMana += obj_skill_tree.dinnerIsServedManaRegen;
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
		playerState = playerstates.finalparting;
		playerStateSprite = playerstates.finalparting;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.finalPartingStaminaCost;
		playerCurrentStamina += obj_skill_tree.finalPartingStaminaRegen;
		playerCurrentMana -= obj_skill_tree.finalPartingManaCost;
		playerCurrentMana += obj_skill_tree.finalPartingManaRegen;
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
		playerState = playerstates.riskoflife;
		playerStateSprite = playerstates.riskoflife;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.riskOfLifeStaminaCost;
		playerCurrentStamina += obj_skill_tree.riskOfLifeStaminaRegen;
		playerCurrentMana -= obj_skill_tree.riskOfLifeManaCost;
		playerCurrentMana += obj_skill_tree.riskOfLifeManaRegen;
		break;
	case "Taken for Pain":
		if comboTrue != "" {
			comboTrue = "";
			playerDirectionFacing = comboPlayerDirectionFacing;
			comboPlayerDirectionFacing = -1;
			
			playerImageIndex = 0;
		}
		else {
			playerImageIndex = 0;
		}
		playerState = playerstates.takenforpain;
		playerStateSprite = playerstates.takenforpain;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.takenForPainStaminaCost;
		playerCurrentStamina += obj_skill_tree.takenForPainStaminaRegen;
		playerCurrentMana -= obj_skill_tree.takenForPainManaCost;
		playerCurrentMana += obj_skill_tree.takenForPainManaRegen;
		break;
	case "Sickly Proposition":
		if comboTrue != "" {
			comboTrue = "";
			playerDirectionFacing = comboPlayerDirectionFacing;
			comboPlayerDirectionFacing = -1;
			playerImageIndex = 0;
		}
		else {
			playerImageIndex = 0;
		}
		playerState = playerstates.sicklyproposition;
		playerStateSprite = playerstates.sicklyproposition;
		lastAttackButtonPressed = "";
		playerCurrentStamina -= obj_skill_tree.sicklyPropositionStaminaCost;
		playerCurrentStamina += obj_skill_tree.sicklyPropositionStaminaRegen;
		playerCurrentMana -= obj_skill_tree.sicklyPropositionManaCost;
		playerCurrentMana += obj_skill_tree.sicklyPropositionManaRegen;
		break;
	#endregion
}


