///@description Stay stunned until the stun timer runs out
function scr_stunned() {
	if !stunActive {
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
	}

	if forceReturnToIdleState {
		forceReturnToIdleState = false;
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
	}





}
