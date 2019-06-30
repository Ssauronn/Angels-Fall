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
			comboTrue = "Glinting Blade";
		}
		else {
			lastAttackButtonPressed = "Glinting Blade";
			execute_attacks();
		}
		break;
	case "Hellish Landscape":
		if combo_ {
			comboTrue = "Hellish Landscape";
		}
		else {
			lastAttackButtonPressed = "Hellish Landscape";
			execute_attacks();
		}
		break;
	case "Hidden Dagger":
		if combo_ {
			comboTrue = "Hidden Dagger";
		}
		else {
			lastAttackButtonPressed = "Hidden Dagger";
			execute_attacks();
		}
		break;
	case "All Out Attack":
		if combo_ {
			comboTrue = "All Out Attack";
		}
		else {
			lastAttackButtonPressed = "All Out Attack";
			execute_attacks();
		}
		break;
	case "Exploit Weakness":
		if combo_ {
			comboTrue = "Exploit Weakness";
		}
		else {
			lastAttackButtonPressed = "Exploit Weakness";
			execute_attacks();
		}
		break;
	case "Purifying Rage":
		if combo_ {
			comboTrue = "Purifying Rage";
		}
		else {
			lastAttackButtonPressed = "Purifying Rage";
			execute_attacks();
		}
		break;
	case "Rushdown":
		if combo_ {
			comboTrue = "Rushdown";
		}
		else {
			lastAttackButtonPressed = "Rushdown";
			execute_attacks();
		}
		break;
	case "Diabolus Blast":
		if combo_ {
			comboTrue = "Diabolus Blast";
		}
		else {
			lastAttackButtonPressed = "Diabolus Blast";
			execute_attacks();
		}
		break;
	#endregion
	#region Caelesti Abilities
	case "True Caelesti Wings":
		if combo_ {
			comboTrue = "True Caelesti Wings";
		}
		else {
			lastAttackButtonPressed = "True Caelesti Wings";
			execute_attacks();
		}
		break;
	case "Bindings of the Caelesti":
		if combo_ {
			comboTrue = "Bindings of the Caelesti";
		}
		else {
			lastAttackButtonPressed = "Bindings of the Caelesti";
			execute_attacks();
		}
		break;
	case "Armor of the Caelesti":
		if combo_ {
			comboTrue = "Armor of the Caelesti";
		}
		else {
			lastAttackButtonPressed = "Armor of the Caelesti";
			execute_attacks();
		}
		break;
	case "Holy Defense":
		if combo_ {
			comboTrue = "Holy Defense";
		}
		else {
			lastAttackButtonPressed = "Holy Defense";
			execute_attacks();
		}
		break;
	case "Wrath of the Repentant":
		if combo_ {
			comboTrue = "Wrath of the Repentant";
		}
		else {
			lastAttackButtonPressed = "Wrath of the Repentant";
			execute_attacks();
		}
		break;
	case "The One Power":
		if combo_ {
			comboTrue = "The One Power";
		}
		else {
			lastAttackButtonPressed = "The One Power";
			execute_attacks();
		}
		break;
	case "Lightning Spear":
		if combo_ {
			comboTrue = "Lightning Spear";
		}
		else {
			lastAttackButtonPressed = "Lightning Spear";
			execute_attacks();
		}
		break;
	case "Angelic Barrage":
		if combo_ {
			comboTrue = "Angelic Barrage";
		}
		else {
			lastAttackButtonPressed = "Angelic Barrage";
			execute_attacks();
		}
		break;
	case "Whirlwind":
		if combo_ {
			comboTrue = "Whirlwind";
		}
		else {
			lastAttackButtonPressed = "Whirlwind";
			execute_attacks();
		}
		break;
	#endregion
	#region Necromancy Abilities
	case "Death Incarnate":
		if combo_ {
			comboTrue = "Death Incarnate";
		}
		else {
			lastAttackButtonPressed = "Death Incarnate";
			execute_attacks();
		}
		break;
	case "Ritual of Imperfection":
		if combo_ {
			comboTrue = "Ritual of Imperfection";
		}
		else {
			lastAttackButtonPressed = "Ritual of Imperfection";
			execute_attacks();
		}
		break;
	case "Ritual of Death":
		if combo_ {
			comboTrue = "Ritual of Death";
		}
		else {
			lastAttackButtonPressed = "Ritual of Death";
			execute_attacks();
		}
		break;
	case "Soul Tether":
		if combo_ {
			comboTrue = "Soul Tether";
		}
		else {
			lastAttackButtonPressed = "Soul Tether";
			execute_attacks();
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


