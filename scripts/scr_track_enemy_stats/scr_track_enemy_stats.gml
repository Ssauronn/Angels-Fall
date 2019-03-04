///@description Change and Manage Stats
// Base Stat Regenerations
enemyCurrentHP += enemyHPRegeneration;
enemyCurrentStamina += enemyStaminaRegeneration;
enemyCurrentMana += enemyManaRegeneration;

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
enemyTotalSpeed = (enemyGameSpeed + userInterfaceGameSpeed) / 2;
maxSpeed = baseMaxSpeed * enemyTotalSpeed;
acceleration = baseAcceleration * enemyTotalSpeed;
frictionAmount = baseFrictionAmount * enemyTotalSpeed;


// Destroy self if HP drops below 0
if enemyCurrentHP <= 0 {
	animecroPool += 150;
	instance_destroy(self);
}


