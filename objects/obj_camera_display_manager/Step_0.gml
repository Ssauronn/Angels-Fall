/// @description Handle Changing Camera Variables
if obj_player.key_zoom {
	zoom++;
	
	if zoom > maxZoom {
		zoom = maxZoom;
	}
	
	window_set_size((idealWidth * zoom), (idealHeight * zoom));
	surface_resize(application_surface, (idealWidth * zoom), (idealHeight * zoom));
	alarm[0] = 1;
}


// Follow player - Done at end of step event to complete task right before draw event
// Subract half the view size so that the player is centered
viewX = target.x - (viewW / 2);
viewY = target.y - (viewH / 2);

// Make sure the camera cannot go outside room bounds
viewX = clamp(viewX, 0, (room_width - viewW));
viewY = clamp(viewY, 0, (room_height - viewH));


