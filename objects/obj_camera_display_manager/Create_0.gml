/// @description Initialize Camera Variables
target = obj_player;
idealHeight = 270;
maxZoom = 1;
zoom = maxZoom;
displayWidth = display_get_width();
displayHeight = display_get_height();

aspectRatio = displayWidth / displayHeight;
idealWidth = round(idealHeight * aspectRatio);

// Perfect Pixel Scaling
if displayWidth mod idealWidth != 0 {
	var display_;
	display_ = round(displayWidth / idealWidth);
	idealWidth = displayWidth / display_;
}
if displayHeight mod idealHeight != 0 {
	var display_;
	display_ = round(displayHeight / idealHeight);
	idealHeight = displayHeight / display_;
}

// Check for odd numbers
if idealWidth & 1 {
	idealWidth++;
}
if idealHeight & 1 {
	idealHeight++;
}

// Calculate Max Zoom
zoom = maxZoom;
maxZoom = floor(displayWidth / idealWidth);

// Set window to match the correct aspect scaling for the game
window_set_size(idealWidth, idealHeight);
display_set_gui_size(idealWidth, idealHeight);
surface_resize(application_surface, (idealWidth * zoom), (idealHeight * zoom));

alarm[0] = 1;

// Camera variables
camera = camera_create();
globalvar viewX, viewY, viewW, viewH;
viewX = 0;
viewY = 0;
viewW = idealWidth;
viewH = idealHeight;

room_goto_next();


