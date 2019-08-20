///@description 
#region Player Total Speed
// Set composite speed of player object, with the game speed of the
// player and game speed of the user interface averaged out.
if !obj_combat_controller.levelPaused && !obj_combat_controller.gamePaused {
	playerTotalSpeed = (playerGameSpeed + userInterfaceGameSpeed) / 2;
}
else {
	playerTotalSpeed = 0;
}
#endregion


#region Player Movement Speed Variable tracking
// Set the max speed the player object can move at, depending on playerTotalSpeed
maxSpeed = baseMaxSpeed * playerTotalSpeed;
acceleration = baseAcceleration * playerTotalSpeed;
frictionAmount = baseFrictionAmount * playerTotalSpeed;
dashSpeed = baseDashSpeed * playerTotalSpeed;
#endregion


#region Player HP, Stamina, and Mana Tracking
// Used to regenerate resources
playerCurrentHP += playerHPRegeneration * playerTotalSpeed;
playerCurrentStamina += playerStaminaRegeneration * playerTotalSpeed;
playerCurrentMana += playerManaRegeneration * playerTotalSpeed;
// Used to control the resources of the player, make sure nothing goes above the max amounts
playerMaxHP = playerMaxAnimecroHP + playerMaxPermanentHP + playerMaxFluidHP;
if playerCurrentHP > playerMaxHP {
	playerCurrentHP = playerMaxHP;
}
if playerCurrentHP <= 0 {
	playerCurrentHP = 0;
	key_restart = true;
}
if playerCurrentAnimecroHP > playerMaxAnimecroHP {
	playerCurrentAnimecroHP = playerMaxAnimecroHP;
}
if playerCurrentPermanentHP > playerMaxPermanentHP {
	playerCurrentPermanentHP = playerMaxPermanentHP;
}
if playerCurrentFluidHP > playerMaxFluidHP {
	playerCurrentFluidHP = playerMaxFluidHP;
}
if playerCurrentStamina > playerMaxStamina {
	playerCurrentStamina = playerMaxStamina;
}
if playerCurrentMana > playerMaxMana {
	playerCurrentMana = playerMaxMana;
}
if playerCurrentBloodMagic > playerMaxBloodMagic {
	playerCurrentBloodMagic = playerMaxBloodMagic;
}
// Set each specific HP status equal to what the current HP is compared to the different max HP's
if playerCurrentHP >= (playerMaxAnimecroHP + playerMaxPermanentHP) {
	playerCurrentAnimecroHP = playerMaxAnimecroHP;
	playerCurrentPermanentHP = playerMaxPermanentHP;
	playerCurrentFluidHP = playerCurrentHP - (playerMaxAnimecroHP + playerMaxPermanentHP);
}
else if playerCurrentHP >= playerMaxAnimecroHP {
	playerCurrentAnimecroHP = playerMaxAnimecroHP;
	playerCurrentPermanentHP = playerCurrentHP - (playerCurrentAnimecroHP);
	playerCurrentFluidHP = 0;
}
else {
	playerCurrentAnimecroHP = playerCurrentHP;
	playerCurrentPermanentHP = 0;
	playerCurrentFluidHP = 0;
}
#endregion


#region Player Sprite Index Setting - only temporary, after items can be equipped, this will be changed
// Set sprite index
sprite_index = playerSprite[playerStateSprite, playerDirectionFacing];
#endregion


#region Change States and Change Sprite
switch (playerState) {
	case playerstates.idle: scr_player_idle();
		break;
	case playerstates.run: scr_player_run();
		break;
	case playerstates.dash: scr_player_dash();
		break;
	case playerstates.parryready: scr_player_parry_ready();
		break;
	case playerstates.parryeffect: scr_player_parry_effect();
		break;
	case playerstates.attack1: scr_player_attack1();
		break;
	case playerstates.attack2: scr_player_attack2();
		break;
	case playerstates.attack3: scr_player_attack3();
		break;
	case playerstates.attack4: scr_player_attack4();
		break;
	case playerstates.attack5: scr_player_attack5();
		break;
	#region Diabolus Abilities
	case playerstates.wrathofthediaboli: scr_player_wrath_of_the_diaboli();
		break;
	case playerstates.glintingblade: scr_player_glinting_blade();
		break;
	case playerstates.glintingbladesingle: scr_player_glinting_blade_single();
		break;
	case playerstates.glintingbladeaoe: scr_player_glinting_blade_aoe();
		break;
	case playerstates.hellishlandscape: scr_player_hellish_landscape();
		break;
	case playerstates.hiddendagger: scr_player_hidden_dagger();
		break;
	case playerstates.alloutattack: scr_player_all_out_attack();
		break;
	case playerstates.exploitweakness: scr_player_exploit_weakness();
		break;
	case playerstates.purifyingrage: scr_player_purifying_rage();
		break;
	case playerstates.rushdown: scr_player_rushdown();
		break;
	case playerstates.diabolusblast: scr_player_diabolus_blast();
		break;
	#endregion
	#region Caelesti Abilities
	case playerstates.truecaelestiwings: scr_player_true_caelesti_wings();
		break;
	case playerstates.bindingsofthecaelesti: scr_player_bindings_of_the_caelesti();
		break;
	case playerstates.armorofthecaelesti: scr_player_armor_of_the_caelesti();
		break;
	case playerstates.holydefense: scr_player_holy_defense();
		break;
	case playerstates.wrathoftherepentant: scr_player_wrath_of_the_repentant();
		break;
	case playerstates.theonepower: scr_player_the_one_power();
		break;
	case playerstates.lightningspear: scr_player_lightning_spear();
		break;
	case playerstates.angelicbarrage: scr_player_angelic_barrage();
		break;
	case playerstates.whirlwind: scr_player_whirlwind();
		break;
	#endregion
	#region Necromancy Abilities
	case playerstates.deathincarnate: scr_player_death_incarnate();
		break;
	case playerstates.ritualofimperfection: scr_player_ritual_of_imperfection();
		break;
	case playerstates.ritualofdeath: scr_player_ritual_of_death();
		break;
	case playerstates.soultether: scr_player_soul_tether();
		break;
	case playerstates.dinnerisserved: scr_player_dinner_is_served();
		break;
	case playerstates.finalparting: scr_player_final_parting();
		break;
	case playerstates.riskoflife: scr_player_risk_of_life();
		break;
	case playerstates.takenforpain: scr_player_taken_for_pain();
		break;
	case playerstates.sicklyproposition: scr_player_sickly_proposition();
		break;
	#endregion
}

if (playerState == playerstates.run) && (currentSpeed != 0) {
	switch longestMoveKeyPress {
		case rightMovementKeyTimer: playerDirectionFacing = 0;
				playerStateSprite = playerstates.run;
			break;
		case upMovementKeyTimer: playerDirectionFacing = 1;
				playerStateSprite = playerstates.run;
			break;
		case leftMovementKeyTimer: playerDirectionFacing = 2;
				playerStateSprite = playerstates.run;
			break;
		case downMovementKeyTimer: playerDirectionFacing = 3;
				playerStateSprite = playerstates.run;
			break;
	}
}
#endregion


#region Image Index Setting - only temporary, after items can be equipped, this will be changed
// Set the image index
if playerImageIndex >= sprite_get_number(playerSprite[playerStateSprite, playerDirectionFacing]) {
	playerImageIndex = -1;
}
if playerAnimationImageIndex >= sprite_get_number(playerAnimationSprite) {
	playerAnimationImageIndex = -1;
	playerAnimationSprite = noone;
}
playerImageIndexSpeed = 0.3 * playerTotalSpeed;
playerImageIndex += playerImageIndexSpeed;
playerAnimationImageIndex += playerImageIndexSpeed;
// This line below is only used for debugging/prototyping/testing purposes.
// In the future, this line will be removed, and a series of lines of code in the draw event 
// (not draw gui) as seen immediately below will be used to draw the player with their armor on, using 
// playerImageIndex to set sprite_index for each drawn item.
//
// draw_sprite_ext(playerHeadSprite[playerStateSprite, playerDirectionFacing], playerImageIndex, x, y, 1, 1, 0, c_white, 1);
//
// The line above is an example of using a sprite table for each different armor type to draw the armor
// that the player has equipped.
image_index = playerImageIndex;
#endregion


#region Various Timer Tracking, and Variable Countdowns
// Dashing timer
if dashTimer >= 0 {
	if playerTotalSpeed != 0 {
		dashTimer -= 1 * (1 / playerTotalSpeed);
	}
}
#endregion


#region Setting Hurtbox Locations
if instance_exists(self) {
	if instance_exists(playerHurtbox) {
		playerHurtbox.x = x;
		playerHurtbox.y = y;
		playerHurtbox.sprite_index = playerSprite[playerStateSprite, playerDirectionFacing];
		playerHurtbox.image_index = playerSprite[playerStateSprite, playerDirectionFacing];
		playerHurtbox.mask_index = playerSprite[playerStateSprite, playerDirectionFacing];
	}
	if instance_exists(playerGroundHurtbox) {
		playerGroundHurtbox.x = x;
		playerGroundHurtbox.y = y + 13;
	}
}
#endregion


