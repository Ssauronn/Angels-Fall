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
dashSuccessfullyCombod = false;

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
	wrathofthediaboli,
	glintingblade,
	glintingbladesingle,
	glintingbladeaoe,
	hellishlandscape,
	hiddendagger,
	alloutattack,
	exploitweakness,
	purifyingrage,
	rushdown,
	diabolusblast,
	truecaelestiwings,
	bindingsofthecaelesti,
	armorofthecaelesti,
	holydefense,
	wrathoftherepentant,
	theonepower,
	lightningspear,
	angelicbarrage,
	whirlwind,
	deathincarnate,
	ritualofimperfection,
	ritualofdeath,
	soultether,
	dinnerisserved,
	finalparting,
	riskoflife,
	takenforpain,
	sicklyproposition
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
#region Abilities
#region Diabolus Abilities
playerSprite[playerstates.wrathofthediaboli, playerdirection.right] = spr_ability_attack_right;
playerSprite[playerstates.wrathofthediaboli, playerdirection.up] = spr_ability_attack_up;
playerSprite[playerstates.wrathofthediaboli, playerdirection.left] = spr_ability_attack_left;
playerSprite[playerstates.wrathofthediaboli, playerdirection.down] = spr_ability_attack_down;
playerSprite[playerstates.hellishlandscape, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.hellishlandscape, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.hellishlandscape, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.hellishlandscape, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.glintingblade, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.glintingblade, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.glintingblade, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.glintingblade, playerdirection.down] = spr_fling_staff_down;
playerSprite[playerstates.glintingbladesingle, playerdirection.right] = spr_ability_attack_right;
playerSprite[playerstates.glintingbladesingle, playerdirection.up] = spr_ability_attack_up;
playerSprite[playerstates.glintingbladesingle, playerdirection.left] = spr_ability_attack_left;
playerSprite[playerstates.glintingbladesingle, playerdirection.down] = spr_ability_attack_down;
playerSprite[playerstates.glintingbladeaoe, playerdirection.right] = spr_ground_slam_staff_right;
playerSprite[playerstates.glintingbladeaoe, playerdirection.up] = spr_ground_slam_staff_up;
playerSprite[playerstates.glintingbladeaoe, playerdirection.left] = spr_ground_slam_staff_left;
playerSprite[playerstates.glintingbladeaoe, playerdirection.down] = spr_ground_slam_staff_down;
playerSprite[playerstates.hiddendagger, playerdirection.right] = spr_ability_attack_right;
playerSprite[playerstates.hiddendagger, playerdirection.up] = spr_ability_attack_up;
playerSprite[playerstates.hiddendagger, playerdirection.left] = spr_ability_attack_left;
playerSprite[playerstates.hiddendagger, playerdirection.down] = spr_ability_attack_down;
playerSprite[playerstates.alloutattack, playerdirection.right] = spr_ready_up_right;
playerSprite[playerstates.alloutattack, playerdirection.up] = spr_ready_up_up;
playerSprite[playerstates.alloutattack, playerdirection.left] = spr_ready_up_left;
playerSprite[playerstates.alloutattack, playerdirection.down] = spr_ready_up_down;
playerSprite[playerstates.exploitweakness, playerdirection.right] = spr_ability_attack_right;
playerSprite[playerstates.exploitweakness, playerdirection.up] = spr_ability_attack_up;
playerSprite[playerstates.exploitweakness, playerdirection.left] = spr_ability_attack_left;
playerSprite[playerstates.exploitweakness, playerdirection.down] = spr_ability_attack_down;
playerSprite[playerstates.purifyingrage, playerdirection.right] = spr_ready_up_right;
playerSprite[playerstates.purifyingrage, playerdirection.up] = spr_ready_up_up;
playerSprite[playerstates.purifyingrage, playerdirection.left] = spr_ready_up_left;
playerSprite[playerstates.purifyingrage, playerdirection.down] = spr_ready_up_down;
playerSprite[playerstates.rushdown, playerdirection.right] = spr_ability_attack_right;
playerSprite[playerstates.rushdown, playerdirection.up] = spr_ability_attack_up;
playerSprite[playerstates.rushdown, playerdirection.left] = spr_ability_attack_left;
playerSprite[playerstates.rushdown, playerdirection.down] = spr_ability_attack_down;
playerSprite[playerstates.diabolusblast, playerdirection.right] = spr_ground_slam_staff_right;
playerSprite[playerstates.diabolusblast, playerdirection.up] = spr_ground_slam_staff_up;
playerSprite[playerstates.diabolusblast, playerdirection.left] = spr_ground_slam_staff_left;
playerSprite[playerstates.diabolusblast, playerdirection.down] = spr_ground_slam_staff_down;
#endregion
#region Caelesti Abilities
playerSprite[playerstates.truecaelestiwings, playerdirection.right] = spr_ready_up_right;
playerSprite[playerstates.truecaelestiwings, playerdirection.up] = spr_ready_up_up;
playerSprite[playerstates.truecaelestiwings, playerdirection.left] = spr_ready_up_left;
playerSprite[playerstates.truecaelestiwings, playerdirection.down] = spr_ready_up_down;
playerSprite[playerstates.bindingsofthecaelesti, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.bindingsofthecaelesti, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.bindingsofthecaelesti, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.bindingsofthecaelesti, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.armorofthecaelesti, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.armorofthecaelesti, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.armorofthecaelesti, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.armorofthecaelesti, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.holydefense, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.holydefense, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.holydefense, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.holydefense, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.wrathoftherepentant, playerdirection.right] = spr_ready_up_right;
playerSprite[playerstates.wrathoftherepentant, playerdirection.up] = spr_ready_up_up;
playerSprite[playerstates.wrathoftherepentant, playerdirection.left] = spr_ready_up_left;
playerSprite[playerstates.wrathoftherepentant, playerdirection.down] = spr_ready_up_down;
playerSprite[playerstates.theonepower, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.theonepower, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.theonepower, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.theonepower, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.lightningspear, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.lightningspear, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.lightningspear, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.lightningspear, playerdirection.down] = spr_fling_staff_down;
playerSprite[playerstates.angelicbarrage, playerdirection.right] = spr_ground_slam_staff_right;
playerSprite[playerstates.angelicbarrage, playerdirection.up] = spr_ground_slam_staff_up;
playerSprite[playerstates.angelicbarrage, playerdirection.left] = spr_ground_slam_staff_left;
playerSprite[playerstates.angelicbarrage, playerdirection.down] = spr_ground_slam_staff_down;
playerSprite[playerstates.whirlwind, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.whirlwind, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.whirlwind, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.whirlwind, playerdirection.down] = spr_fling_staff_down;
#endregion
#region Necromancy Abilities
playerSprite[playerstates.deathincarnate, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.deathincarnate, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.deathincarnate, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.deathincarnate, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.ritualofimperfection, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.ritualofimperfection, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.ritualofimperfection, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.ritualofimperfection, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.ritualofdeath, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.ritualofdeath, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.ritualofdeath, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.ritualofdeath, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.soultether, playerdirection.right] = spr_ready_up_right;
playerSprite[playerstates.soultether, playerdirection.up] = spr_ready_up_up;
playerSprite[playerstates.soultether, playerdirection.left] = spr_ready_up_left;
playerSprite[playerstates.soultether, playerdirection.down] = spr_ready_up_down;
playerSprite[playerstates.dinnerisserved, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.dinnerisserved, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.dinnerisserved, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.dinnerisserved, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.finalparting, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.finalparting, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.finalparting, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.finalparting, playerdirection.down] = spr_fling_staff_down;
playerSprite[playerstates.riskoflife, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.riskoflife, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.riskoflife, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.riskoflife, playerdirection.down] = spr_fling_staff_down;
playerSprite[playerstates.takenforpain, playerdirection.right] = spr_power_up_right;
playerSprite[playerstates.takenforpain, playerdirection.up] = spr_power_up_up;
playerSprite[playerstates.takenforpain, playerdirection.left] = spr_power_up_left;
playerSprite[playerstates.takenforpain, playerdirection.down] = spr_power_up_down;
playerSprite[playerstates.sicklyproposition, playerdirection.right] = spr_fling_staff_right;
playerSprite[playerstates.sicklyproposition, playerdirection.up] = spr_fling_staff_up;
playerSprite[playerstates.sicklyproposition, playerdirection.left] = spr_fling_staff_left;
playerSprite[playerstates.sicklyproposition, playerdirection.down] = spr_fling_staff_down;
#endregion
#endregion
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
playerHitboxAttackType = "";
playerHitboxValue = 0;
playerHitboxHeal = false;
playerProjectileHitboxDirection = 0;
playerProjectileHitboxSpeed = maxSpeed * 1.1;
hitboxCreated = false;
comboTrue = "";
comboTrueTimer = -1;
comboPlayerDirectionFacing = -1;
comboAbilityButton = 0;

// Basic attack damage values
playerMeleeAttackOneValue = 50;
playerMeleeAttackTwoValue = playerMeleeAttackOneValue;
playerMeleeAttackThreeValue = playerMeleeAttackOneValue;
playerMeleeAttackFourValue = playerMeleeAttackOneValue * 1.25;
playerMeleeAttackFiveValue = playerMeleeAttackOneValue * 1.5;

// Spell attack damage values
playerBulletAttackValue = 100;

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


