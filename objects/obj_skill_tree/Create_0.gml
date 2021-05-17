/// @description Create Skill Tree Variables
// Variable used to set which Prime ability will be used ("Q" ability)
primeAbilityChosen = "Solidify";
keyBarAbilityOneChosen = "Glinting Blade";
keyBarAbilityOneEquipped = true;
keyBarAbilityTwoChosen = "Diabolus Blast";
keyBarAbilityTwoEquipped = false;
keyBarAbilityThreeChosen = "Hidden Dagger";
keyBarAbilityThreeEquipped = false;
keyBarAbilityFourChosen = "Taken for Pain";
keyBarAbilityFourEquipped = false;


/// Setup all abilities
#region Parry Ability and Effects
// ---PARRY ABILITY---
// Variable used to set which Parry ability will be used ("F" ability)
parryEffectChosen = "Slow Time Effect";

// Variables used to set the parry timer, and the time slow timer
slowEnemyTimeWithParryActive = false;
slowEnemyTimeWithParryTimer = -1;
slowEnemyTimeWithParryTimerStartTime = 2 * room_speed;
parryWindowActive = false;
successfulParryEffectNeedsToBeAppliedToEnemy = false;
successfulParryInvulnerabilityActive = false;
parryFailureStaminaCost = 100;
parrySuccessfullyCombod = false;
#endregion


#region Blood Magic
#region Tier 1 Abilities
/// Crawl of Torment
crawlOfTormentBloodMagicCost = 4; // Cost is given as a number of how much Blood Magic resources will be taken (out of 10)
crawlOfTormentActive = false;
// Set to 1, because subtracting 1 from the original value of enemyGameSpeed (1) will give us 0, 
// and taking the average of this and the userInterfaceGameSpeed will reduce enemy total speed 
// down to 0.5
crawlOfTormentPower = 1;
crawlOfTormentTimer = -1;
crawlOfTormentTimerStartTime = room_speed * 4;
// Set to false at beginning of ability, when timer reaches 0 this is set to true again and the
// number 1 is added to this to revert the effects of crawlOfTorment
crawlOfTormentReverted = true;

/// Dilge Furend
dilgeFurendHPCost = 0;
#endregion

#region Tier 2 Abilities
/// Overwhelming Chains
overWhelmingChainsBloodMagicCost = 3; // Cost is given as a number of how much Blood Magic resources will be taken (out of 10)
overwhelmingChainsActive = false;
overwhelmingChainsRange = 32 * 4.5;
overwhelmingChainsEffectedTarget = noone;
overwhelmingChainsBaseDamageMultiplier = 1.5;
overwhelmingChainsDamageMultiplier = 1;
overwhelmingChainsBaseDamageResistanceMultiplier = 0.5;
overwhelmingChainsDamageResistanceMultiplier = 1;

/// All is Given
allIsGivenActive = false;
allIsGivenMultiplier = 1;
allIsGivenBloodMagicCost = 4;
allIsGivenTimer = -1;
allIsGivenTimerStartTime = room_speed * 10;
#endregion

#region Tier 3 Abilities
/// Forces of Life
forcesOfLifeBloodMagicCostPerFrame = 1 / room_speed;
forcesOfLifeActive = false;
forcesOfLifeBaseDamageMultiplier = 2;
forcesOfLifeDamageMultiplier = 1;

/// Blood Pact
bloodPactBloodMagicCost = 3.5; // Cost is given as a number of how much Blood Magic resources will be taken (out of 10)
bloodPactStaminaReturn = 0.35; // Return is given as a multiplier of percent of max stam restored

/// Life Tax
lifeTaxBloodMagicCost = 4;
lifeTaxDamageToOtherObjectsMultiplier = 0.15;
lifeTaxActive = false;
lifeTaxRange = 32 * 4.5;
// Set to 1 instead of 0 because player is automatically effected, meaning it last at least for as
// long as the base timer amount each cast.
lifeTaxNumberOfObjectsEffected = 1;
lifeTaxBaseBonusDamageResistanceMultiplier = 0.5;
lifeTaxBonusDamageResistanceMultiplier = 1;
lifeTaxTimer = -1;
lifeTaxTimerStartTime = room_speed * 3;

/// Blood for Blood
// This cost is the only ability that has a permanent HP cost. This ability is for those who have
// too much HP to use and want to spend it somewhere.
bloodForBloodBloodMagicCost = 5;
bloodForBloodDamage = 350;
bloodForBloodTarget = noone;
#endregion

#region Tier 4 Abilities
/// For the Greater Good
forTheGreaterGoodBloodMagicCost = 3; // Cost is given as a number of how much Blood Magic resources will be taken (out of 10)
forTheGreaterGoodActive = false;
forTheGreaterGoodBaseDamageMultiplier = 2;
forTheGreaterGoodDamageMultiplier = 1;
forTheGreaterGoodAttacksEffected = 0;
forTheGreaterGoodMaxAttacksToEffect = 3;
forTheGreaterGoodTimer = -1;
forTheGreaterGoodTimerStartTime = room_speed * 10;

/// Solidify
solidifyBloodMagicCost = 1; // Cost is given as a number of how much Blood Magic resources will be taken (out of 10)
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
Cost: 80% of max resource

Tier 2 Abilities:
Cost: 50% of max resource

Tier 3 Abilities:
Cost: 20% of max resource

Tier 4 Abilities:
Regen: 5% of max resource
*/

#region Necromancy Magic
#region Tier 1
/// Death Incarnate
deathIncarnateStaminaCostMultiplier = 0.8;
deathIncarnateStaminaRegenMultiplier = 0;
deathIncarnateStaminaCost = 800;
deathIncarnateStaminaRegen = 0;
deathIncarnateFirstPhaseActive = false;
deathIncarnateFirstPhaseDamage = 15;
deathIncarnateFirstPhaseWalkDirection = 0;
deathIncarnateFirstPhaseTargetXPos = -1;
deathIncarnateFirstPhaseTargetYPos = -1;
deathIncarnateFirstPhaseMovementSpeed = (32 * 4) / room_speed;
deathIncarnateSecondPhaseActive = false;
deathIncarnateSecondPhaseTargetList = noone;
deathIncarnateSecondPhaseCurrentTarget = noone;
deathIncarnateSecondPhaseStartDamage = 400;
deathIncarnateSecondPhaseSubsequentDamageMultiplier = 0.8;
deathIncarnateSecondPhaseCurrentDamage = 400;
deathIncarnateSecondPhaseMovementSpeed = (32 * 8) / room_speed;
deathIncarnateSecondPhaseReachedTarget = false;
deathIncarnateSecondPhaseImageIndexToAttackOn = 4;
deathIncarnateSecondPhaseAttackedTarget = false;
deathIncarnateImageIndex = 0;
deathIncarnateFirstPhaseReachedTarget = false;
#endregion

#region Tier 2
/// Ritual of Imperfection
// First Demon Costs and Regens
ritualOfImperfectionFirstDemonStaminaCostMultiplier = 0.125;
ritualOfImperfectionFirstDemonStaminaRegenMultiplier = 0;
ritualOfImperfectionFirstDemonStaminaCost = 125;
ritualOfImperfectionFirstDemonStaminaRegen = 0;
// Second Demon Costs and Regens
ritualOfImperfectionSecondDemonStaminaCostMultiplier = 0.25;
ritualOfImperfectionSecondDemonStaminaRegenMultiplier = 0;
ritualOfImperfectionSecondDemonStaminaCost = 250;
ritualOfImperfectionSecondDemonStaminaRegen = 0;
// Third Demon Costs and Regens
ritualOfImperfectionThirdDemonStaminaCostMultiplier = 0.5;
ritualOfImperfectionThirdDemonStaminaRegenMultiplier = 0;
ritualOfImperfectionThirdDemonStaminaCost = 500;
ritualOfImperfectionThirdDemonStaminaRegen = 0;
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
ritualOfDeathStaminaCostMultiplier = 0.5;
ritualOfDeathStaminaRegenMultiplier = 0;
ritualOfDeathStaminaCost = 500;
ritualOfDeathStaminaRegen = 0;
ritualOfDeathActive = noone;
ritualOfDeathRange = 32 * 6;
#endregion

#region Tier 3
/// Soul Tether
soulTetherStaminaCostMultiplier = 0.2;
soulTetherStaminaRegenMultiplier = 0;
soulTetherStaminaCost = 200;
soulTetherStaminaRegen = 0;
soulTetherActive = false;
soulTetherCanBeRefreshed = true;
soulTetherRange = 32 * 8;
soulTetherTargetArray = noone;
soulTetherTimer = -1;
soulTetherTimerStartTime = room_speed * 10;

/// Dinner is Served
dinnerIsServedStaminaCostMultiplier = 0.2;
dinnerIsServedStaminaRegenMultiplier = 0;
dinnerIsServedStaminaCost = 200;
dinnerIsServedStaminaRegen = 0;
dinnerIsServedActive = false;
dinnerIsServedStartingDamage = 15;
dinnerIsServedRampMultiplier = 1.1;
dinnerIsServedCanBeRefreshed = true;
dinnerIsServedTicTimer = -1;
dinnerIsServedTicTimerStartTime = room_speed * 0.5;
// The next three multipliers are used against the enemy(s) stamina regen stat, and 
// movement speed stat, to debuff them
dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = 0.5;
dinnerIsServedBaseEnemyMovementSpeedMultiplier = 0.5;
dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
dinnerIsServedEnemyMovementSpeedMultiplier = 1;
dinnerIsServedRange = 32 * 5.5;
dinnerIsServedTargetArray = noone;
dinnerIsServedTimer = -1;
dinnerIsServedTimerStartTime = (room_speed * 5) + 1;

/// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
finalPartingStaminaCostMultiplier = 0.2;
finalPartingStaminaRegenMultiplier = 0;
finalPartingStaminaCost = 200;
finalPartingStaminaRegen = 0;
finalPartingActive = false;
finalPartingDamage = 25;
finalPartingCanBeRefreshed = true;
finalPartingSpeed = (32 * 4) / room_speed;
finalPartingTargetXPos = -1;
finalPartingTargetYPos = -1;
finalPartingTicTimer = -1;
finalPartingTicTimerStartTime = room_speed * 0.5;
finalPartingDoTTarget = noone;
finalPartingTimer = -1;
finalPartingTimerStartTime = (room_speed * 5) + 1;

/// Risk of Life
riskOfLifeStaminaCostMultiplier = 0.2;
riskOfLifeStaminaRegenMultiplier = 0;
riskOfLifeStaminaCost = 200;
riskOfLifeStaminaRegen = 0;
riskOfLifeSpeed = (32 * 4) / room_speed;
riskOfLifeTargetXPos = -1;
riskOfLifeTargetYPos = -1;
riskOfLifeAoERange = 32 * 3.5;
riskOfLifeDirectHitDamage = 200;
riskOfLifeDirectHitHeal = 250;
riskOfLifeAoEDamage = 100;
#endregion

#region Tier 4
/// Taken for Pain
takenForPainStaminaCostMultiplier = 0;
takenForPainStaminaRegenMultiplier = 0.05;
takenForPainStaminaCost = 0;
takenForPainStaminaRegen = 50;
takenForPainFirstPhaseActive = false;
takenForPainSecondPhaseActive = false;
takenForPainSpeed = (32 * 12) / room_speed;
// DO NOT INCREASE THE BELOW NUMBER PAST 60
takenForPainNumberOfSpikes = 10;
takenForPainDamagePerSpike = 12.5;
takenForPainDamageMultiplierVsPoisonedTargets = 1.5;
takenForPainHitboxList = noone;
takenForPainFirstPhaseTimer = -1;
takenForPainFirstPhaseTimerStartTime = room_speed * 1;
takenForPainSecondPhaseTimer = -1;
takenForPainSecondPhaseTimerStartTime = room_speed * 1;

/// Sickly Proposition
sicklyPropositionStaminaCostMultiplier = 0;
sicklyPropositionStaminaRegenMultiplier = 0.05;
sicklyPropositionStaminaCost = 0;
sicklyPropositionStaminaRegen = 50;
sicklyPropositionActive = false;
sicklyPropositionCanBeRefreshed = true;
sicklyPropositionDamage = 100;
sicklyPropositionDamageMultiplierVsPoisonedTarget = 1.5;
sicklyPropositionDoTDamage = 10;
sicklyPropositionTargetXPos = -1;
sicklyPropositionTargetYPos = -1;
sicklyPropositionSpeed = (32 * 4) / room_speed;
sicklyPropositionTicTimer = -1;
sicklyPropositionTicTimerStartTime = room_speed * 0.5;
sicklyPropositionTimer = -1;
sicklyPropositionTimerStartTime = (room_speed * 5) + 1;
#endregion
#endregion

#region Diabolus Magic
#region Tier 1
/// Wrath of the Diaboli
wrathOfTheDiaboliStaminaCostMultiplier = 0.8;
wrathOfTheDiaboliStaminaRegenMultiplier = 0;
wrathOfTheDiaboliStaminaCost = 800;
wrathOfTheDiaboliStaminaRegen = 0;
wrathOfTheDiaboliActive = false;
wrathOfTheDiaboliRange = 32 * 5.5;
wrathOfTheDiaboliDamage = 125;
wrathOfTheDiaboliCurrentTargetCount = 0;
wrathOfTheDiaboliMaxTargetCount = 5;
wrathOfTheDiaboliTargetsHit = 0;
wrathOfTheDiaboliTargetArray = noone;
wrathOfTheDiaboliStartXPos = 0;
wrathOfTheDiaboliStartYPos = 0;
wrathOfTheDiaboliStartDirection = 0;
wrathOfTheDiaboliTeleportedToNextTarget = false;
#endregion

#region Tier 2
/// Glinting Blade
glintingBladeStaminaCostMultiplier = 0.5;
glintingBladeStaminaRegenMultiplier = 0;
glintingBladeStaminaCost = 500;
glintingBladeStaminaRegen = 0;
glintingBladeActive = false;
glintingBladeDamage = 50;
glintingBladeTargetXPos = 0;
glintingBladeTargetYPos = 0;
glintingBladeXPos = 0;
glintingBladeYPos = 0;
// If the hitbox never hits a target, then this next variable takes effect. This signals to destroy
// the hitbox and sets the above 2 variables equal to the new position of the glinting blade object
// that the player can teleport to.
glintingBladeArrivedAtTargetPos = false;
// If this next variable is attached to an enemy, instead set this to equal the enemy's ID
glintingBladeAttachedToEnemy = noone;
glintingBladeAttachedDamage = 50;
glintingBladeAoEDamage = 25;
glintingBladeAoERange = 32 * 2.5;
glintingBladeSpeed = (32 * 4) / room_speed;
glintingBladeDirection = 0;
glintingBladeTimer = -1;
glintingBladeTimerStartTime = room_speed * 15;

/// Hellish Landscape
hellishLandscapeStaminaCostMultiplier = 0.5;
hellishLandscapeStaminaRegenMultiplier = 0;
hellishLandscapeStaminaCost = 500;
hellishLandscapeStaminaRegen = 0;
hellishLandscapeDamage = 75;
hellishLandscapeStunDuration = room_speed * 3;
hellishLandscapeTargetX = 0;
hellishLandscapeTargetY = 0;
#endregion

#region Tier 3
/// Hidden Dagger
hiddenDaggerStaminaCostMultiplier = 0.2;
hiddenDaggerStaminaRegenMultiplier = 0;
hiddenDaggerStaminaCost = 200;
hiddenDaggerStaminaRegen = 0;
hiddenDaggerDamage = 50;
hiddenDaggerCanBeRefreshed = false;
hiddenDaggerTicTimerStartTime = room_speed * 2;
hiddenDaggerStunDuration = room_speed * 2;
hiddenDaggerBaseDamageMultiplier = 2;
hiddenDaggerDamageMultiplierTimerStartTime = hiddenDaggerStunDuration;

/// All Out Attack
allOutAttackStaminaCostMultiplier = 0.2;
allOutAttackStaminaRegenMultiplier = 0;
allOutAttackStaminaCost = 200;
allOutAttackStaminaRegen = 0;
allOutAttackActive = false;
allOutAttackBaseMeleeRangeDamageMultiplier = 2;
allOutAttackRange = 32 * 1.5;
allOutAttackStaminaBonusOnKill = 0.4;
allOutAttackTimer = -1;
allOutAttackTimerStartTime = room_speed * 10;

/// Exploit Weakness
// ***Exploit weakness does not proc itself.***
exploitWeaknessStaminaCostMultiplier = 0.2;
exploitWeaknessStaminaRegenMultiplier = 0;
exploitWeaknessStaminaCost = 200;
exploitWeaknessStaminaRegen = 0;
exploitWeaknessDamage = 25;
exploitWeaknessDoTDamage = 0;
exploitWeaknessPercentOfDamageToAdd = 0.125;
exploitWeaknessCanBeRefreshed = true;
exploitWeaknessTicTimerStartTime = room_speed * 0.5;
exploitWeaknessTimerStartTime = room_speed * 6;

/// Purifying Rage
purifyingRageStaminaCostMultiplier = 0.2;
purifyingRageStaminaRegenMultiplier = 0;
purifyingRageStaminaCost = 200;
purifyingRageStaminaRegen = 0;
purifyingRageActive = false;
purifyingRageBaseDamageMultiplierForPoisons = 1;
purifyingRageDamageMultiplierForPoisons = 1;
purifyingRageTimer = -1;
purifyingRageTimerStartTime = room_speed * 6;
#endregion

#region Tier 4
/// Rushdown
rushdownStaminaCostMultiplier = 0;
rushdownStaminaRegenMultiplier = 0.05;
rushdownStaminaCost = 0;
rushdownStaminaRegen = 50;
rushdownDashDamage = 25;
rushdownDashDamageMultiplierActive = false;
rushdownRange = 32 * 4.5;
rushdownTarget = noone;
rushdownMeleeDamage = rushdownDashDamage * 2;
rushdownDashBaseDamageMultiplier = 1.5;
rushdownDashDamageMultiplier = 1;
rushdownMeleeRange = 32 * 1.5;
rushdownDashed = false;
rushdownDashTimer = -1;
rushdownDashTimerStartTime = room_speed * 1;

/// Diabolus Blast
diabolusBlastStaminaCostMultiplier = 0;
diabolusBlastStaminaRegenMultiplier = 0.05;
diabolusBlastStaminaCost = 0;
diabolusBlastStaminaRegen = 50;
diabolusBlastBaseDamage = 25;
diabolusBlastMaxRange = 32 * 4;
diabolusBlastMaxExtraDamage = 50;
#endregion
#endregion

#region Caelestus Magic
#region Tier 1
/// True Caelesti Wings
trueCaelestiWingsStaminaCostMultiplier = 0.8;
trueCaelestiWingsStaminaRegenMultiplier = 0;
trueCaelestiWingsStaminaCost = 800;
trueCaelestiWingsStaminaRegen = 0;
trueCaelestiWingsActive = false;
trueCaelestiWingsBaseDamageMultiplier = 1.5;
trueCaelestiWingsDamageMultiplier = 1;
trueCaelestiWingsBaseDebuffDamageMultiplier = 1;
trueCaelestiWingsDebuffDamageMultiplier = 1;
// Each basic melee attack adds to the trueCaelestiWingsDebuffDamageMultiplier by the following amount,
// multiplied by the next variable which is added to by one with every hit against the enemy while this
// ability is active.
trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee = 0.2;
trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
trueCaelestiWingsDeadlyDamageValue = 0;
trueCaelestiWingsDebuffTimer = -1;
trueCaelestiWingsDebuffTimerStartTime = room_speed * 7.5;
trueCaelestiWingsTimer = -1;
trueCaelestiWingsTimerStartTime = room_speed * 15;
#endregion

#region Tier 2
/// Bindings of the Caelesti
bindingsOfTheCaelestiStaminaCostMultiplier = 0.5;
bindingsOfTheCaelestiStaminaRegenMultiplier = 0;
bindingsOfTheCaelestiStaminaCost = 500;
bindingsOfTheCaelestiStaminaRegen = 0;
bindingsOfTheCaelestiActive = false;
bindingsOfTheCaelestiDamage = 15;
bindingsOfTheCaelestiCanBeRefreshed = true;
bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = 0;
bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
bindingsOfTheCaelestiRange = 32 * 3.5;
bindingsOfTheCaelestiTimer = -1;
bindingsOfTheCaelestiTimerStartTime = room_speed * 4;
bindingsOfTheCaelestiTicTimer = -1;
bindingsOfTheCaelestiTicTimerStartTime = room_speed * 0.5;

/// Armor of the Caelesti
armorOfTheCaelestiStaminaCostMultiplier = 0.5;
armorOfTheCaelestiStaminaRegenMultiplier = 0;
armorOfTheCaelestiStaminaCost = 500;
armorOfTheCaelestiStaminaRegen = 0;
armorOfTheCaelestiActive = false;
armorOfTheCaelestiBaseResistanceMultiplier = 0.5;
armorOfTheCaelestiResistanceMultiplier = 1;
armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
armorOfTheCaelestiExplosionRange = 32 * 2.5;
armorOfTheCaelestiExplosionDamage = 100;
armorOfTheCaelestiTimer = -1;
armorOfTheCaelestiTimerStartTime = room_speed * 8;
#endregion

#region Tier 3
/// Holy Defense
holyDefenseStaminaCostMultiplier = 0.2;
holyDefenseStaminaRegenMultiplier = 0;
holyDefenseStaminaCost = 200;
holyDefenseStaminaRegen = 0;
holyDefenseActive = false;
holyDefenseBaseDamage = 50;
holyDefenseStruckDamage = 0;
holyDefenseParryDamage = 0;
holyDefenseDoTDamage = 20;
holyDefenseCanBeRefreshed = true;
holyDefenseRange = 32 * 2.5;
holyDefenseTicTimer = -1;
holyDefenseTicTimerStartTime = room_speed * 1;
holyDefenseTimer = 300;
holyDefenseTimerStartTime = (room_speed * 3) + 1;

/// Wrath of the Repentant
wrathOfTheRepentantStaminaCostMultiplier = 0.2;
wrathOfTheRepentantStaminaRegenMultiplier = 0;
wrathOfTheRepentantStaminaCost = 200;
wrathOfTheRepentantStaminaRegen = 0;
wrathOfTheRepentantActive = false;
wrathOfTheRepentantBaseBasicMeleeDamageBonus = 1.5;
wrathOfTheRepentantBasicMeleeDamageBonus = 1;
// Multiplier to be used against enemy movement speed, to slow them down
wrathOfTheRepentantBaseMovementSpeedMultiplier = 0.5;
wrathOfTheRepentantMovementSpeedMultiplier = 1;
wrathOfTheRepentantDebuffTimer = -1;
wrathOfTheRepentantDebuffTimerStartTime = room_speed * 5;
wrathOfTheRepentantTimer = -1;
wrathOfTheRepentantTimerStartTime = room_speed * 10;

/// The One Power
theOnePowerStaminaCostMultiplier = 0.2;
theOnePowerStaminaRegenMultiplier = 0;
theOnePowerStaminaCost = 200;
theOnePowerStaminaRegen = 0;
theOnePowerActive = false;
theOnePowerRange = 32 * 4.5;
theOnePowerRotationAngle = 0;
theOnePowerRotationTimeForAFullCircle = room_speed * 2.75;
theOnePowerRotationDistanceFromPlayer = 32 * 1.5;
// This is the function to determine the length of an arc of a circle. Essentially, the orb will
// travel 90 degrees around the player in 1 second of game time. Meaning it'll take the orb 4
// seconds to complete one full rotation.
theOnePowerRotationSpeed = ((90 / 360) * (2 * pi * theOnePowerRotationDistanceFromPlayer)) / theOnePowerRotationTimeForAFullCircle;
theOnePowerOriginXPos = 0;
theOnePowerOriginYPos = 0;
theOnePowerProjectileSpeed = (32 * 4) / room_speed;
theOnePowerDamage = 25;
theOnePowerTicTimer = -1;
theOnePowerTicTimerStartTime = room_speed * 1.5;
theOnePowerTimer = -1;
theOnePowerTimerStartTime = room_speed * 30;

/// Lightning Spear
lightningSpearStaminaCostMultiplier = 0.2;
lightningSpearStaminaRegenMultiplier = 0;
lightningSpearStaminaCost = 200;
lightningSpearStaminaRegen = 0;
lightningSpearDamage = 75;
lightningSpearSpeed = 32 * 4 / room_speed;
lightningSpearTargetXPos = -1;
lightningSpearTargetYPos = -1;
lightningSpearBasicMeleeDamageMultiplierActive = false;
lightningSpearBaseBasicMeleeDamageMultiplier = 2;
lightningSpearBasicMeleeDamageMultiplier = 1;
#endregion

#region Tier 4
/// Angelic Barrage
angelicBarrageStaminaCostMultiplier = 0;
angelicBarrageStaminaRegenMultiplier = 0.05;
angelicBarrageStaminaCost = 0;
angelicBarrageStaminaRegen = 50;
// Simply set as active for as long as object is in the target array. Otherwise, set as false.
// Then, just apply the damage if this is active and the tic timer is at or less than 0, and apply
// the damage buff if this is active, period.
angelicBarrageActive = false;
angelicBarrageDamage = 34;
angelicBarrageTargetXPos = -1;
angelicBarrageTargetYPos = -1;
angelicBarrageTicTimer = -1;
angelicBarrageTicTimerStartTime = room_speed * 1;
angelicBarrageAoEDiameter = 32 * 3.5;
angelicBarrageTargetArray = noone;
// Multiplier used against the resistance of enemies effected. If Angelic Barrage is active, their
// resistance will drop (or go up) to 1.5. It goes up to 1.5 instead of down to say, 0.5, because
// increasing the multiplier of resistances also increases the damage the enemy will take, because I
// multiply the resistance multiplier against the damage.
angelicBarrageBaseDamageMultiplier = 1.5;
angelicBarrageDamageMultiplier = 1;
angelicBarrageTimerStartTime = room_speed * 4;

/// Whirlwind
whirlwindStaminaCostMultiplier = 0;
whirlwindStaminaRegenMultiplier = 0.05;
whirlwindStaminaCost = 0;
whirlwindStaminaRegen = 50;
whirlwindActive = false;
whirlwindDamage = 25;
whirlwindFirstPhaseActive = noone;
whirlwindArrivedAtTargetPos = false;
whirlwindSecondPhaseActive = noone;
whirlwindSpeed = 32 * 8 / room_speed;
whirlwindDirection = 0;
whirlwindRange = 32 * 4;
whirlwindTargetXPos = 0;
whirlwindTargetYPos = 0;
#endregion
#endregion


