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
/// Crawl of Torment
crawlOfTormentHPCost = 0.4; // Cost is given as a multiplier of how much HP will be sacrificed
crawlOfTormentActive = false;
crawlOfTormentRange = 32 * 8;
// Set to 1, because subtracting 1 from the original value of enemyGameSpeed (1) will give us 0, 
// and taking the average of this and the userInterfaceGameSpeed will reduce enemy total speed 
// down to 0.5
crawlOfTormentPower = 1;
crawlOfTormentTimer = -1;
crawlOfTormentTimerStartTime = room_speed * 4;
// Set to true at beginning of ability, when timer reaches 0 this is set to false again and the
// number 1 is added to this to revert the effects of crawlOfTorment
crawlOfTormentReverted = false;

/// Dilge Furend
dilgeFurendHPCost = 0;
#endregion

#region Tier 2 Abilities
/// Overwhelming Chains
overWhelmingChainsHPCost = 0.3; // Cost is given as a multiplier of how much HP will be sacrificed
overwhelmingChainsActive = false;
overwhelmingChainsRange = 32 * 8;
overwhelmingChainsEffectedTarget = noone;
overwhelmingChainsDamageMultiplier = 1.5;
overwhelmingChainsDamageResistanceMultiplier = 1.5;

/// All is Given
allIsGivenActive = false;
allIsGivenMultiplier = 1;
allIsGivenTimer = -1;
allIsGivenTimerStartTime = room_speed * 5;
#endregion

#region Tier 3 Abilities
/// Forces of Life
forcesOfLifeHPCostPerSecond = 0.08 / room_speed;
forcesOfLifeActive = false;
forcesOfLifeMultiplier = 1;

/// Blood Pact
bloodPactHPCost = 0.4; // Cost is given as a multiplier of how much HP will be sacrificed
bloodPactStaminaReturn = 0.5; // Return is given as a multiplier of percent of max stam restored
bloodPactManaReturn = 0.5; // Return is given as a multiplier of percent of max stam restored

/// Life Tax
lifeTaxHPCost = 0.2;
lifeTaxActive = false;
lifeTaxRange = 32 * 6;
// Set to 1 instead of 0 because player is automatically effected, meaning it last at least for as
// long as the base timer amount each cast.
lifeTaxNumberOfObjectsEffected = 1;
lifeTaxTimer = -1;
lifeTaxTimerStartTime = room_speed * 3;

/// Blood for Blood
// This cost is the only ability that has a permanent HP cost. This ability is for those who have
// too much HP to use and want to spend it somewhere.
bloodForBloodHPPermanentCost = 0.5;
bloodForBloodHPSacrificed = 0;
bloodForBloodDamageMultiplier = 2;
bloodForBloodTarget = noone;
#endregion

#region Tier 4 Abilities
/// For the Greater Good
forTheGreaterGoodHPCost = 0.3; // Cost is given as a multiplier of how much HP will be sacrificed
forTheGreaterGoodActive = false;
forTheGreaterGoodDamageMultiplier = 2;
forTheGreaterGoodAttacksEffected = 0;
forTheGreaterGoodMaxAttacksToEffect = 3;
forTheGreaterGoodTimer = -1;
forTheGreaterGoodTimerStartTime = room_speed * 10;

/// Solidify
solidifyHPCost = 0.1; // Cost is given as a multiplier of how much HP will be sacrificed
solidifyActive = false;
solidifyRange = 32 * 6;
solidifyTarget = noone;
solidifyTimer = -1;
solidifyTimerStartTime = room_speed * 4;
#endregion
#endregion

/*
The following sections are for non-HP schools of magic. The cost of the ability is based on tiers,
as well as the regen of each ability. Each tier costs and regens from a base amount, determined
by the tier its in.

Tier 1 Abilities:
Cost: 3/3 of base 0.9 resource cost
Regen: 0/3 of base 0.6 resource regen

Tier 2 Abilities:
Cost: 2/3 of base 0.9 resource cost
Regen: 1/3 of base 0.6 resource regen

Tier 3 Abilities:
Cost: 1/3 of base 0.9 resource cost
Regen: 2/3 of base 0.6 resource regen

Tier 4 Abilities:
Cost: 0/3 of base 0.9 resource cost
Regen: 3/3 of base 0.6 resource regen

So, just a few examples: a Tier 1 stamina ability will cost 0.9 of total stamina, and regen no
mana. A Tier 3 mana ability will cost 0.3 of total mana, and regen 0.4 stamina. And a Tier 4 mana
ability will cost no mana, and regen 0.6 stamina.
*/

#region Necromancy Magic
#region Tier 1
/// Death Incarnate
deathIncarnateManaCost = 0.9;
deathIncarnateStaminaCost = 0;
deathIncarnateManaRegen = 0;
deathIncarnateStaminaRegen = 0;
deathIncarnateFirstPhaseActive = false;
deathIncarnateFirstPhaseDamage = 15;
deathIncarnateFirstPhaseMovementSpeed = 16 / room_speed;
deathIncarnateTicTimer = -1;
deathIncarnateTicTimerStartTime = room_speed * 0.5;
deathIncarnateSecondPhaseActive = false;
deathIncarnateSecondPhaseTargetArray = noone;
deathIncarnateSecondPhaseDamage = 400;
deathIncarnateSecondPhaseSubsequentDamageMultiplier = 0.8;
deathIncarnateSecondPhaseMovementSpeed = (32 * 8) / room_speed;
deathIncarnateTimer = -1;
deathIncarnateTimerStartTime = room_speed * 8;
#endregion

#region Tier 2
/// Ritual of Imperfection
// First Demon Costs and Regens
ritualOfImperfectionFirstDemonManaCost = 0.15;
ritualOfImperfectionFirstDemonSaminaCost = 0;
ritualOfImperfectionFirstDemonManaRegen = 0;
ritualOfImperfectionFirstDemonStaminaRegen = 0.05;
// Second Demon Costs and Regens
ritualOfImperfectionSecondDemonManaCost = 0.3;
ritualOfImperfectionSecondDemonSaminaCost = 0;
ritualOfImperfectionSecondDemonManaRegen = 0;
ritualOfImperfectionSecondDemonStaminaRegen = 0.1;
// Third Demon Costs and Regens
ritualOfImperfectionThirdDemonManaCost = 0.6;
ritualOfImperfectionThirdDemonSaminaCost = 0;
ritualOfImperfectionThirdDemonManaRegen = 0;
ritualOfImperfectionThirdDemonStaminaRegen = 0.2;
ritualOfImperfectionFirstDemonActive = noone;
ritualOfImperfectionSecondDemonActive = noone;
ritualOfImperfectionThirdDemonActive = noone;
ritualOfImperfectionCastTimeRequiredForFirstDemon = room_speed * 1;
ritualOfImperfectionCastTimeRequiredForSecondDemon = room_speed * 2;
ritualOfImperfectionCastTimeRequiredForThirdDemon = room_speed * 3;
ritualOfImperfectionCurrentCastTime = -1;
ritualOfImperfectionFinalCastTime = -1;

/// Ritual of Death
ritualOfDeathManaCost = 0.6;
ritualOfDeathStaminaCost = 0;
ritualOfDeathManaRegen = 0;
ritualOfDeathStaminaRegen = 0.2;
ritualOfDeathActive = noone;
ritualOfDeathRange = 32 * 6;
#endregion

#region Tier 3
/// Soul Tether
soulTetherManaCost = 0.3;
soulTetherStaminaCost = 0;
soulTetherManaRegen = 0;
soulTetherStaminaRegen = 0.4;
soulTetherActive = false;
soulTetherRange = 32 * 8;
soulTetherTargetArray = noone;
soulTetherTimer = -1;
soulTetherTimerStartTime = room_speed * 10;

/// Dinner is Served
dinnerIsServedManaCost = 0.3;
dinnerIsServedStaminaCost = 0;
dinnerIsServedManaRegen = 0;
dinnerIsServedStaminaRegen = 0.4;
dinnerIsServedActive = false;
dinnerIsServedStartingDamage = 15;
dinnerIsServedRampMultiplier = 1.1;
dinnerIsServedTicTimer = -1;
dinnerIsServedTicTimerStartTime = room_speed * 0.5;
// The next two multipliers are used against the enemy(s) stamina and mana regen stats, to debuff
// them
dinnerIsServedStaminaRegenerationMultiplier = 0.5;
dinnerIsServedManaRegenerationMultiplier = 0.5;
dinnerIsServedRange = 32 * 8;
dinnerIsServedTargetArray = noone;
dinnerIsServedTimer = -1;
dinnerIsServedTimerStartTime = (room_speed * 5) + 1;

/// Final Parting
finalPartingManaCost = 0;
finalPartingStaminaCost = 0.3;
finalPartingManaRegen = 0.4;
finalPartingStaminaRegen = 0;
finalPartingActive = false;
finalPartingDamage = 25;
finalPartingTicTimer = -1;
finalPartingTicTimerStartTime = room_speed * 0.5;
finalPartingDoTTarget = noone;
finalPartingTimer = -1;
finalPartingTimerStartTime = (room_speed * 5) + 1;

/// Risk of Life
riskOfLifeManaCost = 0;
riskOfLifeStaminaCost = 0.3;
riskOfLifeManaRegen = 0.4;
riskOfLifeStaminaRegen = 0;
riskOfLifeHeal = false;
riskOfLifeAoERange = 32 * 3;
riskOfLifeDirectHitDamage = 200;
riskOfLifeDirectHitHeal = 250;
riskOfLifeAoEDamage = 100;
#endregion

#region Tier 4
/// Taken for Pain
takenForPainManaCost = 0;
takenForPainStaminaCost = 0;
takenForPainManaRegen = 0.6;
takenForPainStaminaRegen = 0;
takenForPainRange = 32 * 6;
takenForPainNumberOfSpikes = 6;
takenForPainDamagePerSpike = 75;
takenForPainDamageMultiplierVsPoisonedTargets = 1.5;
takenForPainTargetArray = noone;

/// Sickly Proposition
sicklyPropositionManaCost = 0;
sicklyPropositionStaminaCost = 0;
sicklyPropositionManaRegen = 0.6;
sicklyPropositionStaminaRegen = 0;
sicklyPropositionDamage = 100;
sicklyPropositionDamageMultiplierVsPoisonedTarget = 1.5;
sicklyPropositionDoTDamage = 10;
sicklyPropositionTicTimer = -1;
sicklyPropositionTicTimerStartTime = room_speed * 0.5;
sicklyPropositionDoTTimer = -1;
sicklyPropositionDoTTimerStartTime = (room_speed * 5) + 1;
#endregion
#endregion


