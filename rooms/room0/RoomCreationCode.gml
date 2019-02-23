/*view_visible[0] = true;
view_enabled = true;

// Variable used to change gui ratio and/or gui aspect ratio. if this is changed, this same variable needs to be changed in the Create event in obj_equipped_inventory_gui as well.
globalvar guiAspectScaling, guiScalingVector;
guiAspectScaling = 0.1;
guiScalingVector = 1 / guiAspectScaling;

// Camera below is created in obj_combat_controller
var viewmat = matrix_build_lookat(obj_player.x, obj_player.y, -10, obj_player.x, obj_player.y, 0, 0, 1, 0);
var projmat = matrix_build_projection_ortho(480, 270, 1.0, 32000.0);
camera_set_view_mat(camera, viewmat);
camera_set_proj_mat(camera, projmat);

view_set_camera(0, camera);

display_set_gui_size(480, 270);
*/



