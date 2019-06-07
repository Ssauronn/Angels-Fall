/// @description Create Combat Controlling Variables
globalvar camera, userInterfaceGameSpeed, enemyHitByPlayer, comboDamageDealt, animecroPool, bloodMagicPool, animecroMultiplier, playerTotalBonusDamage, playerTotalBonusBasicMeleeDamage, playerTotalBonusResistance;
// Variable used to control how fast the game progresses. If less than 1, all processes run slower, including but not limited to timers, animation speeds, movement speeds, etc.
levelPaused = false;
gamePaused = false;
userInterfaceGameSpeed = 1.000;

// Variables used to control the pool of Animecro gained by kills, and the multiplier associated with that
enemyHitByPlayer = false;
comboDamageDealt = 0;
animecroPool = 0;
animecroMultiplier = 1;
bloodMagicPool = 0;

// Variables used to control what bullets should be moved where
playerHitboxList = noone;
enemyHitboxList = noone;

// Variables used to control the combo timer and count for the player
comboCounter = 0;
comboCounterTimer = -1;
comboCounterTimerStartTime = 4 * room_speed;

// Variables used to control the incoming and outgoing damage of both the player and other enemies
// Player Bonus Damage, Bonus Basic Melee Damage, and Bonus Resistance
playerTotalBonusDamage = 1 * obj_skill_tree.allIsGivenMultiplier * obj_skill_tree.forTheGreaterGoodDamageMultiplier; // * whatever other modifiers I can change player damage with, numbers greater than 1.
playerTotalBonusBasicMeleeDamage = playerTotalBonusDamage; // * whatever other modifiers I can change the player basic melee damage with, numbers greater than 1.
playerTotalBonusResistance = 1 * obj_skill_tree.lifeTaxBonusDamageResistanceMultiplier; // * whatever other modifiers I can change the player resistance with, numbers greater than 0 and less than 1.



