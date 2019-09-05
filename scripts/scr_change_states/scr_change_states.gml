///@argument0 EnemyName
/*
I run this state machine switch statement every frame in the Step event. I do this in a script
so that I can dynamically call the correct scripts each frame depending on what the enemy is.
Impossible to do otherwise (cannot store scripts in variables, already tried).
*/
var enemy_name_ = argument0;
switch (enemy_name_) {
	case "Mage":
		switch (enemyState) {
			case enemystates.idle: scr_enemy_idle();
				break;
			case enemystates.stunned: scr_stunned();
				break;
			case enemystates.moveWithinAttackRange: scr_move_within_attack_range();
				break;
			case enemystates.lightMeleeAttack: scr_mage_light_melee();
				break;
			case enemystates.heavyMeleeAttack: scr_mage_heavy_melee();
				break;
			case enemystates.lightRangedAttack: scr_mage_light_ranged();
				break;
			case enemystates.heavyRangedAttack: scr_mage_heavy_ranged();
				break;
		}
		break;
	case "Healer":
		switch (enemyState) {
			case enemystates.idle: scr_enemy_idle();
				break;
			case enemystates.stunned: scr_stunned();
				break;
			case enemystates.moveWithinAttackRange: scr_move_within_attack_range();
				break;
			case enemystates.lightMeleeAttack: scr_healer_light_melee();
				break;
			case enemystates.heavyMeleeAttack: scr_healer_heavy_melee();
				break;
			case enemystates.lightRangedAttack: scr_healer_light_ranged();
				break;
			case enemystates.heavyRangedAttack: scr_healer_heavy_ranged();
				break;
			case enemystates.healAlly: scr_healer_heal_ally();
				break;
		}
		break;
	case "Tank":
		switch (enemyState) {
			case enemystates.idle: scr_enemy_idle();
				break;
			case enemystates.stunned: scr_stunned();
				break;
			case enemystates.moveWithinAttackRange: scr_move_within_attack_range();
				break;
			case enemystates.lightMeleeAttack: scr_tank_light_melee();
				break;
			case enemystates.heavyMeleeAttack: scr_tank_heavy_melee();
				break;
			case enemystates.lightRangedAttack: scr_tank_light_ranged();
				break;
			case enemystates.heavyRangedAttack: scr_tank_heavy_ranged();
				break;
		}
		break;
	case "Fighter":
		switch (enemyState) {
			case enemystates.idle: scr_enemy_idle();
				break;
			case enemystates.stunned: scr_stunned();
				break;
			case enemystates.moveWithinAttackRange: scr_move_within_attack_range();
				break;
			case enemystates.lightMeleeAttack: scr_fighter_light_melee();
				break;
			case enemystates.heavyMeleeAttack: scr_fighter_heavy_melee();
				break;
			case enemystates.lightRangedAttack: scr_fighter_light_ranged();
				break;
			case enemystates.heavyRangedAttack: scr_fighter_heavy_ranged();
				break;
		}
		break;
}


