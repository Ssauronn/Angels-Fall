/// @description Draw Player objects
if obj_skill_tree.ritualOfImperfectionCurrentCastTime >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForThirdDemon {
	draw_sprite_ext(spr_ritual_of_imperfection_powering_up, 0, x, y, 1, 1, 0, c_red, 1);
}
else if obj_skill_tree.ritualOfImperfectionCurrentCastTime >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForSecondDemon {
	draw_sprite_ext(spr_ritual_of_imperfection_powering_up, 0, x, y, 1, 1, 0, c_orange, 1);
}
else if obj_skill_tree.ritualOfImperfectionCurrentCastTime >= obj_skill_tree.ritualOfImperfectionCastTimeRequiredForFirstDemon {
	draw_sprite_ext(spr_ritual_of_imperfection_powering_up, 0, x, y, 1, 1, 0, c_yellow, 1);
}
else if obj_skill_tree.ritualOfImperfectionCurrentCastTime >= 0 {
	draw_sprite_ext(spr_ritual_of_imperfection_powering_up, 0, x, y, 1, 1, 0, c_white, 1);
}
draw_self();
draw_set_alpha(1);
draw_healthbar(x - 16, y - 49, x + 16, y - 45, 1 * 100, c_black, c_black, c_black, 0, false, false);
draw_healthbar(x - 16, y - 49, x + 16, y - 45, (playerCurrentHP / playerMaxHP) * 100, c_black, c_red, c_lime, 0, false, false);
draw_healthbar(x - 16, y - 44, x + 16, y - 40, (playerCurrentStamina / playerMaxStamina) * 100, c_black, c_green, c_green, 0, false, false);
draw_healthbar(x - 16, y - 39, x + 16, y - 35, (playerCurrentMana / playerMaxMana) * 100, c_black, c_blue, c_blue, 0, false, false);
draw_healthbar(x - 16, y - 34, x + 16, y - 30, (playerCurrentBloodMagic / playerMaxBloodMagic) * 100, c_black, c_purple, c_purple, 0, false, false);
if obj_skill_tree.allOutAttackActive {
	playerAnimationSprite = spr_prime_damage_buff;
	playerAnimationX = x;
	playerAnimationY = y;
}
if playerAnimationSprite != noone {
	draw_sprite(playerAnimationSprite, playerAnimationImageIndex, playerAnimationX, playerAnimationY);
}

if obj_skill_tree.theOnePowerActive {
	draw_circle_color(obj_skill_tree.theOnePowerOriginXPos, obj_skill_tree.theOnePowerOriginYPos, 16, c_red, c_red, true);
}
if obj_skill_tree.glintingBladeActive {
	draw_circle_color(obj_skill_tree.glintingBladeXPos, obj_skill_tree.glintingBladeYPos, 3, c_red, c_blue, true);
}


