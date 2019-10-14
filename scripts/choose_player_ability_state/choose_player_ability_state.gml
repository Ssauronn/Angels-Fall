///@description Switch Statement for choosing the correct ability state to send the player to after an
/// ability button is pressed.
///@argument0 EquippedAbilityInKeyPressedSlot
///@argument1 ComboingFromAbility?

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
					if (playerCurrentStamina >= obj_skill_tree.wrathOfTheDiaboliStaminaCost) && (playerCurrentMana >= obj_skill_tree.wrathOfTheDiaboliManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.wrathOfTheDiaboliStaminaCost) && (playerCurrentMana >= obj_skill_tree.wrathOfTheDiaboliManaCost) {
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
				if (playerCurrentStamina >= obj_skill_tree.glintingBladeStaminaCost) && (playerCurrentMana >= obj_skill_tree.glintingBladeManaCost) {
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
				if (playerCurrentStamina >= obj_skill_tree.glintingBladeStaminaCost) && (playerCurrentMana >= obj_skill_tree.glintingBladeManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.hellishLandscapeStaminaCost) && (playerCurrentMana >= obj_skill_tree.hellishLandscapeManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.hellishLandscapeStaminaCost) && (playerCurrentMana >= obj_skill_tree.hellishLandscapeManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.hiddenDaggerStaminaCost) && (playerCurrentMana >= obj_skill_tree.hiddenDaggerManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.hiddenDaggerStaminaCost) && (playerCurrentMana >= obj_skill_tree.hiddenDaggerManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.allOutAttackStaminaCost) && (playerCurrentMana >= obj_skill_tree.allOutAttackManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.allOutAttackStaminaCost) && (playerCurrentMana >= obj_skill_tree.allOutAttackManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.exploitWeaknessStaminaCost) && (playerCurrentMana >= obj_skill_tree.exploitWeaknessManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.exploitWeaknessStaminaCost) && (playerCurrentMana >= obj_skill_tree.exploitWeaknessManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.purifyingRageStaminaCost) && (playerCurrentMana >= obj_skill_tree.purifyingRageManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.purifyingRageStaminaCost) && (playerCurrentMana >= obj_skill_tree.purifyingRageManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.rushdownStaminaCost) && (playerCurrentMana >= obj_skill_tree.rushdownManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.rushdownStaminaCost) && (playerCurrentMana >= obj_skill_tree.rushdownManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.diabolusBlastStaminaCost) && (playerCurrentMana >= obj_skill_tree.diabolusBlastManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.diabolusBlastStaminaCost) && (playerCurrentMana >= obj_skill_tree.diabolusBlastManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.trueCaelestiWingsStaminaCost) && (playerCurrentMana >= obj_skill_tree.trueCaelestiWingsManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.trueCaelestiWingsStaminaCost) && (playerCurrentMana >= obj_skill_tree.trueCaelestiWingsManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.bindingsOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.bindingsOfTheCaelestiManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.bindingsOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.bindingsOfTheCaelestiManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.armorOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.armorOfTheCaelestiManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.armorOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.armorOfTheCaelestiManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.holyDefenseStaminaCost) && (playerCurrentMana >= obj_skill_tree.holyDefenseManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.holyDefenseStaminaCost) && (playerCurrentMana >= obj_skill_tree.holyDefenseManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.wrathOfTheRepentantStaminaCost) && (playerCurrentMana >= obj_skill_tree.wrathOfTheRepentantManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.wrathOfTheRepentantStaminaCost) && (playerCurrentMana >= obj_skill_tree.wrathOfTheRepentantManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.theOnePowerStaminaCost) && (playerCurrentMana >= obj_skill_tree.theOnePowerManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.theOnePowerStaminaCost) && (playerCurrentMana >= obj_skill_tree.theOnePowerManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.lightningSpearStaminaCost) && (playerCurrentMana >= obj_skill_tree.lightningSpearManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.lightningSpearStaminaCost) && (playerCurrentMana >= obj_skill_tree.lightningSpearManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.angelicBarrageStaminaCost) && (playerCurrentMana >= obj_skill_tree.angelicBarrageManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.angelicBarrageStaminaCost) && (playerCurrentMana >= obj_skill_tree.angelicBarrageManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.whirlwindStaminaCost) && (playerCurrentMana >= obj_skill_tree.whirlwindManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.whirlwindStaminaCost) && (playerCurrentMana >= obj_skill_tree.whirlwindManaCost) {
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
				if (playerCurrentStamina >= obj_skill_tree.deathIncarnateStaminaCost) && (playerCurrentMana >= obj_skill_tree.deathIncarnateManaCost) {
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
				if (playerCurrentStamina >= obj_skill_tree.deathIncarnateStaminaCost) && (playerCurrentMana >= obj_skill_tree.deathIncarnateManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost) {
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
					if ((playerCurrentStamina + (playerStaminaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathStaminaCost) && ((playerCurrentMana + (playerManaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathManaCost) {
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
					if ((playerCurrentStamina + (playerStaminaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathStaminaCost) && ((playerCurrentMana + (playerManaRegeneration * 7)) >= obj_skill_tree.ritualOfDeathManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.soulTetherStaminaCost) && (playerCurrentMana >= obj_skill_tree.soulTetherManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.soulTetherStaminaCost) && (playerCurrentMana >= obj_skill_tree.soulTetherManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.dinnerIsServedStaminaCost) && (playerCurrentMana >= obj_skill_tree.dinnerIsServedManaCost) {
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
					if (playerCurrentStamina >= obj_skill_tree.dinnerIsServedStaminaCost) && (playerCurrentMana >= obj_skill_tree.dinnerIsServedManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.finalPartingStaminaCost) && (playerCurrentMana >= obj_skill_tree.finalPartingManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.finalPartingStaminaCost) && (playerCurrentMana >= obj_skill_tree.finalPartingManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.riskOfLifeStaminaCost) && (playerCurrentMana >= obj_skill_tree.riskOfLifeManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.riskOfLifeStaminaCost) && (playerCurrentMana >= obj_skill_tree.riskOfLifeManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.takenForPainStaminaCost) && (playerCurrentMana >= obj_skill_tree.takenForPainManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.takenForPainStaminaCost) && (playerCurrentMana >= obj_skill_tree.takenForPainManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.sicklyPropositionStaminaCost) && (playerCurrentMana >= obj_skill_tree.sicklyPropositionManaCost) {
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
			if (playerCurrentStamina >= obj_skill_tree.sicklyPropositionStaminaCost) && (playerCurrentMana >= obj_skill_tree.sicklyPropositionManaCost) {
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


