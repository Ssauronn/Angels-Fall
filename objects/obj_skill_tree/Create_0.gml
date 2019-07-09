/// @description Create Skill Tree Variables
// Variable used to set which Prime ability will be used ("Q" ability)
primeAbilityChosen = "Solidify";
keyBarAbilityOneChosen = "Wrath of the Diaboli";
keyBarAbilityOneEquipped = true;
keyBarAbilityTwoChosen = "";
keyBarAbilityTwoEquipped = false;
keyBarAbilityThreeChosen = "";
keyBarAbilityThreeEquipped = false;
keyBarAbilityFourChosen = "";
keyBarAbilityFourEquipped = false;


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
bloodPactManaReturn = 0.35; // Return is given as a multiplier of percent of max stam restored

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
deathIncarnateSecondPhaseStartDamage = 400;
deathIncarnateSecondPhaseSubsequentDamageMultiplier = 0.8;
deathIncarnateSecondPhaseCurrentDamage = 400;
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
soulTetherCanBeRefreshed = true;
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
dinnerIsServedCanBeRefreshed = true;
dinnerIsServedTicTimer = -1;
dinnerIsServedTicTimerStartTime = room_speed * 0.5;
// The next three multipliers are used against the enemy(s) stamina and mana regen stats, and 
// movement speed stats, to debuff them
dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = 0.5;
dinnerIsServedBaseEnemyManaRegenerationMultiplier = 0.5;
dinnerIsServedBaseEnemyMovementSpeedMultiplier = 0.5;
dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
dinnerIsServedEnemyManaRegenerationMultiplier = 1;
dinnerIsServedEnemyMovementSpeedMultiplier = 1;
dinnerIsServedRange = 32 * 5.5;
dinnerIsServedTargetArray = noone;
dinnerIsServedTimer = -1;
dinnerIsServedTimerStartTime = (room_speed * 5) + 1;

/// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
finalPartingManaCost = 0;
finalPartingStaminaCost = 0.3;
finalPartingManaRegen = 0.2;
finalPartingStaminaRegen = 0;
finalPartingActive = false;
finalPartingDamage = 25;
finalPartingCanBeRefreshed = true;
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
takenForPainDamageMultiplierVsPoisonedTargets = 1.5;
takenForPainTargetArray = noone;

/// Sickly Proposition
sicklyPropositionManaCost = 0;
sicklyPropositionStaminaCost = 0;
sicklyPropositionManaRegen = 0.3;
sicklyPropositionStaminaRegen = 0;
sicklyPropositionActive = false;
sicklyPropositionCanBeRefreshed = true;
sicklyPropositionDamage = 100;
sicklyPropositionDamageMultiplierVsPoisonedTarget = 1.5;
sicklyPropositionDoTDamage = 10;
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
wrathOfTheDiaboliManaCost = 0;
wrathOfTheDiaboliStaminaCost = 0.9;
wrathOfTheDiaboliManaRegen = 0;
wrathOfTheDiaboliStaminaRegen = 0;
wrathOfTheDiaboliActive = false;
wrathOfTheDiaboliRange = 32 * 5.5;
wrathOfTheDiaboliDamage = 250;
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
// If the hitbox never hits a target, then this next variable takes effect. This signals to destroy
// the hitbox and sets the above 2 variables equal to the new position of the glinting blade object
// that the player can teleport to.
glintingBladeArrivedAtTargetPos = false;
// If this next variable is attached to an enemy, instead set this to equal the enemy's ID
glintingBladeAttachedToEnemy = noone;
glintingBladeAttachedDamage = 100;
glintingBladeAoEDamage = 50;
glintingBladeAoERange = 32 * 2.5;
glintingBladeSpeed = (32 * 4) / room_speed;
glintingBladeDirection = 0;
glintingBladeTimer = -1;
glintingBladeTimerStartTime = room_speed * 15;

/// Hellish Landscape
hellishLandscapeManaCost = 0.6;
hellishLandscapeStaminaCost = 0;
hellishLandscapeManaRegen = 0;
hellishLandscapeStaminaRegen = 0.1;
hellishLandscapeDamage = 150;
hellishLandscapeAoEDiameter = 32 * 5;
hellishLandscapeStunDuration = room_speed * 3;
#endregion

#region Tier 3
/// Hidden Dagger
hiddenDaggerManaCost = 0;
hiddenDaggerStaminaCost = 0.3;
hiddenDaggerManaRegen = 0.2;
hiddenDaggerStaminaRegen = 0;
hiddenDaggerDamage = 100;
hiddenDaggerCanBeRefreshed = false;
hiddenDaggerTicTimerStartTime = room_speed * 2;
hiddenDaggerStunDuration = room_speed * 2;
hiddenDaggerBaseDamageMultiplier = 2;
hiddenDaggerDamageMultiplierTimerStartTime = hiddenDaggerStunDuration;

/// All Out Attack
allOutAttackManaCost = 0;
allOutAttackStaminaCost = 0.3;
allOutAttackManaRegen = 0.2;
allOutAttackStaminaRegen = 0;
allOutAttackActive = false;
allOutAttackBaseMeleeRangeDamageMultiplier = 2;
allOutAttackRange = 32 * 1.5;
allOutAttackManaBonusOnKill = 0.4;
allOutAttackStaminaBonusOnKill = 0.4;
allOutAttackTimer = -1;
allOutAttackTimerStartTime = room_speed * 10;

/// Exploit Weakness
// ***Exploit weakness does not proc itself.***
exploitWeaknessManaCost = 0.3;
exploitWeaknessStaminaCost = 0;
exploitWeaknessManaRegen = 0;
exploitWeaknessStaminaRegen = 0.2;
exploitWeaknessDamage = 50;
exploitWeaknessDoTDamage = 0;
exploitWeaknessPercentOfDamageToAdd = 0.125;
exploitWeaknessCanBeRefreshed = true;
exploitWeaknessTicTimerStartTime = room_speed * 0.5;
exploitWeaknessTimerStartTime = room_speed * 6;

/// Purifying Rage
purifyingRageManaCost = 0.3;
purifyingRageStaminaCost = 0;
purifyingRageManaRegen = 0;
purifyingRageStaminaRegen = 0.2;
purifyingRageActive = false;
purifyingRageBaseDamageMultiplierForPoisons = 1;
purifyingRageDamageMultiplierForPoisons = 1;
purifyingRageTimer = -1;
purifyingRageTimerStartTime = room_speed * 6;
#endregion

#region Tier 4
/// Rushdown
rushdownManaCost = 0;
rushdownStaminaCost = 0;
rushdownManaRegen = 0;
rushdownStaminaRegen = 0.3;
rushdownDashDamage = 50;
rushdownDashDamageMultiplierActive = false;
rushdownRange = 32 * 4.5;
rushdownMeleeDamage = rushdownDashDamage * 2;
rushdownDashBaseDamageMultiplier = 1.5;
rushdownDashDamageMultiplier = 1;

/// Diabolus Blast
diabolusBlastManaCost = 0;
diabolusBlastStaminaCost = 0;
diabolusBlastManaRegen = 0.3;
diabolusBlastStaminaRegen = 0;
diabolusBlastBaseDamage = 50;
diabolusBlastMaxRange = 32 * 4;
diabolusBlastMaxExtraDamage = 100;
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
bindingsOfTheCaelestiManaCost = 0.6;
bindingsOfTheCaelestiStaminaCost = 0;
bindingsOfTheCaelestiManaRegen = 0;
bindingsOfTheCaelestiStaminaRegen = 0.1;
bindingsOfTheCaelestiActive = false;
bindingsOfTheCaelestiDamage = 15;
bindingsOfTheCaelestiCanBeRefreshed = true;
bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = 0;
bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
bindingsOfTheCaelestiRange = 32 * 3.5;
bindingsOfTheCaelestiTimer = -1;
bindingsOfTheCaelestiTimerStartTime = room_speed * 4;
bindingsOfTheCaelestiTargetArray = noone;
bindingsOfTheCaelestiTicTimer = -1;
bindingsOfTheCaelestiTicTimerStartTime = room_speed * 0.5;

/// Armor of the Caelesti
armorOfTheCaelestiManaCost = 0;
armorOfTheCaelestiStaminaCost = 0.6;
armorOfTheCaelestiManaRegen = 0.1;
armorOfTheCaelestiStaminaRegen = 0;
armorOfTheCaelestiActive = false;
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
holyDefenseBaseDamage = 75;
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
wrathOfTheRepentantManaCost = 0.3;
wrathOfTheRepentantStaminaCost = 0;
wrathOfTheRepentantManaRegen = 0;
wrathOfTheRepentantStaminaRegen = 0.2;
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
theOnePowerManaCost = 0.3;
theOnePowerStaminaCost = 0;
theOnePowerManaRegen = 0;
theOnePowerStaminaRegen = 0.2;
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
theOnePowerDamage = 50;
theOnePowerTicTimer = -1;
theOnePowerTicTimerStartTime = room_speed * 1.5;
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
// Simply set as active for as long as object is in the target array. Otherwise, set as false.
// Then, just apply the damage if this is active and the tic timer is at or less than 0, and apply
// the damage buff if this is active, period.
angelicBarrageActive = false;
angelicBarrageDamage = 33.3334;
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
whirlwindArrivedAtTargetPos = false;
whirlwindSecondPhaseActive = noone;
whirlwindSpeed = 32 * 4 / room_speed;
whirlwindDirection = 0;
whirlwindRange = 32 * 4;
whirlwindTargetXPos = 0;
whirlwindTargetYPos = 0;
#endregion
#endregion


