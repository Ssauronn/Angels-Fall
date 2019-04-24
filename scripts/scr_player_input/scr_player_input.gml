///@description PlayerInputScript
// get movement inputs
key_nokey = ((!keyboard_check(ord("W"))) && (!keyboard_check(ord("A"))) && (!keyboard_check(ord("S"))) && (!keyboard_check(ord("D"))));
key_up = (keyboard_check(ord("W")));
key_right = (keyboard_check(ord("D")));
key_down = (keyboard_check(ord("S")));
key_left = (keyboard_check(ord("A")));

// get slow time input
key_prime_ability = (keyboard_check_pressed(ord("Q")));
// get collect animecro input
key_animecro_collect = (keyboard_check_pressed(ord("E")));


// get parry input
key_parry = (keyboard_check_pressed(ord("F")));


// get melee attack inputs
{
	key_attack_lmb = "";
	if mouse_check_button_pressed(mb_left) {
	    var dir = point_direction(x,y,mouse_x,mouse_y);
	    if dir >= 45 && dir < 135 {
			key_attack_lmb = "up";
		}
	    else if dir >= 315 && dir < 360 {
			key_attack_lmb = "right";
		}
	    else if dir >= 0 && dir < 45 {
			key_attack_lmb = "right";
		}
	    else if dir >= 225 && dir < 315 {
			key_attack_lmb = "down";
		}
	    else if dir >= 135 && dir < 225 {
			key_attack_lmb = "left";
		}
	}
}
{
	key_attack_rmb = "";
	if mouse_check_button_pressed(mb_right) {
		var rmbdir = point_direction(x, y, mouse_x, mouse_y);
	    if rmbdir >= 45 && rmbdir < 135 {
			key_attack_rmb = "up";
		}
	    else if rmbdir >= 315 && rmbdir < 360 {
			key_attack_rmb = "right";
		}
	    else if rmbdir >= 0 && rmbdir < 45 {
			key_attack_rmb = "right";
		}
	    else if rmbdir >= 225 && rmbdir < 315 {
			key_attack_rmb = "down";
		}
	    else if rmbdir >= 135 && rmbdir < 225 {
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




