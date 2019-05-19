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
overwhelmingChainsRange = 32 * 4.5;
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
lifeTaxRange = 32 * 4.5;
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
solidifyRange = 32 * 4.5;
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
Regen: 0/3 of base 0.3 resource regen

Tier 2 Abilities:
Cost: 2/3 of base 0.9 resource cost
Regen: 1/3 of base 0.3 resource regen

Tier 3 Abilities:
Cost: 1/3 of base 0.9 resource cost
Regen: 2/3 of base 0.3 resource regen

Tier 4 Abilities:
Cost: 0/3 of base 0.9 resource cost
Regen: 3/3 of base 0.3 resource regen

So, just a few examples: a Tier 1 stamina ability will cost 0.9 of total stamina, and regen no
mana. A Tier 3 mana ability will cost 0.3 of total mana, and regen 0.2 total stamina. And a Tier 
4 stamina ability will cost no stamina, and regen 0.3 total mana.
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
ritualOfImperfectionFirstDemonStaminaRegen = 0.025;
// Second Demon Costs and Regens
ritualOfImperfectionSecondDemonManaCost = 0.3;
ritualOfImperfectionSecondDemonSaminaCost = 0;
ritualOfImperfectionSecondDemonManaRegen = 0;
ritualOfImperfectionSecondDemonStaminaRegen = 0.05;
// Third Demon Costs and Regens
ritualOfImperfectionThirdDemonManaCost = 0.6;
ritualOfImperfectionThirdDemonSaminaCost = 0;
ritualOfImperfectionThirdDemonManaRegen = 0;
ritualOfImperfectionThirdDemonStaminaRegen = 0.1;
// Whether or not the demons or active; assign these variables an existing object ID
ritualOfImperfectionFirstDemonActive = noone;
ritualOfImperfectionSecondDemonActive = noone;
ritualOfImperfectionThirdDemonActive = noone;
// The times that the ability needs to be cast in order to summon each demon
ritualOfImperfectionCastTimeRequiredForFirstDemon = room_speed * 1;
ritualOfImperfectionCastTimeRequiredForSecondDemon = room_speed * 2;
ritualOfImperfectionCastTimeRequiredForThirdDemon = room_speed * 3;
// How long the spell has been cast
ritualOfImperfectionCurrentCastTime = -1;
ritualOfImperfectionFinalCastTime = -1;

/// Ritual of Death
ritualOfDeathManaCost = 0.6;
ritualOfDeathStaminaCost = 0;
ritualOfDeathManaRegen = 0;
ritualOfDeathStaminaRegen = 0.1;
ritualOfDeathActive = noone;
ritualOfDeathRange = 32 * 6;
#endregion

#region Tier 3
/// Soul Tether
soulTetherManaCost = 0.3;
soulTetherStaminaCost = 0;
soulTetherManaRegen = 0;
soulTetherStaminaRegen = 0.2;
soulTetherActive = false;
soulTetherRange = 32 * 8;
soulTetherTargetArray = noone;
soulTetherTimer = -1;
soulTetherTimerStartTime = room_speed * 10;

/// Dinner is Served
dinnerIsServedManaCost = 0.3;
dinnerIsServedStaminaCost = 0;
dinnerIsServedManaRegen = 0;
dinnerIsServedStaminaRegen = 0.2;
dinnerIsServedActive = false;
dinnerIsServedStartingDamage = 15;
dinnerIsServedRampMultiplier = 1.1;
dinnerIsServedTicTimer = -1;
dinnerIsServedTicTimerStartTime = room_speed * 0.5;
// The next two multipliers are used against the enemy(s) stamina and mana regen stats, to debuff
// them
dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = 0.5;
dinnerIsServedBaseEnemyManaRegenerationMultiplier = 0.5;
dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
dinnerIsServedEnemyManaRegenerationMultiplier = 1;
dinnerIsServedRange = 32 * 5.5;
dinnerIsServedTargetArray = noone;
dinnerIsServedTimer = -1;
dinnerIsServedTimerStartTime = (room_speed * 5) + 1;

/// Final Parting
finalPartingManaCost = 0;
finalPartingStaminaCost = 0.3;
finalPartingManaRegen = 0.2;
finalPartingStaminaRegen = 0;
finalPartingActive = false;
finalPartingDamage = 25;
finalPartingSpeed = (32 * 4) / room_speed;
finalPartingTicTimer = -1;
finalPartingTicTimerStartTime = room_speed * 0.5;
finalPartingDoTTarget = noone;
finalPartingTimer = -1;
finalPartingTimerStartTime = (room_speed * 5) + 1;

/// Risk of Life
riskOfLifeManaCost = 0;
riskOfLifeStaminaCost = 0.3;
riskOfLifeManaRegen = 0.2;
riskOfLifeStaminaRegen = 0;
riskOfLifeSpeed = (32 * 4) / room_speed;
riskOfLifeHeal = false;
riskOfLifeAoERange = 32 * 3.5;
riskOfLifeDirectHitDamage = 200;
riskOfLifeDirectHitHeal = 250;
riskOfLifeAoEDamage = 100;
#endregion

#region Tier 4
/// Taken for Pain
takenForPainManaCost = 0;
takenForPainStaminaCost = 0;
takenForPainManaRegen = 0;
takenForPainStaminaRegen = 0.3;
takenForPainRange = 32 * 4.5;
takenForPainSpeed = (32 * 4) / room_speed;
takenForPainNumberOfSpikes = 6;
takenForPainDamagePerSpike = 75;
takenForPainBaseDamageMultiplierVsPoisonedTargets = 1.5;
takenForPainDamageMultiplierVsPoisonedTargets = 1;
takenForPainTargetArray = noone;

/// Sickly Proposition
sicklyPropositionManaCost = 0;
sicklyPropositionStaminaCost = 0;
sicklyPropositionManaRegen = 0.3;
sicklyPropositionStaminaRegen = 0;
sicklyPropositionDamage = 100;
sicklyPropositionBaseDamageMultiplierVsPoisonedTarget = 1.5;
sicklyPropositionDamageMultiplierVsPoisonedTarget = 1;
sicklyPropositionDoTDamage = 10;
sicklyPropositionSpeed = (32 * 4) / room_speed;
sicklyPropositionTicTimer = -1;
sicklyPropositionTicTimerStartTime = room_speed * 0.5;
sicklyPropositionDoTTimer = -1;
sicklyPropositionDoTTimerStartTime = (room_speed * 5) + 1;
#endregion
#endregion

#region Diabolus Magic
#region Tier 1
/// Wrath of the Diaboli
wrathOfTheDiaboliManaCost = 0;
wrathOfTheDiaboliStaminaCost = 0.9;
wrathOfTheDiaboliManaRegen = 0;
wrathOfTheDiaboliStaminaRegen = 0;
wrathOfTheDiaboliActive = false;
wrathOfTheDiaboliRange = 32 * 5.5;
wrathOfTheDiaboliDamage = 250;
wrathOfTheDiaboliTargetArray = noone;
wrathOfTheDiaboliStartXPos = 0;
wrathOfTheDiaboliStartYPos = 0;
#endregion

#region Tier 2
/// Glinting Blade
glintingBladeManaCost = 0.6;
glintingBladeStaminaCost = 0;
glintingBladeManaRegen = 0;
glintingBladeStaminaRegen = 0.1;
glintingBladeActive = false;
glintingBladeDamage = 100;
glintingBladeTargetXPos = 0;
glintingBladeTargetYPos = 0;
glintingBladeXPos = 0;
glintingBladeYPos = 0;
glintingBladeAttachedToEnemy = false;
glintingBladeAttachedDamage = 100;
glintingBladeAoEDamage = 50;
glintingBladeAoERange = 32 * 2.5;
glintingBladeSpeed = (32 * 4) / room_speed;
glintingBladeTimer = -1;
glintingBladeTimerStartTime = room_speed * 10;

/// Hellish Landscape
hellishLandscapeManaCost = 0.6;
hellishLandscapeStaminaCost = 0;
hellishLandscapeManaRegen = 0;
hellishLandscapeStaminaRegen = 0.1;
hellishLandscapeDamage = 150;
hellishLandscapeAoEDiameter = 32 * 5;
hellishLandscapeStunDuration = room_speed * 4;
#endregion

#region Tier 3
/// Hidden Dagger
hiddenDaggerManaCost = 0;
hiddenDaggerStaminaCost = 0.3;
hiddenDaggerManaRegen = 0.2;
hiddenDaggerStaminaRegen = 0;
hiddenDaggerDamage = 100;
hiddenDaggerTicTimer = -1;
hiddenDaggerTicTimerStartTime = room_speed * 2;
hiddenDaggerStunDuration = room_speed * 2;

/// All Out Attack
allOutAttackManaCost = 0;
allOutAttackStaminaCost = 0.3;
allOutAttackManaRegen = 0.2;
allOutAttackStaminaRegen = 0;
allOutAttackActive = false;
allOutAttackBaseMeleeRangeDamageMultiplier = 2;
allOutAttackMeleeRangeDamageMultiplier = 1;
allOutAttackRange = 32 * 1.5;
allOutAttackManaBonusOnKill = 0.2;
allOutAttackStaminaBonusOnKill = 0.2;
allOutAttackTimer = -1;
allOutAttackTimerStartTime = room_speed * 10;

/// Exploit Weakness
exploitWeaknessManaCost = 0.3;
exploitWeaknessStaminaCost = 0;
exploitWeaknessManaRegen = 0;
exploitWeaknessStaminaRegen = 0.2;
exploitWeaknessDamage = 75;
exploitWeaknessTicTimer = -1;
exploitWeaknessTicTimerStartTime = room_speed * 6;

/// Purifying Rage
purifyingRageManaCost = 0.3;
purifyingRageStaminaCost = 0;
purifyingRageManaRegen = 0;
purifyingRageStaminaRegen = 0.2;
purifyingRageActive = false;
purifyingRageDamageMultiplierForPoisons = 1;
#endregion

#region Tier 4
/// Rushdown
rushdownManaCost = 0;
rushdownStaminaCost = 0;
rushdownManaRegen = 0;
rushdownStaminaRegen = 0.3;
rushdownDashDamage = 50;
rushdownRange = 32 * 4.5;
rushdownMeleeDamage = 100;
rushdownDashBaseDamageMultiplier = 1.5;
rushdownDashDamageMultiplier = 1;
rushdownMeleeBaseDamageMultiplier = 2;
rushdownMeleeDamageMultiplier = 1;

/// Diabolus Blast
diabolusBlastManaCost = 0;
diabolusBlastStaminaCost = 0;
diabolusBlastManaRegen = 0.3;
diabolusBlastStaminaRegen = 0;
diabolusBlastMeleeRangeDamage = 150;
diabolusBlastDistanceRangeDamage = 100;
#endregion
#endregion

#region Caelestus Magic
#region Tier 1
/// True Caelesti Wings
trueCaelestiWingsManaCost = 0;
trueCaelestiWingsStaminaCost = 0.9;
trueCaelestiWingsManaRegen = 0;
trueCaelestiWingsStaminaRegen = 0;
trueCaelestiWingsActive = false;
trueCaelestiWingsBaseDamageMultiplier = 1.5;
trueCaelestiWingsDamageMultiplier = 1;
// Each basic melee attack adds to the trueCaelestiWingsDamageMultiplier by the following amount.
trueCaelestiDamageMultiplierAddedPerBasicMelee = 0.1;
trueCaelestiWingsDeadlyDamageValue = 0;
trueCaelestiWingsTimer = -1;
trueCaelestiWingsTimerStartTime = room_speed * 15;
#endregion

#region Tier 2
/// Bindings of the Caelesti
bindingsOfTheCaelestiManaCost = 0.6;
bindingsOfTheCaelestiStaminaCost = 0;
bindingsOfTheCaelestiManaRegen = 0;
bindingsOfTheCaelestiStaminaRegen = 0.1;
bindingsOfTheCaelestiActive = false;
bindingsOfTheCaelestiRange = 32 * 3.5;
bindingsOfTheCaelestiTimer = -1;
bindingsOfTheCaelestiTimerStartTime = room_speed * 4;
bindingsOfTheCaelestiDamage = 15;
bindingsOfTheCaelestiTargetArray = noone;
bindingsOfTheCaelestiTicTimer = -1;
bindingsOfTheCaelestiTicTimerStartTime = room_speed * 0.5;

/// Armor of the Caelesti
armorOfTheCaelestiManaCost = 0;
armorOfTheCaelestiStaminaCost = 0.6;
armorOfTheCaelestiManaRegen = 0.1;
armorOfTheCaelestiStaminaRegen = 0;
armorOfTheCaelestiActive = true;
armorOfTheCaelestiBaseResistanceMultiplier = 0.5;
armorOfTheCaelestiResistanceMultiplier = 1;
armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
armorOfTheCaelestiExplosionRange = 32 * 2.5;
armorOfTheCaelestiExplosionDamage = 200;
armorOfTheCaelestiTimer = -1;
armorOfTheCaelestiTimerStartTime = room_speed * 8;
#endregion

#region Tier 3
/// Holy Defense
holyDefenseManaCost = 0;
holyDefenseStaminaCost = 0.3;
holyDefenseManaRegen = 0.2;
holyDefenseStaminaRegen = 0;
holyDefenseActive = false;
holyDefenseDamage = 75;
holyDefenseRange = 32 * 2.5;
holyDefenseTimer = -1;
holyDefenseTimerStartTime = room_speed * 12;

/// Wrath of the Repentant
wrathOfTheRepentantManaCost = 0.3;
wrathOfTheRepentantStaminaCost = 0;
wrathOfTheRepentantManaRegen = 0;
wrathOfTheRepentantStaminaRegen = 0.2;
wrathOfTheRepentantActive = false;
wrathOfTheRepentantBaseBasicMeleeDamageBonus = 1.5;
wrathOfTheRepentantBasicMeleeDamageBonus = 1;
// Multiplier to be used against enemy movement speed, to slow them down
wrathOfTheRepentantSlowMultiplier = 0.5;
wrathOfTheRepentantTimer = -1;
wrathOfTheRepentantTimerStartTime = room_speed * 10;

/// The One Power
theOnePowerManaCost = 0.3;
theOnePowerStaminaCost = 0;
theOnePowerManaRegen = 0;
theOnePowerStaminaRegen = 0.2;
theOnePowerActive = false;
theOnePowerRange = 32 * 4.5;
theOnePowerRotationDistanceFromPlayer = 32 * 1.5;
// This is the function to determine the length of an arc of a circle. Essentially, the orb will
// travel 90 degrees around the player in 1 second of game time. Meaning it'll take the orb 4
// seconds to complete one full rotation.
theOnePowerRotationSpeed = ((90 / 360) * (2 * pi * theOnePowerRotationDistanceFromPlayer)) / (room_speed * 1);
theOnePowerDamage = 50;
theOnePowerTicTimer = -1;
theOnePowerTicTimerStartTime = room_speed * 1;
theOnePowerTimer = -1;
theOnePowerTimerStartTime = room_speed * 30;

/// Lightning Spear
lightningSpearManaCost = 0;
lightningSpearStaminaCost = 0.3;
lightningSpearManaRegen = 0.2;
lightningSpearStaminaRegen = 0;
lightningSpearDamage = 150;
lightningSpearSpeed = 32 * 4 / room_speed;
lightningSpearBasicMeleeDamageMultiplierActive = false;
lightningSpearBaseBasicMeleeDamageMultiplier = 2;
lightningSpearBasicMeleeDamageMultiplier = 1;
#endregion

#region Tier 4
/// Angelic Barrage
angelicBarrageManaCost = 0;
angelicBarrageStaminaCost = 0;
angelicBarrageManaRegen = 0.3;
angelicBarrageStaminaRegen = 0;
angelicBarrageDamage = 33.3334;
angelicBarrageTicTimer = -1;
angelicBarrageTicTimerStartTime = room_speed * 1;
angelicBarrageAoEDiameter = 32 * 3.5;
angelicBarrageTargetArray = noone;
angelicBarrageBaseDamageMultiplier = 1.5;
angelicBarrageDamageMultiplier = 1;
angelicBarrageTimer = -1;
angelicBarrageTimerStartTime = room_speed * 4;

/// Whirlwind
whirlwindManaCost = 0;
whirlwindStaminaCost = 0;
whirlwindManaRegen = 0;
whirlwindStaminaRegen = 0.3;
whirlwindActive = false;
whirlwindDamage = 50;
whirlwindFirstPhaseActive = noone;
whirlwindSecondPhaseActive = noone;
whirlwindSpeed = 32 * 4 / room_speed;
whirlwindRange = 32 * 4;
whirlwindTargetXPos = 0;
whirlwindTargetYPos = 0;
#endregion
#endregion


