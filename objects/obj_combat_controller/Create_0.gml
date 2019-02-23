/// @description Create Combat Controlling Variables
globalvar camera, userInterfaceGameSpeed, enemiesDealtDamage, animecroPool, animecroMultiplier, playerTotalBonusDamage, playerTotalBonusResistance;
// Variable used to control how fast the game progresses. If less than 1, all processes run slower, including but not limited to timers, animation speeds, movement speeds, etc.
userInterfaceGameSpeed = 1.000;

// Variable used to hold the ID of the camera I create to view the room
camera = camera_create_view(0, 0, 20480, 15360, 0, obj_player, -1, -1, 10240, 7680);

// Variables used to control the pool of Animecro gained by kills, and the multiplier associated with that
enemiesDealtDamage = 0;
animecroPool = 0;
animecroMultiplier = 1;

// Variable used to control what bullets should be moved where
enemyBulletHitboxList = noone;

// Variables used to control the combo timer and count for the player
comboCounter = 0;
comboCounterTimer = -1;
comboCounterTimerStartTime = 4 * room_speed;

// Variables used to control the incoming and outgoing damage of both the player and other enemies
// Player
playerTotalBonusDamage = 1 + obj_skill_tree.primeBonusDamagePercentAsDecimal; // + whatever other modifiers I can change player damage with. Damage debuffs should be applied as negative numbers.
playerTotalBonusResistance = 0; // + whatever resistances the player has


