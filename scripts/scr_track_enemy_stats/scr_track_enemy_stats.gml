///@description Change and Manage Stats
// Total Speed for Enemy
if !obj_combat_controller.levelPaused && !obj_combat_controller.gamePaused {
	enemyTotalSpeed = (enemyGameSpeed + userInterfaceGameSpeed) / 2;
}
else {
	enemyTotalSpeed = 0;
}

// Base Stat Regenerations
if enemyHPRegeneration != 0 {
	enemyCurrentHP += (enemyHPRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;
}
if enemyStaminaRegeneration != 0 {
	enemyCurrentStamina += (enemyStaminaRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;
}
if enemyManaRegeneration != 0 {
	enemyCurrentMana += (enemyManaRegeneration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;
}

// Make sure current stat values do not exceed max stat values
if enemyCurrentHP > enemyMaxHP {
	enemyCurrentHP = enemyMaxHP;
}
if enemyCurrentStamina > enemyMaxStamina {
	enemyCurrentStamina = enemyMaxStamina;
}
if enemyCurrentMana > enemyMaxMana {
	enemyCurrentMana = enemyMaxMana;
}

// Enemies' Bonus Damage and Resistance - 
enemyTotalBonusDamage = 1; // * whatever bonus damages the enemy has
enemyTotalBonusResistance = 1; // * whatever bonus resistances the enemy has


// Set Speed variables for enemies
maxSpeed = (baseMaxSpeed * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;
acceleration = (baseAcceleration * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;
frictionAmount = (baseFrictionAmount * enemyTotalSpeed) * stunMultiplier * hitstunMultiplier;


// Destroy self if HP drops below 0
if enemyCurrentHP <= 0 {
	animecroPool += 300;
	instance_destroy(self);
}

if enemyTimeUntilNextStaminaAbilityUsableTimer > 0 {
	enemyTimeUntilNextStaminaAbilityUsableTimer -= 1;
}

if enemyTimeUntilNextManaAbilityUsableTimer > 0 {
	enemyTimeUntilNextManaAbilityUsableTimer -= 1;
}


