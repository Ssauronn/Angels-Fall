///@description Switch Statement for choosing the correct ability state to send the player to after an
/// ability button is pressed.
///@argument0 EquippedAbilityInKeyPressedSlot
///@argument1 ComboingFromAbility?

var equipped_ability_ = argument0;
var combo_ = argument1;

switch equipped_ability_ {
	#region Diabolus Abilities
	case "Wrath of the Diaboli": 
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.wrathOfTheDiaboliStaminaCost) && (playerCurrentMana >= obj_skill_tree.wrathOfTheDiaboliManaCost) {
				comboTrue = "Wrath of the Diaboli";
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
		break;
	case "Glinting Blade":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.glintingBladeStaminaCost) && (playerCurrentMana >= obj_skill_tree.glintingBladeManaCost) {
				comboTrue = "Glinting Blade";
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
		break;
	case "Hellish Landscape":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.hellishLandscapeStaminaCost) && (playerCurrentMana >= obj_skill_tree.hellishLandscapeManaCost) {
				comboTrue = "Hellish Landscape";
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
	case "Rushdown":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.rushdownStaminaCost) && (playerCurrentMana >= obj_skill_tree.rushdownManaCost) {
				comboTrue = "Rushdown";
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
		break;
	case "Diabolus Blast":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.diabolusBlastStaminaCost) && (playerCurrentMana >= obj_skill_tree.diabolusBlastManaCost) {
				comboTrue = "Diabolus Blast";
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
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.bindingsOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.bindingsOfTheCaelestiManaCost) {
				comboTrue = "Bindings of the Caelesti";
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
		break;
	case "Armor of the Caelesti":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.armorOfTheCaelestiStaminaCost) && (playerCurrentMana >= obj_skill_tree.armorOfTheCaelestiManaCost) {
				comboTrue = "Armor of the Caelesti";
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
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.deathIncarnateStaminaCost) && (playerCurrentMana >= obj_skill_tree.deathIncarnateManaCost) {
				comboTrue = "Death Incarnate";
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
		break;
	case "Ritual of Imperfection":
		if combo_ {
			if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonSaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost) {
				comboTrue = "Ritual of Imperfection";
			}
			else {
				comboTrue = "";
				comboPlayerDirectionFacing = -1;
				lastAttackButtonPressed = "";
			}
		}
		else {
			if (playerCurrentStamina >= obj_skill_tree.ritualOfImperfectionFirstDemonSaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfImperfectionFirstDemonManaCost) {
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
			with obj_dead_body {
				if point_distance(x, y, obj_player.x, obj_player.y) <= obj_skill_tree.ritualOfDeathRange {
					dead_body_found_ = true;
				}
			}
			if dead_body_found_ {
				if combo_ {
					if (playerCurrentStamina >= obj_skill_tree.ritualOfDeathStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfDeathManaCost) {
						comboTrue = "Ritual of Death";
					}
					else {
						comboTrue = "";
						comboPlayerDirectionFacing = -1;
						lastAttackButtonPressed = "";
					}
				}
				else {
					if (playerCurrentStamina >= obj_skill_tree.ritualOfDeathStaminaCost) && (playerCurrentMana >= obj_skill_tree.ritualOfDeathManaCost) {
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
		if variable_global_exists(objectIDsInBattle) {
			if ds_exists(objectIDsInBattle, ds_type_list) {
				if combo_ {
					if (playerCurrentStamina >= obj_skill_tree.soulTetherStaminaCost) && (playerCurrentMana >= obj_skill_tree.soulTetherManaCost) {
						comboTrue = "Soul Tether";
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
		}
		break;
	case "Dinner is Served":
		if combo_ {
			comboTrue = "Dinner is Served";
		}
		else {
			lastAttackButtonPressed = "Dinner is Served";
			execute_attacks();
		}
		break;
	case "Final Parting":
		if combo_ {
			comboTrue = "Final Parting";
		}
		else {
			lastAttackButtonPressed = "Final Parting";
			execute_attacks();
		}
		break;
	case "Risk of Life":
		if combo_ {
			comboTrue = "Risk of Life";
		}
		else {
			lastAttackButtonPressed = "Risk of Life";
			execute_attacks();
		}
		break;
	case "Taken for Pain":
		if combo_ {
			comboTrue = "Taken for Pain";
		}
		else {
			lastAttackButtonPressed = "Taken for Pain";
			execute_attacks();
		}
		break;
	case "Sickly Proposition":
		if combo_ {
			comboTrue = "Sickly Proposition";
		}
		else {
			lastAttackButtonPressed = "Sickly Proposition";
			execute_attacks();
		}
		break;
	#endregion
}


