///@description Send the player to the correct state based on the currently equipped ability
///@argument0 ComboingFromAttack?

var combo_ = argument0;

if !combo_ {
	if key_bar_ability_one {
		choose_player_ability_state(obj_skill_tree.keyBarAbilityOneChosen, combo_);
	}
	else if key_bar_ability_two {
		choose_player_ability_state(obj_skill_tree.keyBarAbilityTwoChosen, combo_);
	}
	else if key_bar_ability_three {
		choose_player_ability_state(obj_skill_tree.keyBarAbilityThreeChosen, combo_);
	}
	else if key_bar_ability_four {
		choose_player_ability_state(obj_skill_tree.keyBarAbilityFourChosen, combo_);
	}
}
else {
	if comboAbilityButton == 1 {
		comboAbilityButton = 0;
		choose_player_ability_state(obj_skill_tree.keyBarAbilityOneChosen, combo_);
	}
	else if comboAbilityButton == 2 {
		comboAbilityButton = 0;
		choose_player_ability_state(obj_skill_tree.keyBarAbilityTwoChosen, combo_);
	}
	else if comboAbilityButton == 3 {
		comboAbilityButton = 0;
		choose_player_ability_state(obj_skill_tree.keyBarAbilityThreeChosen, combo_);
	}
	else if comboAbilityButton == 4 {
		comboAbilityButton = 0;
		choose_player_ability_state(obj_skill_tree.keyBarAbilityFourChosen, combo_);
	}
}


