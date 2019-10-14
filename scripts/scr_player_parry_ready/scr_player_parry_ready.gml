///@description Ready Up for Parry
// Return to idle playerState if no attack button is pressed while in the attack playerState to combo further
if playerImageIndex >= (sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) - 1) {
	obj_skill_tree.parryWindowActive = false;
	if !obj_skill_tree.successfulParryInvulnerabilityActive {
		playerState = playerstates.idle;
		playerStateSprite = playerstates.idle;
		playerImageIndex = 0;
		playerCurrentMana -= obj_skill_tree.parryFailureManaCost;
	}
	else {
		playerState = playerstates.parryeffect;
		playerStateSprite = playerstates.parryeffect;
		playerImageIndex = 0;
	}
}

