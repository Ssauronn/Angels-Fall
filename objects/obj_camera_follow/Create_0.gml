/// @description Set follow variables up
idealHeight = 270;
idealWidth = 480;
idealHeight = round(idealHeight);
idealWidth = round(idealWidth);
followObject = obj_player;

moveXTo = x;
moveYTo = y;

cameraFollowSpeed = 10;

camera_set_view_target(view_camera[0], self);
camera_set_view_speed(view_camera[0], -1, -1);
camera_set_view_border(view_camera[0], 480, 270);


