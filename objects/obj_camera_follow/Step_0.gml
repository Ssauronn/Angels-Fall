/// @description Move Camera
if followObject != noone {
	moveXTo = followObject.x;
	moveYTo = followObject.y;
}

x += (moveXTo - x) / cameraFollowSpeed;
y += (moveYTo - y) / cameraFollowSpeed;


