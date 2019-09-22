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
deathIncarnateManaCostMultiplier = 0.9;
deathIncarnateStaminaCostMultiplier = 0;
deathIncarnateManaRegenMultiplier = 0;
deathIncarnateStaminaRegenMultiplier = 0;
deathIncarnateManaCost = 0.9;
deathIncarnateStaminaCost = 0;
deathIncarnateManaRegen = 0;
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
ritualOfImperfectionFirstDemonManaCostMultiplier = 0.15;
ritualOfImperfectionFirstDemonStaminaCostMultiplier = 0;
ritualOfImperfectionFirstDemonManaRegenMultiplier = 0;
ritualOfImperfectionFirstDemonStaminaRegenMultiplier = 0.025;
ritualOfImperfectionFirstDemonManaCost = 0.15;
ritualOfImperfectionFirstDemonStaminaCost = 0;
ritualOfImperfectionFirstDemonManaRegen = 0;
ritualOfImperfectionFirstDemonStaminaRegen = 0.025;
// Second Demon Costs and Regens
ritualOfImperfectionSecondDemonManaCostMultiplier = 0.3;
ritualOfImperfectionSecondDemonStaminaCostMultiplier = 0;
ritualOfImperfectionSecondDemonManaRegenMultiplier = 0;
ritualOfImperfectionSecondDemonStaminaRegenMultiplier = 0.05;
ritualOfImperfectionSecondDemonManaCost = 0.3;
ritualOfImperfectionSecondDemonStaminaCost = 0;
ritualOfImperfectionSecondDemonManaRegen = 0;
ritualOfImperfectionSecondDemonStaminaRegen = 0.05;
// Third Demon Costs and Regens
ritualOfImperfectionThirdDemonManaCostMultiplier = 0.6;
ritualOfImperfectionThirdDemonStaminaCostMultiplier = 0;
ritualOfImperfectionThirdDemonManaRegenMultiplier = 0;
ritualOfImperfectionThirdDemonStaminaRegenMultiplier = 0.1;
ritualOfImperfectionThirdDemonManaCost = 0.6;
ritualOfImperfectionThirdDemonStaminaCost = 0;
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
ritualOfDeathManaCostMultiplier = 0.6;
ritualOfDeathStaminaCostMultiplier = 0;
ritualOfDeathManaRegenMultiplier = 0;
ritualOfDeathStaminaRegenMultiplier = 0.1;
ritualOfDeathManaCost = 0.6;
ritualOfDeathStaminaCost = 0;
ritualOfDeathManaRegen = 0;
ritualOfDeathStaminaRegen = 0.1;
ritualOfDeathActive = noone;
ritualOfDeathRange = 32 * 6;
#endregion

#region Tier 3
/// Soul Tether
soulTetherManaCostMultiplier = 0.3;
soulTetherStaminaCostMultiplier = 0;
soulTetherManaRegenMultiplier = 0;
soulTetherStaminaRegenMultiplier = 0.2;
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
dinnerIsServedManaCostMultiplier = 0.3;
dinnerIsServedStaminaCostMultiplier = 0;
dinnerIsServedManaRegenMultiplier = 0;
dinnerIsServedStaminaRegenMultiplier = 0.2;
dinnerIsServedManaCost = 0.3;
dinnerIsServedStaminaCost = 0;
dinnerIsServedManaRegen = 0;
dinnerIsServedStaminaRegen = 0.2;
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
finalPartingManaCostMultiplier = 0;
finalPartingStaminaCostMultiplier = 0.3;
finalPartingManaRegenMultiplier = 0.2;
finalPartingStaminaRegenMultiplier = 0;
finalPartingManaCost = 0;
finalPartingStaminaCost = 0.3;
finalPartingManaRegen = 0.2;
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
riskOfLifeManaCostMultiplier = 0;
riskOfLifeStaminaCostMultiplier = 0.3;
riskOfLifeManaRegenMultiplier = 0.2;
riskOfLifeStaminaRegenMultiplier = 0;
riskOfLifeManaCost = 0;
riskOfLifeStaminaCost = 0.3;
riskOfLifeManaRegen = 0.2;
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
takenForPainManaCostMultiplier = 0;
takenForPainStaminaCostMultiplier = 0;
takenForPainManaRegenMultiplier = 0;
takenForPainStaminaRegenMultiplier = 0.3;
takenForPainFirstPhaseActive = false;
takenForPainSecondPhaseActive = false;
takenForPainManaCost = 0;
takenForPainStaminaCost = 0;
takenForPainManaRegen = 0;
takenForPainStaminaRegen = 0.3;
takenForPainRange = 32 * 4.5;
takenForPainSpeed = (32 * 4) / room_speed;
takenForPainNumberOfSpikes = 6;
takenForPainDamagePerSpike = 75;
takenForPainDamageMultiplierVsPoisonedTargets = 1.5;
takenForPainTargetList = noone;
takenForPainHitboxList = noone;
takenForPainFirstPhaseTimer = -1;
takenForPainFirstPhaseTimerStartTime = room_speed * 1;
takenForPainSecondPhaseTimer = -1;
takenForPainSecondPhaseTimerStartTime = room_speed * 1;

/// Sickly Proposition
sicklyPropositionManaCostMultiplier = 0;
sicklyPropositionStaminaCostMultiplier = 0;
sicklyPropositionManaRegenMultiplier = 0.3;
sicklyPropositionStaminaRegenMultiplier = 0;
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
wrathOfTheDiaboliManaCostMultiplier = 0;
wrathOfTheDiaboliStaminaCostMultiplier = 0.9;
wrathOfTheDiaboliManaRegenMultiplier = 0;
wrathOfTheDiaboliStaminaRegenMultiplier = 0;
wrathOfTheDiaboliManaCost = 0;
wrathOfTheDiaboliStaminaCost = 0.9;
wrathOfTheDiaboliManaRegen = 0;
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
glintingBladeManaCostMultiplier = 0.6;
glintingBladeStaminaCostMultiplier = 0;
glintingBladeManaRegenMultiplier = 0;
glintingBladeStaminaRegenMultiplier = 0.1;
glintingBladeManaCost = 0.6;
glintingBladeStaminaCost = 0;
glintingBladeManaRegen = 0;
glintingBladeStaminaRegen = 0.1;
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
hellishLandscapeManaCostMultiplier = 0.6;
hellishLandscapeStaminaCostMultiplier = 0;
hellishLandscapeManaRegenMultiplier = 0;
hellishLandscapeStaminaRegenMultiplier = 0.1;
hellishLandscapeManaCost = 0.6;
hellishLandscapeStaminaCost = 0;
hellishLandscapeManaRegen = 0;
hellishLandscapeStaminaRegen = 0.1;
hellishLandscapeDamage = 75;
hellishLandscapeStunDuration = room_speed * 3;
hellishLandscapeTargetX = 0;
hellishLandscapeTargetY = 0;
#endregion

#region Tier 3
/// Hidden Dagger
hiddenDaggerManaCostMultiplier = 0;
hiddenDaggerStaminaCostMultiplier = 0.3;
hiddenDaggerManaRegenMultiplier = 0.2;
hiddenDaggerStaminaRegenMultiplier = 0;
hiddenDaggerManaCost = 0;
hiddenDaggerStaminaCost = 0.3;
hiddenDaggerManaRegen = 0.2;
hiddenDaggerStaminaRegen = 0;
hiddenDaggerDamage = 50;
hiddenDaggerCanBeRefreshed = false;
hiddenDaggerTicTimerStartTime = room_speed * 2;
hiddenDaggerStunDuration = room_speed * 2;
hiddenDaggerBaseDamageMultiplier = 2;
hiddenDaggerDamageMultiplierTimerStartTime = hiddenDaggerStunDuration;

/// All Out Attack
allOutAttackManaCostMultiplier = 0;
allOutAttackStaminaCostMultiplier = 0.3;
allOutAttackManaRegenMultiplier = 0.2;
allOutAttackStaminaRegenMultiplier = 0;
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
exploitWeaknessManaCostMultiplier = 0.3;
exploitWeaknessStaminaCostMultiplier = 0;
exploitWeaknessManaRegenMultiplier = 0;
exploitWeaknessStaminaRegenMultiplier = 0.2;
exploitWeaknessManaCost = 0.3;
exploitWeaknessStaminaCost = 0;
exploitWeaknessManaRegen = 0;
exploitWeaknessStaminaRegen = 0.2;
exploitWeaknessDamage = 25;
exploitWeaknessDoTDamage = 0;
exploitWeaknessPercentOfDamageToAdd = 0.125;
exploitWeaknessCanBeRefreshed = true;
exploitWeaknessTicTimerStartTime = room_speed * 0.5;
exploitWeaknessTimerStartTime = room_speed * 6;

/// Purifying Rage
purifyingRageManaCostMultiplier = 0.3;
purifyingRageStaminaCostMultiplier = 0;
purifyingRageManaRegenMultiplier = 0;
purifyingRageStaminaRegenMultiplier = 0.2;
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
rushdownManaCostMultiplier = 0;
rushdownStaminaCostMultiplier = 0;
rushdownManaRegenMultiplier = 0;
rushdownStaminaRegenMultiplier = 0.3;
rushdownManaCost = 0;
rushdownStaminaCost = 0;
rushdownManaRegen = 0;
rushdownStaminaRegen = 0.3;
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
diabolusBlastManaCostMultiplier = 0;
diabolusBlastStaminaCostMultiplier = 0;
diabolusBlastManaRegenMultiplier = 0.3;
diabolusBlastStaminaRegenMultiplier = 0;
diabolusBlastManaCost = 0;
diabolusBlastStaminaCost = 0;
diabolusBlastManaRegen = 0.3;
diabolusBlastStaminaRegen = 0;
diabolusBlastBaseDamage = 25;
diabolusBlastMaxRange = 32 * 4;
diabolusBlastMaxExtraDamage = 50;
#endregion
#endregion

#region Caelestus Magic
#region Tier 1
/// True Caelesti Wings
trueCaelestiWingsManaCostMultiplier = 0;
trueCaelestiWingsStaminaCostMultiplier = 0.9;
trueCaelestiWingsManaRegenMultiplier = 0;
trueCaelestiWingsStaminaRegenMultiplier = 0;
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
bindingsOfTheCaelestiManaCostMultiplier = 0.6;
bindingsOfTheCaelestiStaminaCostMultiplier = 0;
bindingsOfTheCaelestiManaRegenMultiplier = 0;
bindingsOfTheCaelestiStaminaRegenMultiplier = 0.1;
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
armorOfTheCaelestiManaCostMultiplier = 0;
armorOfTheCaelestiStaminaCostMultiplier = 0.6;
armorOfTheCaelestiManaRegenMultiplier = 0.1;
armorOfTheCaelestiStaminaRegenMultiplier = 0;
armorOfTheCaelestiManaCost = 0;
armorOfTheCaelestiStaminaCost = 0.6;
armorOfTheCaelestiManaRegen = 0.1;
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
holyDefenseManaCostMultiplier = 0;
holyDefenseStaminaCostMultiplier = 0.3;
holyDefenseManaRegenMultiplier = 0.2;
holyDefenseStaminaRegenMultiplier = 0;
holyDefenseManaCost = 0;
holyDefenseStaminaCost = 0.3;
holyDefenseManaRegen = 0.2;
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
wrathOfTheRepentantManaCostMultiplier = 0.3;
wrathOfTheRepentantStaminaCostMultiplier = 0;
wrathOfTheRepentantManaRegenMultiplier = 0;
wrathOfTheRepentantStaminaRegenMultiplier = 0.2;
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
theOnePowerManaCostMultiplier = 0.3;
theOnePowerStaminaCostMultiplier = 0;
theOnePowerManaRegenMultiplier = 0;
theOnePowerStaminaRegenMultiplier = 0.2;
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
theOnePowerDamage = 25;
theOnePowerTicTimer = -1;
theOnePowerTicTimerStartTime = room_speed * 1.5;
theOnePowerTimer = -1;
theOnePowerTimerStartTime = room_speed * 30;

/// Lightning Spear
lightningSpearManaCostMultiplier = 0;
lightningSpearStaminaCostMultiplier = 0.3;
lightningSpearManaRegenMultiplier = 0.2;
lightningSpearStaminaRegenMultiplier = 0;
lightningSpearManaCost = 0;
lightningSpearStaminaCost = 0.3;
lightningSpearManaRegen = 0.2;
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
angelicBarrageManaCostMultiplier = 0;
angelicBarrageStaminaCostMultiplier = 0;
angelicBarrageManaRegenMultiplier = 0.3;
angelicBarrageStaminaRegenMultiplier = 0;
angelicBarrageManaCost = 0;
angelicBarrageStaminaCost = 0;
angelicBarrageManaRegen = 0.3;
angelicBarrageStaminaRegen = 0;
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
whirlwindManaCostMultiplier = 0;
whirlwindStaminaCostMultiplier = 0;
whirlwindManaRegenMultiplier = 0;
whirlwindStaminaRegenMultiplier = 0.3;
whirlwindManaCost = 0;
whirlwindStaminaCost = 0;
whirlwindManaRegen = 0;
whirlwindStaminaRegen = 0.3;
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


