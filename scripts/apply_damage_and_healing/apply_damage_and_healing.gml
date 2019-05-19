///@description Apply Damages and Healing Correctly using Attacker and Defender stats
///@argument0 AttackerID
///@argument1 DefenderID
///@argument2 DamageTypeIsMelee?

#region Set Up Variables Used to Control Damages
var applicable_player_damage_bonus_, total_damage_;
var owner_, owner_is_enemy_, owner_is_minion_, owner_is_player_, owner_is_self_;
var other_owner_, other_owner_is_enemy, other_owner_is_minion_, other_owner_is_player_;
owner_is_enemy_ = false;
owner_is_minion_ = false;
owner_is_player_ = false;
owner_is_self_ = false;
owner_ = argument0;
other_owner_is_player_ = false;
other_owner_is_enemy = false;
other_owner_is_minion_ = false;
other_owner_ = argument1;


// Set the local variable applicable_player_damage_bonus_ equal to the damage bonus that the
// hitbox type is, which will be used later to automatically determine what damage value should
// be applied to the enemy.
if !argument2 {
	applicable_player_damage_bonus_ = playerTotalBonusDamage;
}
else if argument2 {
	applicable_player_damage_bonus_ = playerTotalBonusBasicMeleeDamage;
}

// Set all local variables that make it easier to determine and set values in this script based
// on what the attacker is, and the defender.
if other_owner_ == owner_ {
	owner_is_self_ = true;
}
if instance_exists(obj_player) {
	if owner_ == obj_player.id {
		owner_is_player_ = true;
	}
}
if !owner_is_player_ {
	if owner_.combatFriendlyStatus == "Enemy" {
		owner_is_enemy_ = true;
	}
	else if owner_.combatFriendlyStatus == "Minion" {
		owner_is_minion_ = true;
	}
}
if other_owner_ != obj_player.id {
	if other_owner_.combatFriendlyStatus == "Enemy" {
		other_owner_is_enemy = true;
	}
	else if other_owner_.combatFriendlyStatus == "Minion" {
		other_owner_is_minion_ = true;
	}
}
else {
	other_owner_is_player_ = true;
}

// Set the local variable used to add to the total damage the hitbox will do to the enemy later on
// in this script. First I'll add any bonus damages like what is provided by Lightning Spear. Then
// I'll multiply bonus damages provided by the attacker TotalBonusDamage, and finally I'll find
// the final value by multiplying the current value against the defender TotalBonusResistance.
if owner_is_player_ {
	total_damage_ = playerHitboxValue;
}
else if (owner_is_enemy_) || (owner_is_minion_) {
	total_damage_ = enemyHitboxValue;
}
#endregion


// Apply damages here, taking into account total resistances and bonus damages of defender and
// attacker, and whether the damage being dealt is basic melee or not.
#region Player Damaging Enemies
if owner_is_player_ {
	if other_owner_is_enemy {
		
	}
}
#endregion
#region Enemies Damaging Player

#endregion
#region Enemies Damaging Minions and Vice Versa

#endregion


