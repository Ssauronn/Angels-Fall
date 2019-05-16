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


#region Blood Magic
#region Tier 1 Abilities
// Set to 1, because subtracting 1 from the original value of enemyGameSpeed (1) will give us 0, 
// and taking the average of this and the userInterfaceGameSpeed will reduce enemy total speed 
// down to 0.5
crawlOfTormentPower = 1;
crawlOfTormentTimer = -1;
crawlOfTormentTimerStartTime = room_speed * 4;
// Set to true at beginning of ability, when timer reaches 0 this is set to false again and the
// number 1 is added to this to revert the effects of crawlOfTorment
crawlOfTormentReverted = false;
#endregion

#region Tier 2 Abilities

#endregion
#endregion


