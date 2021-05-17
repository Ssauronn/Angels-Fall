/// @description Create Variables
#region Base Stats, Base Attack Costs
// Set all global player variables
globalvar playerGameSpeed, playerTotalSpeed, playerMaxHP, playerMaxPermanentHP, playerCurrentPermanentHP, playerMaxAnimecroHP, playerCurrentAnimecroHP, playerMaxFluidHP, playerCurrentFluidHP, playerCurrentHP, playerHPRegeneration, playerMaxStamina, playerCurrentStamina, playerStaminaRegeneration, playerMaxBloodMagic, playerCurrentBloodMagic;


// Variables used to control the universal speed of the player
// The variable used to control the player specifically
playerGameSpeed = 1.000;
// The variable that is the average of playerGameSpeed and userInterfaceGameSpeed
playerTotalSpeed = 1.000;

// Variables used to control health resources for player
playerMaxPermanentHP = 1000;
playerCurrentPermanentHP = playerMaxPermanentHP;
playerMaxAnimecroHP = 1000;
playerCurrentAnimecroHP = playerMaxAnimecroHP;
playerMaxFluidHP = 0;
playerCurrentFluidHP = playerMaxFluidHP;
playerMaxHP = playerMaxPermanentHP + playerMaxAnimecroHP + playerCurrentFluidHP;
playerCurrentHP = playerMaxHP;
playerHPRegeneration = 0 / room_speed;
// Variables used to control stamina resources for player
playerMaxStamina = 1000;
playerCurrentStamina = playerMaxStamina;
playerStaminaRegeneration = 12 / room_speed;
// Variables used to control blood magic resources for player
playerMaxBloodMagic = 10;
playerCurrentBloodMagic = playerMaxBloodMagic;
// Costs on resources for using various attacks
// Melee costs and regen
meleeStaminaRegen = 25;
// Dash costs and regen
dashStaminaCost = 100;
dashAvoidedDamage = false;
#endregion

// Movement Variables and Scripts (Setting up groundwork for movement engine)
scr_player_input();
var max_speed_ = 4.000;
var current_speed_ = 0.000;
var player_acceleration_ = 1.000;
xinput = 0;
yinput = 0;
var current_direction_ = point_direction(0, 0, 0, 0); // set to 0, 0, 0, 0
var friction_ = max_speed_ * 2.700;
var bounce_percent_ = 0.666;
var collision_object_ = obj_wall;
initialize_movement_entity(max_speed_, current_speed_, player_acceleration_, current_direction_, friction_, bounce_percent_, collision_object_, obj_ground_hurtbox, obj_chasm);

scr_initialize_player_stats();


