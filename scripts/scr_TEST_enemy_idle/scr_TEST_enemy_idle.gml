///@description Idle and Cast Spells and Abilities

// Need to convert most code to execute in scr_magic, and should only be executed if the ability is
// chosen by scr_ai_decision_making AND the enemy has enough mana for it. Also needs to drain mana.
// Send the enemy state to magic state
if (irandom_range(1, (180 * (1 / enemyTotalSpeed))) == 1) {
	if enemyCurrentMana > enemyLightRangedAttackManaCost {
		enemyCurrentMana -= enemyLightRangedAttackManaCost;
		enemyState = enemystates.magic;
		enemyStateSprite = enemystates.magic
	}
}


