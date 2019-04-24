/// @description Create Combat Controlling Variables
globalvar camera, userInterfaceGameSpeed, enemiesDealtDamage, animecroPool, animecroMultiplier, playerTotalBonusDamage, playerTotalBonusResistance;
// Variable used to control how fast the game progresses. If less than 1, all processes run slower, including but not limited to timers, animation speeds, movement speeds, etc.
levelPaused = false;
gamePaused = false;
userInterfaceGameSpeed = 1.000;

// Variables used to control the pool of Animecro gained by kills, and the multiplier associated with that
enemiesDealtDamage = 0;
animecroPool = 0;
animecroMultiplier = 1;

// Variables used to control what bullets should be moved where
playerHitboxList = noone;
enemyHitboxList = noone;

// Variables used to control the combo timer and count for the player
comboCounter = 0;
comboCounterTimer = -1;
comboCounterTimerStartTime = 4 * room_speed;

// Variables used to control the incoming and outgoing damage of both the player and other enemies
// Player
playerTotalBonusDamage = 1 + obj_skill_tree.primeBonusDamagePercentAsDecimal; // + whatever other modifiers I can change player damage with. Damage debuffs should be applied as negative numbers.
playerTotalBonusResistance = 0; // + whatever resistances the player has


