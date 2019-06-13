///@description Track Active Poisons, Buffs, and Debuffs
// If the enemy is poisoned by any poison, this will be set to true by the end of this script
poisoned = false;

#region Debuffs
// True Caelesti Wings
if trueCaelestiWingsDebuffTimer >= 0 {
	trueCaelestiWingsActive = true;
}
if trueCaelestiWingsActive {
	if trueCaelestiWingsDebuffTimer < 0 {
		trueCaelestiWingsActive = false;
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
	}
	else if trueCaelestiWingsDebuffTimer >= 0 {
		trueCaelestiWingsDebuffTimer--;
		// The multiplier is equal to the base amount plus the multiplier bonus times the amount of
		// times the multiplier bonus has been applied.
		// Base Amount + (Multiplier Bonus * amount of times Multiplier Bonus has been applied)
		trueCaelestiWingsDebuffDamageMultiplier = trueCaelestiWingsBaseDebuffDamageMultiplier + (trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee * trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded);
	}
}
else {
	trueCaelestiWingsDebuffDamageMultiplier = 1;
	trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
}

// Wrath of the Repentant
if wrathOfTheRepentantDebuffTimer >= 0 {
	wrathOfTheRepentantActive = true;
}
if wrathOfTheRepentantActive {
	if wrathOfTheRepentantDebuffTimer < 0 {
		wrathOfTheRepentantActive = false;
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
	}
	else if wrathOfTheRepentantDebuffTimer >= 0 {
		if wrathOfTheRepentantDebuffTimer >= 0 {
			wrathOfTheRepentantDebuffTimer--;
			wrathOfTheRepentantMovementSpeedMultiplier = wrathOfTheRepentantBaseMovementSpeedMultiplier;
		}
	}
}
else {
	wrathOfTheRepentantMovementSpeedMultiplier = 1;
}

// Angelic Barrage
// This is set as true in the collision event with the hitbox; otherwise its set as false
if angelicBarrageActive {
	angelicBarrageDamageMultiplier = angelicBarrageBaseDamageMultiplier;
	if angelicBarrageTicTimer <= 0 {
		angelicBarrageTicTimer = angelicBarrageTicTimerStartTime;
		// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
	}
}
else {
	angelicBarrageDamageMultiplier = 1;
}
if angelicBarrageTicTimer > 0 {
	angelicBarrageTicTimer--;
}

// Holy Defense
if holyDefenseTimer >= 0 {
	holyDefenseActive = true;
}
if holyDefenseActive {
	if holyDefenseTimer < 0 {
		holyDefenseActive = false;
	}
	else if holyDefenseTimer >= 0 {
		holyDefenseTimer--;
		if holyDefenseTicTimer <= 0 {
			holyDefenseTicTimer = holyDefenseTicTimerStartTime;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			holyDefenseTicTimer--;
		}
	}
}

// Bindings of the Caelesti
if bindingsOfTheCaelestiTimer >= 0 {
	bindingsOfTheCaelestiActive = true;
}
if bindingsOfTheCaelestiActive {
	if bindingsOfTheCaelestiTimer < 0 {
		bindingsOfTheCaelestiActive = false;
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
	}
	else if bindingsOfTheCaelestiTimer >= 0 {
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
		bindingsOfTheCaelestiTimer--;
		if bindingsOfTheCaelestiTicTimer <= 0 {
			bindingsOfTheCaelestiTicTimer = bindingsOfTheCaelestiTicTimerStartTime;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			bindingsOfTheCaelestiTicTimer--;
		}
	}
}
else {
	bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
}

// Hidden Dagger Debuff
if hiddenDaggerDamageMultiplierTimer >= 0 {
	hiddenDaggerDamageMultiplierActive = true;
}
if hiddenDaggerDamageMultiplierActive {
	if hiddenDaggerDamageMultiplierTimer < 0 {
		hiddenDaggerDamageMultiplierActive = false;
		hiddenDaggerDamageMultiplier = 1;
	}
	else if hiddenDaggerDamageMultiplierTimer >= 0 {
		hiddenDaggerDamageMultiplier = hiddenDaggerBaseDamageMultiplier;
		hiddenDaggerDamageMultiplierTimer--;
	}
}
else {
	hiddenDaggerDamageMultiplier = 1;
}

// Glinting Blade
if glintingBladeTimer >= 0 {
	glintingBladeActive = true;
}
if glintingBladeActive {
	if glintingBladeTimer < 0 {
		glintingBladeActive = false;
		obj_skill_tree.glintingBladeActive = false;
		obj_skill_tree.glintingBladeAttachedToEnemy = noone;
		obj_skill_tree.glintingBladeXPos = 0;
		obj_skill_tree.glintingBladeYPos = 0;
	}
	else if glintingBladeTimer >= 0 {
		glintingBladeTimer--;
		obj_skill_tree.glintingBladeActive = true;
		obj_skill_tree.glintingBladeAttachedToEnemy = self;
		obj_skill_tree.glintingBladeXPos = x;
		obj_skill_tree.glintingBladeYPos = y;
	}
}
#endregion

#region Poisons
// Sickly Proposition
if sicklyPropositionTimer >= 0 {
	sicklyPropositionActive = true;
}
if sicklyPropositionActive = true {
	if sicklyPropositionTimer < 0 {
		sicklyPropositionActive = false;
	}
	else if sicklyPropositionTimer >= 0 {
		poisoned = true;
		sicklyPropositionTimer--;
		if sicklyPropositionTicTimer <= 0 {
			sicklyPropositionTicTimer = sicklyPropositionTicTimerStartTime;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			sicklyPropositionTicTimer--;
		}
	}
}

// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
if finalPartingTimer >= 0 {
	finalPartingActive = true;
}
if finalPartingActive {
	if finalPartingTimer < 0 {
		finalPartingActive = false;
	}
	else if finalPartingTimer >= 0 {
		poisoned = true;
		finalPartingTimer--;
		if finalPartingTicTimer <= 0 {
			finalPartingTicTimer = finalPartingTicTimerStartTime;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			finalPartingTicTimer--;
		}
	}
}
else {
	finalPartingNextTarget = noone;
}


// Dinner Is Served
if dinnerIsServedTimer >= 0 {
	dinnerIsServedActive = true;
}
if dinnerIsServedActive {
	if dinnerIsServedTimer < 0 {
		dinnerIsServedActive = false;
		// If Dinner Is Served is not poisoning the enemy, reset values to default of 1
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
	}
	else if dinnerIsServedTimer >= 0 {
		dinnerIsServedEnemyManaRegenerationMultiplier = dinnerIsServedBaseEnemyManaRegenerationMultiplier;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
		dinnerIsServedEnemyMovementSpeedMultiplier = dinnerIsServedBaseEnemyMovementSpeedMultiplier;
		poisoned = true;
		dinnerIsServedTimer--;
		if dinnerIsServedTicTimer <= 0 {
			dinnerIsServedTicTimer = dinnerIsServedTicTimerStartTime;
			dinnerIsServedStartingDamage = dinnerIsServedStartingDamage * dinnerIsServedRampMultiplier;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			dinnerIsServedTicTimer--;
		}
	}
}
else {
	// If Dinner Is Served is not poisoning the enemy, reset values to default of 1
	dinnerIsServedEnemyManaRegenerationMultiplier = 1;
	dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
	dinnerIsServedEnemyMovementSpeedMultiplier = 1;
}


// Exploit Weakness
if exploitWeaknessTimer >= 0 {
	exploitWeaknessActive = true;
}
if exploitWeaknessActive {
	if exploitWeaknessTimer < 0 {
		exploitWeaknessActive = false;
	}
	else if exploitWeaknessTimer >= 0 {
		poisoned = true;
		exploitWeaknessTimer--;
		if exploitWeaknessTicTimer <= 0 {
			exploitWeaknessTicTimer = exploitWeaknessTicTimerStartTime;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		else {
			exploitWeaknessTicTimer--;
		}
	}
}
#endregion

#region Stuns
// Hidden Dagger Poison and Stun
if hiddenDaggerTicTimer >= 0 {
	hiddenDaggerActive = true;
}
if hiddenDaggerActive {
	if hiddenDaggerTicTimer < 0 {
		stunTimer = obj_skill_tree.hiddenDaggerStunDuration;
		hiddenDaggerDamageMultiplierTimer = hiddenDaggerDamageMultiplierTimerStartTime;
		hiddenDaggerActive = false;
	}
	else if hiddenDaggerTicTimer >= 0 {
		poisoned = true;
		hiddenDaggerTicTimer--;
	}
}
#endregion


