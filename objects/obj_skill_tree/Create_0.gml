/// @description Create Skill Tree Variables
#region Prime Abilities
// Variable used to set which Prime ability will be used ("Q" ability)
primeAbilityChosen = "Bonus Damage Toggled";

// Variables used for a specific prime ability, both a toggled and timed slow time ability
slowTimeActive = false;
slowTimeActiveTimer = -1;
slowTimeActiveTimerStartTime = 3 * room_speed;

// Variables used for a specific prime ability, a toggled bonus damage ability
primeDamageActive = false;
primeBonusDamagePercentAsDecimal = 0;
#endregion


#region Parry Ability and Effects
// ---PARRY ABILITY---
// Variable used to set which Parry ability will be used ("F" ability)
parryEffectChosen = "Slow Time Effect";

// Variables used to set the parry timer, and the time slow timer
slowEnemyTimeWithParryActive = false;
slowEnemyTimeWithParryTimer = -1;
slowEnemyTimeWithParryTimerStartTime = 2 * room_speed;
parryWindowActive = false;
parryWindowTimer = -1;
parryWindowTimerStartTime = 0.5 * room_speed;
successfulParryEffectNeedsToBeAppliedToEnemy = false;
successfulParryInvulnerabilityActive = false;
successfulParryInvulnerabilityTimer = -1;
successfulParryInvulnerabilityTimerStartTime = 0.5 * room_speed;
#endregion


#region Tier 5 Spells and Abilities

#region Standard Bullet (Mana)
// Create first tier 5 ability here
#endregion
#endregion


