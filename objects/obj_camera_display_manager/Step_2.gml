/// @description Set Camera Variables
camera_set_view_size(view_camera[0], viewW, viewH);

var round_x_ = viewW / surface_get_width(application_surface);
var current_x_ = camera_get_view_x(view_camera[0]);
var current_y_ = camera_get_view_y(view_camera[0]);
var target_x_ = round_to_n_multiple(viewX, round_x_);
var target_y_ = round_to_n_multiple(viewY, round_x_);
var move_to_x_ = round_to_n_multiple((camera_get_view_x(view_camera[0]) + ((target_x_ - current_x_) / 4)), round_x_);
var move_to_y_ = round_to_n_multiple((camera_get_view_y(view_camera[0]) + ((target_y_ - current_y_) / 4)), round_x_);
//camera_set_view_pos(view_camera[0], target_x_, target_y_);
camera_set_view_pos(view_camera[0], move_to_x_, move_to_y_);


