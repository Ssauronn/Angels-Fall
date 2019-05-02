///@description Change and Manage Stats
// Total Speed for Enemy
if !obj_combat_controller.levelPaused && !obj_combat_controller.gamePaused {
	enemyTotalSpeed = (enemyGameSpeed + userInterfaceGameSpeed) / 2;
}
else {
	enemyTotalSpeed = 0;
}

// Base Stat Regenerations
enemyCurrentHP += enemyHPRegeneration * enemyTotalSpeed;
enemyCurrentStamina += enemyStaminaRegeneration * enemyTotalSpeed;
enemyCurrentMana += enemyManaRegeneration * enemyTotalSpeed;

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
enemyTotalBonusDamage = 1; // + whatever bonus damages the enemy has
enemyTotalBonusResistance = 0; // + whatever bonus resistances the enemy has


// Set Speed variables for enemies
maxSpeed = baseMaxSpeed * enemyTotalSpeed;
acceleration = baseAcceleration * enemyTotalSpeed;
frictionAmount = baseFrictionAmount * enemyTotalSpeed;


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


