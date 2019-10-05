///@description Ready Up for Parry
if !obj_skill_tree.parryWindowActive && !obj_skill_tree.successfulParryInvulnerabilityActive {
	playerState = playerstates.idle;
	playerStateSprite = playerstates.idle;
	playerImageIndex = 0;
	playerCurrentMana -= obj_skill_tree.parryFailureManaCost;
}
else if obj_skill_tree.successfulParryInvulnerabilityActive {
	playerState = playerstates.parryeffect;
	playerStateSprite = playerstates.parryeffect;
	playerImageIndex = 0;
}


