/// @description Create Variables
// Set all global player variables
globalvar playerGameSpeed, playerTotalSpeed, playerMaxHP, playerMaxPermanentHP, playerCurrentPermanentHP, playerMaxAnimecroHP, playerCurrentAnimecroHP, playerMaxFluidHP, playerCurrentFluidHP, playerCurrentHP, playerHPRegeneration, playerMaxStamina, playerCurrentStamina, playerStaminaRegeneration, playerMaxMana, playerCurrentMana, playerManaRegeneration;


// Variables used to control the universal speed of the player
// The variable used to control the player specifically
playerGameSpeed = 1.000;
// The variable that is the average of playerGameSpeed and userInterfaceGameSpeed
playerTotalSpeed = 1.000;

// Variables used to control health resources for player
playerMaxPermanentHP = 1000;
playerCurrentPermanentHP = playerMaxPermanentHP;
playerMaxAnimecroHP = 0;
playerCurrentAnimecroHP = playerMaxAnimecroHP;
playerMaxFluidHP = 0;
playerCurrentFluidHP = playerMaxFluidHP;
playerMaxHP = playerMaxPermanentHP + playerMaxAnimecroHP + playerCurrentFluidHP;
playerCurrentHP = playerMaxHP;
playerHPRegeneration = 0 / room_speed;
// Variables used to control stamina resources for player
playerMaxStamina = 1000;
playerCurrentStamina = playerMaxStamina;
playerStaminaRegeneration = 50 / room_speed;
// Variables used to control mana resources for player
playerMaxMana = 1000;
playerCurrentMana = playerMaxMana;
playerManaRegeneration = 50 / room_speed;
// Costs on resources for using various attacks
// Melee costs and regen
meleeStaminaCost = 100;
meleeManaRegen = 75;
// Magic costs and regen
magicStaminaRegen = 600;
magicManaCost = 800;
// Dash costs and regen
dashStaminaCost = 150;
dashManaRegen = 75;

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
initialize_movement_entity(max_speed_, current_speed_, player_acceleration_, current_direction_, friction_, bounce_percent_, collision_object_, obj_ground_hurtbox);


// Image speed and dashing variables
playerRecentlyDashed = false;
xDashPosition = mouse_x;
yDashPosition = mouse_y;
dashTime = 10 * (1 / userInterfaceGameSpeed);
dashTimer = 0;
baseDashSpeed = maxSpeed * 2;
dashSpeed = baseDashSpeed;
dashDir = point_direction(obj_player.x, obj_player.y, xDashPosition, yDashPosition);

// Image Speed Initialization
image_speed = 0;

// Invincibility
invincibile = false;

// Last movement key pressed
longestMoveKeyPress = -1;
rightMovementKeyTimer = 0;
upMovementKeyTimer = 0;
leftMovementKeyTimer = 0;
downMovementKeyTimer = 0;

// Depth
depth = -y;

enum playerstates {
	idle,
	run,
	dash,
	parryready,
	parryeffect,
	attack1,
	attack2,
	attack3,
	attack4,
	attack5,
	attack6,
	skillshotmagic,
	mousetargetaoemagic,
	selftargetaoemagic,
	selftargetmagic,
	autotargetmagic
}
enum playerdirection {
	right,
	up,
	left,
	down
}

playerState = playerstates.idle;

#region Player Sprite Table
playerSprite[playerstates.run, playerdirection.right] = spr_player_run_right;
playerSprite[playerstates.run, playerdirection.up] = spr_player_run_up;
playerSprite[playerstates.run, playerdirection.left] = spr_player_run_left;
playerSprite[playerstates.run , playerdirection.down] = spr_player_run_down;
playerSprite[playerstates.idle, playerdirection.right] = spr_player_idle_right;
playerSprite[playerstates.idle, playerdirection.up] = spr_player_idle_up;
playerSprite[playerstates.idle, playerdirection.left] = spr_player_idle_left;
playerSprite[playerstates.idle, playerdirection.down] = spr_player_idle_down;
playerSprite[playerstates.dash, playerdirection.right] = spr_player_dash_right;
playerSprite[playerstates.dash, playerdirection.up] = spr_player_dash_up;
playerSprite[playerstates.dash, playerdirection.left] = spr_player_dash_left;
playerSprite[playerstates.dash, playerdirection.down] = spr_player_dash_down;
playerSprite[playerstates.parryready, playerdirection.right] = spr_player_parry_ready_right;
playerSprite[playerstates.parryready, playerdirection.up] = spr_player_parry_ready_up;
playerSprite[playerstates.parryready, playerdirection.left] = spr_player_parry_ready_left;
playerSprite[playerstates.parryready, playerdirection.down] = spr_player_parry_ready_down;
playerSprite[playerstates.parryeffect, playerdirection.right] = spr_player_parry_effect_right;
playerSprite[playerstates.parryeffect, playerdirection.up] = spr_player_parry_effect_up;
playerSprite[playerstates.parryeffect, playerdirection.left] = spr_player_parry_effect_left;
playerSprite[playerstates.parryeffect, playerdirection.down] = spr_player_parry_effect_down;
playerSprite[playerstates.attack1, playerdirection.right] = spr_player_attack_right_1;
playerSprite[playerstates.attack1, playerdirection.up] = spr_player_attack_up_1;
playerSprite[playerstates.attack1, playerdirection.left] = spr_player_attack_left_1;
playerSprite[playerstates.attack1, playerdirection.down] = spr_player_attack_down_1;
playerSprite[playerstates.attack2, playerdirection.right] = spr_player_attack_right_2;
playerSprite[playerstates.attack2, playerdirection.up] = spr_player_attack_up_2;
playerSprite[playerstates.attack2, playerdirection.left] = spr_player_attack_left_2;
playerSprite[playerstates.attack2, playerdirection.down] = spr_player_attack_down_2;
playerSprite[playerstates.attack3, playerdirection.right] = spr_player_attack_right_3;
playerSprite[playerstates.attack3, playerdirection.up] = spr_player_attack_up_3;
playerSprite[playerstates.attack3, playerdirection.left] = spr_player_attack_left_3;
playerSprite[playerstates.attack3, playerdirection.down] = spr_player_attack_down_3;
playerSprite[playerstates.attack4, playerdirection.right] = spr_player_attack_right_4;
playerSprite[playerstates.attack4, playerdirection.up] = spr_player_attack_up_4;
playerSprite[playerstates.attack4, playerdirection.left] = spr_player_attack_left_4;
playerSprite[playerstates.attack4, playerdirection.down] = spr_player_attack_down_4;
playerSprite[playerstates.attack5, playerdirection.right] = spr_player_attack_right_5;
playerSprite[playerstates.attack5, playerdirection.up] = spr_player_attack_up_5;
playerSprite[playerstates.attack5, playerdirection.left] = spr_player_attack_left_5;
playerSprite[playerstates.attack5, playerdirection.down] = spr_player_attack_down_5;
playerSprite[playerstates.attack6, playerdirection.right] = spr_player_attack_right_6;
playerSprite[playerstates.attack6, playerdirection.up] = spr_player_attack_up_6;
playerSprite[playerstates.attack6, playerdirection.left] = spr_player_attack_left_6;
playerSprite[playerstates.attack6, playerdirection.down] = spr_player_attack_down_6;
playerSprite[playerstates.skillshotmagic, playerdirection.right] = spr_player_skillshot_magic_right;
playerSprite[playerstates.skillshotmagic, playerdirection.up] = spr_player_skillshot_magic_up;
playerSprite[playerstates.skillshotmagic, playerdirection.left] = spr_player_skillshot_magic_left;
playerSprite[playerstates.skillshotmagic, playerdirection.down] = spr_player_skillshot_magic_down;
#endregion

playerDirectionFacing = playerdirection.right; // Variable used in each playerState to control the first variable of the array playerSprite
playerStateSprite = playerstates.idle; // Variable used in each playerState to control the second variable of the array playerSprite
playerImageIndex = 0.00;
playerImageIndexSpeed = 0.3 * playerTotalSpeed;
playerAnimationImageIndex = 0.00;
playerAnimationSprite = noone;
playerAnimationX = 0;
playerAnimationY = 0;

// Attacking variables
lastAttackButtonPressed = "";

// Player Hitbox Variables
playerMeleeHitbox = noone;
playerBulletHitbox = noone;
playerBulletHitboxDirection = 0;
playerBulletHitboxSpeed = maxSpeed * 1.1;
hitboxCreated = false;
comboTrue = "";

// Player Hurtbox Variables
playerHurtbox = instance_create_depth(x, y, -999, obj_hurtbox);
playerHurtbox.sprite_index = playerSprite[playerStateSprite, playerDirectionFacing];
playerHurtbox.image_index = playerImageIndex;
playerHurtbox.visible = false;
playerHurtbox.owner = self;

playerGroundHurtbox = instance_create_depth(x, y + 13, -999, obj_ground_hurtbox);
playerGroundHurtbox.sprite_index = spr_ground_hurtbox;
playerGroundHurtbox.mask_index = spr_ground_hurtbox;
playerGroundHurtbox.image_index = 0;
playerGroundHurtbox.visible = false;
playerGroundHurtbox.owner = self;


