/// @description Draw Self and Healthbar
draw_set_alpha(1);
draw_healthbar(x - 16, y - 22, x + 16, y - 18, (enemyCurrentHP / enemyMaxHP) * 100, c_black, c_red, c_lime, 0, false, false);
draw_self();
if variable_instance_exists(self, "slowEnemyTimeWithParryActive") {
	if slowEnemyTimeWithParryActive {
		draw_rectangle_color(x - 16, y - 4, x + 16, y + 4, c_purple, c_purple, c_purple, c_purple, false)
	}
}
if instance_exists(currentTargetToFocus) {
	draw_arrow(x, y, currentTargetToFocus.x, currentTargetToFocus.y, 2000)
}
//draw_rectangle(camera_get_view_x(camera) - 32, camera_get_view_y(camera) - 32, camera_get_view_x(camera) + (tetherXRange / 2), camera_get_view_y(camera) + (tetherYRange / 2), true)
//draw_rectangle(camera_get_view_x(camera) - (tetherXRange / 2) + 100, camera_get_view_y(camera) - (tetherYRange / 2) + 100, camera_get_view_x(camera) + (tetherXRange / 2) - 100, camera_get_view_y(camera) + (tetherYRange / 2) - 100, true)
//draw_rectangle((camera_get_view_x(camera) + (camera_get_view_width(camera) / 2)) - (tetherXRange / 2), (camera_get_view_y(camera) + (camera_get_view_height(camera) / 2)) - (tetherYRange / 2), (camera_get_view_x(camera) + (camera_get_view_width(camera) / 2)) + (tetherXRange / 2), (camera_get_view_y(camera) + (camera_get_view_height(camera) / 2)) + (tetherYRange / 2), true)
draw_text_ext_transformed(x, y, string(self.id), 10, 32, 1, 1, 0);


