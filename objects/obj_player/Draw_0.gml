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

var circle_x_ = x + lengthdir_x(48, n);
var circle_y_ = y + lengthdir_y(48, n);
n += 360 / (room_speed * 2.8);
if n >= 360 {
	n -= 360
}
draw_circle_color(circle_x_, circle_y_, 16, c_red, c_red, true);

