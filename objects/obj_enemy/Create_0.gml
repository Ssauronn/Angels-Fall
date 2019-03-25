/// @description Create Varialbes

#region ENGINE VARIABLES TO CONTROL EACH INDIVIDUAL ENEMY
// Variable used to control when the specific enemy calls scr_ai_decisions to set a course of
// action.
decisionMadeForTargetAndAction = false;

#region TARGETING ENGINE
// Archetype for one of each object. "Healer", "Tank", "Ranged DPS", and "Melee DPS".
objectArchetype = "Ranged DPS";
// Combat status set based on what the relationship of the object is to the player. Possible
// statuses are: "Enemy", "Minion", and "NPC". "Player" status is reserved solely
// for the player object.
combatFriendlyStatus = "Enemy";
// Baseline is whatever obj_ai_decision_making attackPatternStartWeight is set to. The closer 
// the number gets to 0, the more the enemy prefers ranged spells and abilities. The closer 
// the number gets to double the baseline, the more the enemy prefers melee spells and abilities.
enemyAttackPatternWeight = 0;
attackPatternStartWeight = 0.4;
// The multiplierusedtoset targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight
// based on the object's archetype. This is set definitively in the step event and will make tanks
// and ranged dps focus targets who focus healers and tanks
targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeightObjectMultiplier = 1;
switch (objectArchetype) {
	case "Healer": enemyAttackPatternWeight = attackPatternStartWeight * (1 / 4);
		break;
	case "Tank": enemyAttackPatternWeight = attackPatternStartWeight * (3 / 2);
		break;
	case "Ranged DPS": enemyAttackPatternWeight = attackPatternStartWeight * (1 / 2);
		break;
	case "Melee DPS": enemyAttackPatternWeight = attackPatternStartWeight * (7 / 4);
		break;
}
// This sets the actual target I need to focus, and for healers, the target I need to heal
currentTargetToFocus = noone;
currentTargetToHeal = noone;
weightAtWhichEnemyIsCurrentlyFocusingTargetAt = 0;
weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt = 0;

// Tether ranges - normally standard
tetherXRange = camera_get_view_width(view_camera[0]) * 2;
tetherYRange = camera_get_view_height(view_camera[0]) * 2;

// Variable to determine if enemy was, or currently is, in combat
enemyInCombat = false;
enemyWasInCombat = false;
#endregion


#region VARIABLES USED BY ALL ACTION ENGINES
// Action chosen variable, set at the very end of scr_ai_decisions
chosenEngine = "";
// Variable used to stop endless chasing of target
alreadyTriedToChase = false;
// Variable used to count down how long to chase target
alreadyTriedToChaseTimer = 0;
// The percentage of this specific object's current HP compared to this object's max HP
selfCurrentHPPercent = 1;
targetCurrentPercentageOfStaminaAndMana = 0;
objectProximityToTarget = 0;
// The percentage each attack able to be dealt by this object will deal to the target's Current HP
percentageOfDamageToTargetCurrentHPHeavyMeleeAttackWillDeal = 0;
percentageOfDamageToTargetCurrentHPLightMeleeAttackWillDeal = 0;
percentageOfDamageToTargetCurrentHPHeavyRangedAttackWillDeal = 0;
percentageOfDamageToTargetCurrentHPLightRangedAttackWillDeal = 0;
// The percentage each attack able to be dealt by this object will deal to the target's Max HP
percentageOfDamageToTargetTotalHPHeavyMeleeAttackWillDeal = 0;
percentageOfDamageToTargetTotalHPLightMeleeAttackWillDeal = 0;
percentageOfDamageToTargetTotalHPHeavyRangedAttackWillDeal = 0;
percentageOfDamageToTargetTotalHPLightRangedAttackWillDeal = 0;
// The amount of allies that are in combat with this object. Different types and amounts of allies
// will warrant different behavior.
enemyTotalAlliesInBattle = 0;
minionTotalAlliesInBattle = 0;
// This is the HP of the target that this target is targeting. In other words, if this object is
// an enemy and it targets a minion, this references the target of that minion being targeted by
// this object. Its the "Target of Target".
targetOfTargetCurrentHP = -1;
#endregion

#region HEAVY MELEE ENGINE
// THIS variable determines the total weight at which the enemy will choose to execute heavy melee
heavyMeleeEngineWeightMultiplier = 1;
heavyMeleeEngineTotalWeight = heavyMeleeEngineWeightMultiplier;
// Set correctly every step of combat in obj_ai_decision_making
selfCurrentHPPercentForHeavyMeleeEngineTotalWeight = 0;
targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineTotalWeight = 0;
targetOfTargetCurrentHPForHeavyMeleeEngineTotalWeight = 0;
objectProximityToTargetForHeavyMeleeEngineTotalWeight = 0;
percentageOfDamageToTargetTotalHPForHeavyMeleeEngineTotalWeight = 0;
totalEnemiesInBattleForHeavyMeleeEngineTotalWeight = 0;
#endregion
#region LIGHT MELEE ENGINE
lightMeleeEngineWeightMultiplier = 1
lightMeleeEngineTotalWeight = lightMeleeEngineWeightMultiplier;
// Set correctly every step of combat in obj_ai_decision_making
selfCurrentHPPercentForLightMeleeEngineTotalWeight = 0;
targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineTotalWeight = 0;
targetOfTargetCurrentHPForLightMeleeEngineTotalWeight = 0;
objectProximityToTargetForLightMeleeEngineTotalWeight = 0;
percentageOfDamageToTargetCurrentHPForLightMeleeEngineTotalWeight = 0;
totalEnemiesInBattleForLightMeleeEngineTotalWeight = 0;
#endregion
#region HEAVY RANGED ENGINE
heavyRangedEngineWeightMultiplier = 1;
heavyRangedEngineTotalWeight = heavyRangedEngineWeightMultiplier;
targetCurrentHPPercentForHeavyRangedEngineTotalWeight = 0.1;
targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineTotalWeight = 0.2;
selfCurrentHPPercentForHeavyRangedEngineTotalWeight = 0.1;
objectProximityToTargetForHeavyRangedEngineTotalWeight = 0.35;
totalEnemiesInBattleForHeavyRangedEngineTotalWeight = 0.1;
percentageOfDamageToTargetTotalHPForHeavyRangedEngineTotalWeight = 0.15;
#endregion
#region LIGHT RANGED ENGINE
lightRangedEngineWeightMultiplier = 1;
lightRangedEngineTotalWeight = lightRangedEngineWeightMultiplier;
targetCurrentHPPercentForLightRangedEngineTotalWeight = 0.1;
targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineTotalWeight = 0.2;
selfCurrentHPPercentForLightRangedEngineTotalWeight = 0.1;
objectProximityToTargetForLightRangedEngineTotalWeight = 0.35;
totalEnemiesInBattleForLightRangedEngineTotalWeight = 0.1;
percentageOfDamageToTargetCurrentHPForLightRangedEngineTotalWeight = 0.15;
#endregion
#region RUN AWAY
runAwayEngineWeightMultiplier = 1;
runAwayEngineTotalWeight = runAwayEngineWeightMultiplier;
selfCurrentHPPercentForRunAwayEngineTotalWeight = 0.1;
objectProximityToTargetForRunAwayEngineTotalWeight = 0.2;
targetCurrentHPPercentForRunAwayEngineTotalWeight = 0.1;
targetIsDifferentArchetypesForRunAwayEngineTotalWeight = 0.3;
totalEnemiesInBattleForRunAwayEngineTotalWeight = 0.3;
#endregion
#region FOR HEALERS ONLY - HEAL ALLY
healAllyEngineWeightMultiplier = 1;
healAllyEngineTotalWeight = 0;
cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineTotalWeight = 0.25;
archetypeOfCurrentLowestHPAllyForHealAllyEngineTotalWeight = 0.25;
currentHPPercentOfLowestHPAllyForHealAllyEngineTotalWeight = 0.2;
targetCurrentHPPercentForHealAllyEngineTotalWeight = 0.05;
totalEnemiesInBattleForHealAllyEngineTotalWeight = 0.2;
selfCurrentHPPercentForHealAllyEngineTotalWeight = 0.05;
healAllyEngineTimerBaseTime = room_speed * 3;
healAllyEngineTimer = 0;
#endregion
#endregion

enemyStatsAndSpritesInitialized = false;
enemyName = "";

// State Machine Variables
enum enemystates {
	idle,
	passivelyFollowPlayer,
	moveWithinAttackRange,
	lightMeleeAttack,
	heavyMeleeAttack,
	lightRangedAttack,
	heavyRangedAttack,
	healAlly
}
enum enemydirection {
	right,
	up,
	left,
	down
}

enemyState = enemystates.idle;


