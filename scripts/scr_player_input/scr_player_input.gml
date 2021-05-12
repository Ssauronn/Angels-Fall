///@description PlayerInputScript
function scr_player_input() {
	key_restart = false;


	key_escape = keyboard_check_released(vk_escape);


	key_interact = keyboard_check_pressed(ord("R"));


	key_dialogue_choice_one = keyboard_check_pressed(ord("X"));
	key_dialogue_choice_two = keyboard_check_pressed(ord("C"));
	key_dialogue_choice_three = keyboard_check_pressed(ord("V"));
	key_dialogue_choice_four = keyboard_check_pressed(ord("B"));


	if !menuOpen {
		// get movement inputs
		key_nokey = ((!keyboard_check(ord("W"))) && (!keyboard_check(ord("A"))) && (!keyboard_check(ord("S"))) && (!keyboard_check(ord("D"))));
		key_up = (keyboard_check(ord("W")));
		key_right = (keyboard_check(ord("D")));
		key_down = (keyboard_check(ord("S")));
		key_left = (keyboard_check(ord("A")));

		// get blood magic ability input
		key_prime_ability = (keyboard_check_pressed(ord("Q")));
		// get collect animecro input
		key_animecro_collect = (keyboard_check_pressed(ord("E")));

		// get ability inputs
		// choose the ability to equip
		key_bar_equip_ability_one = keyboard_check_pressed(ord("1"));
		key_bar_equip_ability_two = keyboard_check_pressed(ord("2"));
		key_bar_equip_ability_three = keyboard_check_pressed(ord("3"));
		key_bar_equip_ability_four = keyboard_check_pressed(ord("4"));
		if key_bar_equip_ability_one {
			with obj_skill_tree {
				keyBarAbilityOneEquipped = true;
				keyBarAbilityTwoEquipped = false;
				keyBarAbilityThreeEquipped = false;
				keyBarAbilityFourEquipped = false;
			}
		}
		else if key_bar_equip_ability_two {
			with obj_skill_tree {
				keyBarAbilityOneEquipped = false;
				keyBarAbilityTwoEquipped = true;
				keyBarAbilityThreeEquipped = false;
				keyBarAbilityFourEquipped = false;
			}
		}
		else if key_bar_equip_ability_three {
			with obj_skill_tree {
				keyBarAbilityOneEquipped = false;
				keyBarAbilityTwoEquipped = false;
				keyBarAbilityThreeEquipped = true;
				keyBarAbilityFourEquipped = false;
			}
		}
		else if key_bar_equip_ability_four {
			with obj_skill_tree {
				keyBarAbilityOneEquipped = false;
				keyBarAbilityTwoEquipped = false;
				keyBarAbilityThreeEquipped = false;
				keyBarAbilityFourEquipped = true;
			}
		}
		// cast the equipped ability
		key_bar_ability_one = false;
		key_bar_ability_two = false;
		key_bar_ability_three = false;
		key_bar_ability_four = false;
		if mouse_check_button_pressed(mb_right) {
			if obj_skill_tree.keyBarAbilityOneEquipped {
				key_bar_ability_one = true;
			}
			else if obj_skill_tree.keyBarAbilityTwoEquipped {
				key_bar_ability_two = true;
			}
			else if obj_skill_tree.keyBarAbilityThreeEquipped {
				key_bar_ability_three = true;
			}
			else if obj_skill_tree.keyBarAbilityFourEquipped {
				key_bar_ability_four = true;
			}
		}

		// Measure duration of right mouse button held down
		if mouse_check_button(mb_right) {
			key_attack_rmb_time_held_down++;
		}
		else {
			key_attack_rmb_time_held_down = -1;
		}


		// get parry input
		key_parry = (keyboard_check_pressed(ord("F")));


		// get melee attack inputs
		{
			key_attack_lmb = "";
			if mouse_check_button_pressed(mb_left) {
			    var dir_ = point_direction(x,y,mouse_x,mouse_y);
			    if dir_ >= 45 && dir_ < 135 {
					key_attack_lmb = "up";
				}
			    else if dir_ >= 315 && dir_ < 360 {
					key_attack_lmb = "right";
				}
			    else if dir_ >= 0 && dir_ < 45 {
					key_attack_lmb = "right";
				}
			    else if dir_ >= 225 && dir_ < 315 {
					key_attack_lmb = "down";
				}
			    else if dir_ >= 135 && dir_ < 225 {
					key_attack_lmb = "left";
				}
			}
		}
		{
			key_attack_rmb = "";
			if mouse_check_button_pressed(mb_right) {
				var rmbdir_ = point_direction(x, y, mouse_x, mouse_y);
			    if rmbdir_ >= 45 && rmbdir_ < 135 {
					key_attack_rmb = "up";
				}
			    else if rmbdir_ >= 315 && rmbdir_ < 360 {
					key_attack_rmb = "right";
				}
			    else if rmbdir_ >= 0 && rmbdir_ < 45 {
					key_attack_rmb = "right";
				}
			    else if rmbdir_ >= 225 && rmbdir_ < 315 {
					key_attack_rmb = "down";
				}
			    else if rmbdir_ >= 135 && rmbdir_ < 225 {
					key_attack_rmb = "left";
				}
			}
		}
		{
			key_dash = false;
			if  (keyboard_check_pressed(vk_space)) {
				key_dash = true;
			}
		}

		// Camera functions
		key_zoom = (keyboard_check_pressed(ord("Z")));
	}
	else {
		// Stop movement
		currentSpeed = 0;
	
		// Movement keys
		key_nokey = true;
		key_up = false;
		key_right = false;
		key_down = false;
		key_left = false;
		key_dash = false;

		// get blood magic ability input
		key_prime_ability = false;
		// get collect animecro input
		key_animecro_collect = false;

		// get ability inputs
		// choose the ability to equip
		key_bar_equip_ability_one = false;
		key_bar_equip_ability_two = false;
		key_bar_equip_ability_three = false;
		key_bar_equip_ability_four = false;
	
		// Attacking inputs
		// duration of right mouse mutton held down
		key_attack_rmb_time_held_down = -1;
		key_parry = (keyboard_check_pressed(ord("F")));
		key_attack_lmb = false;
		key_attack_rmb = false;
	
		// Camera functions
		key_zoom = (keyboard_check_pressed(ord("Z")));
	}





}
