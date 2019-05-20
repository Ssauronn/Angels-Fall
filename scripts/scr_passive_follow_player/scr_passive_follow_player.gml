if ds_exists(objectIDsInBattle, ds_type_list) {
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	decisionMadeForTargetAndAction = false;
	chosenEngine = "";
	alreadyTriedToChase = false;
}
else {
	// FOLLOW PLAYER USING SAME FUNCTIONS IN scr_move_within_attack_range HERE
}

if stunActive {
	enemyState = enemystates.stunned;
	enemyStateSprite = enemystates.stunned;
	enemyImageIndex = 0;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
}


