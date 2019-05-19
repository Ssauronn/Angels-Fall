/// @description Obselete - keeping for legacy purposes - Manage the views for all rooms
/*
// Set up camera management variables, specifically the ideal height and width (I set to height
// because I want the height to be static). Width can vary without impacting gameplay too much. 
// I also set camera zoom variables.
idealHeight = 270;
idealWidth = 480;
cameraZoom = 1;
maxCameraZoom = 1;
aspectRatio = display_get_width() / display_get_height();
idealHeight = round(idealHeight);
idealWidth = round(idealWidth);


// The below code can be used instead of the above line to scale the height perfectly, and instead
// dynamically change the width of the shown level, scaled to the height. In other words, the amount
// of the level shown vertically will stay the same, but the amount of the level shown horizontally 
// will change.
/*idealWidth = round(idealHeight * aspectRatio); */
// If I wanted to keep a static width, and vary the height, the line below would be the code I'd use
/* idealHeight = round(idealWidth / aspectRatio); */


// Here I use the bitwise operator AND to round the aspect ratio up one pixel if the current
// aspect ratio is an odd number. I do this because odd numbers never scale well
/*
if idealHeight & 1 {
	idealHeight += 1;
}
if idealWidth & 1 {
	idealWidth += 1;
}

// Set the maximum amount the game can be zoomed into, assuming I allow zoom
maxCameraZoom = floor(display_get_width() / idealWidth);

globalvar camera;
camera = camera_create_view(0, 0, idealWidth, idealHeight, 0, noone, 0, 0, 0, 0);
camera_set_view_size(camera, idealWidth, idealHeight);

// Set the viewports and camera up for each individual room I have
var i;
// I don't set i to 0 because the room this object starts in is room 0
for (i = 1; i <= room_last; i++) {
	if room_exists(i) {
		room_set_view_enabled(i, true);
		room_set_viewport(i, 0, true, 0, 0, idealWidth, idealHeight);
		room_set_camera(i, 0, camera);
	}
}

surface_resize(application_surface, idealWidth, idealHeight);
display_set_gui_size(idealWidth, idealHeight);
window_set_size(idealWidth * cameraZoom, idealHeight * cameraZoom);

room_goto(room_next(room));


