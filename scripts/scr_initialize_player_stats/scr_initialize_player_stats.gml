///@description Intialize Enemy Stats
#region Image Speed and Dashing Variables
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
#endregion

// Invincibility
invincibile = false;

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
playerHitbox = noone;
playerHitboxType = "";
playerHitboxValue = 0;
playerHitboxHeal = false;
playerHitboxDirection = 0;
playerProjectileHitboxSpeed = maxSpeed * 1.1;
hitboxCreated = false;
comboTrue = "";

// Basic attack damage values
playerMeleeAttackOneValue = 100;
playerMeleeAttackTwoValue = playerMeleeAttackOneValue;
playerMeleeAttackThreeValue = playerMeleeAttackOneValue;
playerMeleeAttackFourValue = playerMeleeAttackOneValue * 1.25;
playerMeleeAttackFiveValue = playerMeleeAttackOneValue * 1.5;

// Spell attack damage values
playerBulletAttackValue = 200;

// Player Total Damage Dealt, Player Total Damage Taken
/*
This variable is used in the collision event of obj_hitbox with obj_hurtbox. First, the value of the hitbox,
whether attacking or defending, is assigned to the correct value. Then, the value is added to by any additional
effects that are active (like bonus damage effects). Finally, the value is multiplied against the defender's
resistances and the attacker's bonuses, before that final value is applied against the HP value of the defender's
HP.
*/
playerTotalDamageDealt = 0;
playerTotalDamageTaken = 0;

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


