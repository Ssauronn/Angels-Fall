/// @description Draw Player objects
draw_self();
draw_set_alpha(1);
draw_healthbar(x - 16, y - 49, x + 16, y - 45, 1 * 100, c_black, c_black, c_black, 0, false, false);
draw_healthbar(x - 16, y - 49, x + 16, y - 45, (playerCurrentHP / playerMaxHP) * 100, c_black, c_red, c_lime, 0, false, false);
draw_healthbar(x - 16, y - 44, x + 16, y - 40, (playerCurrentStamina / playerMaxStamina) * 100, c_black, c_green, c_green, 0, false, false);
draw_healthbar(x - 16, y - 39, x + 16, y - 35, (playerCurrentMana / playerMaxMana) * 100, c_black, c_blue, c_blue, 0, false, false);
draw_healthbar(x - 16, y - 34, x + 16, y - 30, (playerCurrentBloodMagic / playerMaxBloodMagic) * 100, c_black, c_purple, c_purple, 0, false, false);
if playerAnimationSprite != noone {
	draw_sprite(playerAnimationSprite, playerAnimationImageIndex, playerAnimationX, playerAnimationY);
}


