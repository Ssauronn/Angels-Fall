/// @description Draw Self and Healthbar
draw_set_alpha(1);
if !is_undefined(enemyCurrentHP) {
	draw_healthbar(x - 16, y - 22, x + 16, y - 18, (enemyCurrentHP / enemyMaxHP) * 100, c_black, c_red, c_lime, 0, false, false);
	if instance_exists(currentTargetToFocus) {
		draw_arrow(x, y, currentTargetToFocus.x, currentTargetToFocus.y, 20)
	}
	//draw_rectangle(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + (tetherXRange / 2), camera_get_view_y(view_camera[0]) + (tetherYRange / 2), true)
	//draw_rectangle(camera_get_view_x(view_camera[0]) - (tetherXRange / 2) + 100, camera_get_view_y(view_camera[0]) - (tetherYRange / 2) + 100, camera_get_view_x(view_camera[0]) + (tetherXRange / 2) - 100, camera_get_view_y(view_camera[0]) + (tetherYRange / 2) - 100, true)
	draw_rectangle((camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - (tetherXRange / 2) + 1, (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - (tetherYRange / 2) + 1, (camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) + (tetherXRange / 2) - 1, (camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) + (tetherYRange / 2) - 1, true)
	draw_text_ext_transformed(x, y, string(self.id), 10, 32, 1, 1, 0);
	if enemyAnimationSprite != noone {
		draw_sprite_ext(enemyAnimationSprite, enemyAnimationImageIndex, enemyAnimationX, enemyAnimationY, 2, 2, 0, c_white, 1);
	}

	if !is_undefined(myPath) {
		if path_exists(myPath) {
			draw_path(myPath, x, y, false)
		}
	}

	draw_sprite(enemySprite[enemyStateSprite, enemyDirectionFacing], enemyImageIndex, x, y);
	if variable_instance_exists(self.id, "slowEnemyTimeWithParryActive") {
		if slowEnemyTimeWithParryActive {
			draw_rectangle_color(x - 16, y - 16, x + 16, y + 16, c_purple, c_purple, c_purple, c_purple, false)
		}
	}
	if combatFriendlyStatus == "Minion" {
		draw_text_ext_transformed_color(x - 20, y - 40, "Minion", 10, 32, 1, 1, 0, c_blue, c_blue, c_blue, c_blue, 1);
	}
	else if combatFriendlyStatus == "Enemy" {
		draw_text_ext_transformed_color(x - 20, y - 40, "Enemy", 10, 32, 1, 1, 0, c_red, c_red, c_red, c_red, 1);
	}
}


