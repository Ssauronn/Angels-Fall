/// @function choose_player_ability_state(equippedAbilityInKeyPressedSlot, ComboingFromAbility);
/// @param {string} equippedAbilityInKeyPressedSlot
/// @param {boolean} comboingFromAbility
///@description Switch Statement for choosing the correct ability state to send the player to after an
/// ability button is pressed.
function choose_player_ability_state(argument0, argument1) {

	var equipped_ability_ = argument0;
	if argument1 {
		var combo_ = true;
	}
	else {
		var combo_ = false;
	}

	switch equipped_ability_ {
	#region Diabolus Abilities
		case "Wrath of the Diaboli": 
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					if combo_ {
						if (playerCurrentStamina >= obj_skill_tree.wrathOfTheDiaboliStaminaCost) {
							comboTrue = "Wrath of the Diaboli";
							comboTrueTimer = 10;
							// I don't directly set lastAttackButtonPressed to comboTrue here because the only
							// time this block will be executed is if there actually is a combo, and if there
							// actually is a combo, I call send_player_to_ability_state script, which calls this
							// script, in every attack script right before setting lastAttackButtonPressed to
							// comboTrue. Essentially, I don't set lastAttackButtonPressed to comboTrue here because
							// it immediately gets set to comboTrue once this script finishes.
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if (playerCurrentStamina >= obj_skill_tree.wrathOfTheDiaboliStaminaCost) {
							lastAttackButtonPressed = "Wrath of the Diaboli";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
				else {
					comboTrue = "";
					lastAttackButtonPressed = "";
				}
			}
			else {
				comboTrue = "";
				lastAttackButtonPressed = "";
			}
			break;
		case "Glinting Blade":
			if !obj_skill_tree.glintingBladeActive {
				if combo_ {
					if (playerCurrentStamina >= obj_skill_tree.glintingBladeStaminaCost) {
						comboTrue = "Glinting Blade";
						comboTrueTimer = 10;
					}
					else {
						comboTrue = "";
						comboPlayerDirectionFacing = -1;
						lastAttackButtonPressed = "";
					}
				}
				else {
					if (playerCurrentStamina >= obj_skill_tree.glintingBladeStaminaCost) {
						lastAttackButtonPressed = "Glinting Blade";
						execute_attacks();
					}
					else {
						lastAttackButtonPressed = "";
					}
				}
			}
			else {
				// I don't check for stamina values here because the player can recall without using
				// resources
				if combo_ {
					comboTrue = "Glinting Blade";
					comboTrueTimer = 10;
				}
				else {
					lastAttackButtonPressed = "Glinting Blade";
					execute_attacks();
				}
				break;
			}
			break;
		case "Hellish Landscape":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.hellishLandscapeStaminaCost) {
					comboTrue = "Hellish Landscape";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.hellishLandscapeStaminaCost) {
					lastAttackButtonPressed = "Hellish Landscape";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Hidden Dagger":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.hiddenDaggerStaminaCost) {
					comboTrue = "Hidden Dagger";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.hiddenDaggerStaminaCost) {
					lastAttackButtonPressed = "Hidden Dagger";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "All Out Attack":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.allOutAttackStaminaCost) {
					comboTrue = "All Out Attack";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.allOutAttackStaminaCost) {
					lastAttackButtonPressed = "All Out Attack";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Exploit Weakness":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.exploitWeaknessStaminaCost) {
					comboTrue = "Exploit Weakness";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.exploitWeaknessStaminaCost) {
					lastAttackButtonPressed = "Exploit Weakness";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Purifying Rage":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.purifyingRageStaminaCost) {
					comboTrue = "Purifying Rage";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.purifyingRageStaminaCost) {
					lastAttackButtonPressed = "Purifying Rage";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Rushdown":
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					if combo_ {
						if (playerCurrentStamina >= obj_skill_tree.rushdownStaminaCost) {
							comboTrue = "Rushdown";
							comboTrueTimer = 10;
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if (playerCurrentStamina >= obj_skill_tree.rushdownStaminaCost) {
							lastAttackButtonPressed = "Rushdown";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
				else {
					comboTrue = "";
					lastAttackButtonPressed = "";
				}
			}
			else {
				comboTrue = "";
				lastAttackButtonPressed = "";
			}
			break;
		case "Diabolus Blast":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.diabolusBlastStaminaCost) {
					comboTrue = "Diabolus Blast";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.diabolusBlastStaminaCost) {
					lastAttackButtonPressed = "Diabolus Blast";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
	#endregion
	#region Caelesti Abilities
		case "True Caelesti Wings":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.trueCaelestiWingsStaminaCost) {
					comboTrue = "True Caelesti Wings";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.trueCaelestiWingsStaminaCost) {
					lastAttackButtonPressed = "True Caelesti Wings";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Bindings of the Caelesti":
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					if combo_ {
						if (playerCurrentStamina >= obj_skill_tree.bindingsOfTheCaelestiStaminaCost) {
							comboTrue = "Bindings of the Caelesti";
							comboTrueTimer = 10;
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if (playerCurrentStamina >= obj_skill_tree.bindingsOfTheCaelestiStaminaCost) {
							lastAttackButtonPressed = "Bindings of the Caelesti";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
				else {
					comboTrue = "";
					lastAttackButtonPressed = "";
				}
			}
			else {
				comboTrue = "";
				lastAttackButtonPressed = "";
			}
			break;
		case "Armor of the Caelesti":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.armorOfTheCaelestiStaminaCost) {
					comboTrue = "Armor of the Caelesti";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.armorOfTheCaelestiStaminaCost) {
					lastAttackButtonPressed = "Armor of the Caelesti";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Holy Defense":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.holyDefenseStaminaCost) {
					comboTrue = "Holy Defense";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.holyDefenseStaminaCost) {
					lastAttackButtonPressed = "Holy Defense";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Wrath of the Repentant":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.wrathOfTheRepentantStaminaCost) {
					comboTrue = "Wrath of the Repentant";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.wrathOfTheRepentantStaminaCost) {
					lastAttackButtonPressed = "Wrath of the Repentant";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "The One Power":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.theOnePowerStaminaCost) {
					comboTrue = "The One Power";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.theOnePowerStaminaCost) {
					lastAttackButtonPressed = "The One Power";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Lightning Spear":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.lightningSpearStaminaCost) {
					comboTrue = "Lightning Spear";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.lightningSpearStaminaCost) {
					lastAttackButtonPressed = "Lightning Spear";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Angelic Barrage":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.angelicBarrageStaminaCost) {
					comboTrue = "Angelic Barrage";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.angelicBarrageStaminaCost) {
					lastAttackButtonPressed = "Angelic Barrage";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Whirlwind":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.whirlwindStaminaCost) {
					comboTrue = "Whirlwind";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.whirlwindStaminaCost) {
					lastAttackButtonPressed = "Whirlwind";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
	#endregion
	#region Necromancy Abilities
		case "Death Incarnate":
			if !obj_skill_tree.deathIncarnateFirstPhaseActive {
				if combo_ {
					if (playerCurrentStamina >= obj_skill_tree.deathIncarnateStaminaCost) {
						comboTrue = "Death Incarnate";
						comboTrueTimer = 10;
					}
					else {
						comboTrue = "";
						comboPlayerDirectionFacing = -1;
						lastAttackButtonPressed = "";
					}
				}
				else {
					if (playerCurrentStamina >= obj_skill_tree.deathIncarnateStaminaCost) {
						lastAttackButtonPressed = "Death Incarnate";
						execute_attacks();
					}
					else {
						lastAttackButtonPressed = "";
					}
				}
			}
			else {
				if combo_ {
					comboTrue = "Death Incarnate";
					comboTrueTimer = 10;
				}
				else {
					lastAttackButtonPressed = "Death Incarnate";
					execute_attacks();
				}
			}
			break;
		case "Ritual of Imperfection":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost) {
					comboTrue = "Ritual of Imperfection";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost) {
					lastAttackButtonPressed = "Ritual of Imperfection";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Ritual of Death":
			if instance_exists(obj_dead_body) {
				var dead_body_found_ = false;
				var nearest_dead_body_ = instance_nearest(x, y, obj_dead_body);
				if point_distance(x, y, nearest_dead_body_.x, nearest_dead_body_.y) <= obj_skill_tree.ritualOfDeathRange {
					dead_body_found_ = true;
				}
				if dead_body_found_ {
					if combo_ {
						if ((playerCurrentStamina + (playerStaminaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathStaminaCost) {
							comboTrue = "Ritual of Death";
							comboTrueTimer = 10;
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if ((playerCurrentStamina + (playerStaminaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathStaminaCost) {
							lastAttackButtonPressed = "Ritual of Death";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
			}
			break;
		case "Soul Tether":
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					if combo_ {
						if (playerCurrentStamina >= obj_skill_tree.soulTetherStaminaCost) {
							comboTrue = "Soul Tether";
							comboTrueTimer = 10;
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if (playerCurrentStamina >= obj_skill_tree.soulTetherStaminaCost) {
							lastAttackButtonPressed = "Soul Tether";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
				else {
					comboTrue = "";
					lastAttackButtonPressed = "";
				}
			}
			else {
				comboTrue = "";
				lastAttackButtonPressed = "";
			}
			break;
		case "Dinner is Served":
			if variable_global_exists("objectIDsInBattle") {
				if ds_exists(objectIDsInBattle, ds_type_list) {
					if combo_ {
						if (playerCurrentStamina >= obj_skill_tree.dinnerIsServedStaminaCost) {
							comboTrue = "Dinner is Served";
							comboTrueTimer = 10;
						}
						else {
							comboTrue = "";
							comboPlayerDirectionFacing = -1;
							lastAttackButtonPressed = "";
						}
					}
					else {
						if (playerCurrentStamina >= obj_skill_tree.dinnerIsServedStaminaCost) {
							lastAttackButtonPressed = "Dinner is Served";
							execute_attacks();
						}
						else {
							lastAttackButtonPressed = "";
						}
					}
				}
				else {
					comboTrue = "";
					lastAttackButtonPressed = "";
				}
			}
			else {
				comboTrue = "";
				lastAttackButtonPressed = "";
			}
			break;
		case "Final Parting":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.finalPartingStaminaCost) {
					comboTrue = "Final Parting";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.finalPartingStaminaCost) {
					lastAttackButtonPressed = "Final Parting";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Risk of Life":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.riskOfLifeStaminaCost) {
					comboTrue = "riskOfLife";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.riskOfLifeStaminaCost) {
					lastAttackButtonPressed = "Risk of Life";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Taken for Pain":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.takenForPainStaminaCost) {
					comboTrue = "Taken for Pain";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.takenForPainStaminaCost) {
					lastAttackButtonPressed = "Taken for Pain";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
		case "Sickly Proposition":
			if combo_ {
				if (playerCurrentStamina >= obj_skill_tree.sicklyPropositionStaminaCost) {
					comboTrue = "Sickly Proposition";
					comboTrueTimer = 10;
				}
				else {
					comboTrue = "";
					comboPlayerDirectionFacing = -1;
					lastAttackButtonPressed = "";
				}
			}
			else {
				if (playerCurrentStamina >= obj_skill_tree.sicklyPropositionStaminaCost) {
					lastAttackButtonPressed = "Sickly Proposition";
					execute_attacks();
				}
				else {
					lastAttackButtonPressed = "";
				}
			}
			break;
	#endregion
	}





}
