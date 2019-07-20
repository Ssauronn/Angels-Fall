var target_ = obj_skill_tree.glintingBladeAttachedToEnemy;
// Create the playerHitbox after frame 2
// If the frame count is above 2 and the hitbox hasn't been created yet, create the hitbox
if (!hitboxCreated) && (playerImageIndex > 2) {
	// Mark the hitbox as created and create the hitbox.
	hitboxCreated = true;
	create_dot_tic_hitbox(target_, obj_skill_tree.glintingBladeAttachedDamage, true);
	// Mark the debuff on the enemy target as inactive.
	target_.glintingBladeActive = false;
	target_.glintingBladeTimer = -1;
	// I don't need to type out the next two lines anyways, but I do just as a precaution.
	obj_skill_tree.glintingBladeActive = false;
	obj_skill_tree.glintingBladeTimer = -1;
	// Reset all other variables located inside obj_skill_tree
	obj_skill_tree.glintingBladeAttachedToEnemy = noone;
	obj_skill_tree.glintingBladeArrivedAtTargetPos = false;
	obj_skill_tree.glintingBladeTargetXPos = 0;
	obj_skill_tree.glintingBladeTargetYPos = 0;
	obj_skill_tree.glintingBladeXPos = 0;
	obj_skill_tree.glintingBladeYPos = 0;
}
// If the frame count hits max, that means the animation has ended and its time to reset.
if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
	playerImageIndex = 0;
	playerState = playerstates.idle;
	playerStateSprite = playerstates.idle;
	hitboxCreated = false;
}


