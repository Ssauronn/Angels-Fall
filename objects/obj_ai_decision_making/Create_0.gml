/// @description AI Decision Making Variables
globalvar objectIDsInBattle, objectIDsFollowingPlayer, lastEnemyHitByPlayer, lastEnemyHitByMinion, enemyHealersInBattle, enemyTanksInBattle, enemyMeleeDPSInBattle, enemyRangedDPSInBattle, friendlyHealersInBattle, friendlyTanksInBattle, friendlyMeleeDPSInBattle, friendlyRangedDPSInBattle;
objectIDsInBattle = noone;
objectIDsFollowingPlayer = noone;
lastEnemyHitByPlayer = noone;
lastEnemyHitByMinion = noone;
enemyHealersInBattle = 0;
enemyTanksInBattle = 0;
enemyMeleeDPSInBattle = 0;
enemyRangedDPSInBattle = 0;
friendlyHealersInBattle = 0;
friendlyTanksInBattle = 0;
friendlyMeleeDPSInBattle = 0;
friendlyRangedDPSInBattle = 0;

#region FOCUS TARGET ENGINE
// Player Attack Pattern - will get up to double attackPatternStartWeight the more melee abilities are used, and down to 0 the more ranged abilities are used
// -Universal
objectProximityToTargetForTargetingPurposesStartWeight = 0.456;
attackPatternStartWeight = 0.08;
potentialTargetsCurrentHPStartWeight = 0.264;
// This weight changes based on the object itself's archetype
targetOfTargetFocusIsDifferentArchetypesForTargetingPurposesStartWeight = 0.2;
// -Player Specifics
numberOfPlayerAttacksToTrack = 20;
playerAttackPatternWeight = attackPatternStartWeight;
#endregion
#region	FOR HEALERS ONLY - HEAL TARGET ENGINE
potentialHealTargetsCurrentHPStartWeight = 0.575;
potentialHealTargetsAreDifferentArchetypesStartWeight = 0.225;
potentialTargetsMaximumDistanceToBeConsideredAdjacentToSpecificPotentialHealTarget = camera_get_view_width(view_camera[0]) / 5;
idealAmountOfTotalPotentialHealTargetsAdjacentToSpecificPotentialHealTarget = 2.875;
potentialHealTargetsAdjacentAlliesStartWeight = 0.175;
idealAmountOfTotalPotentialEnemyTargetsAdjacentToSpecificPotentialHealTarget = 2.875;
potentialHealTargetsAdjacentEnemiesStartWeight = 0.275;
#endregion

#region Heavy Melee Engine
selfCurrentHPPercentForHeavyMeleeEngineStartWeight = 0.15;
targetCurrentPercentageOfStaminaAndManaForHeavyMeleeEngineStartWeight = 0.05;
targetOfTargetCurrentHPForHeavyMeleeEngineStartWeight = 0.15;
objectProximityToTargetForHeavyMeleeEngineStartWeight = 0.3;
percentageOfDamageToTargetTotalHPForHeavyMeleeEngineStartWeight = 0.2;
// This one line below is the variable to set the ideal amount of allies in battle for each object, not including itself
idealAmountOfTotalEnemiesInBattleForHeavyMeleeEngine = 5;
totalEnemiesInBattleForHeavyMeleeEngineStartWeight = 0.15;
#endregion
#region Light Melee Engine
selfCurrentHPPercentForLightMeleeEngineStartWeight = 0.15;
targetCurrentPercentageOfStaminaAndManaForLightMeleeEngineStartWeight = 0.05;
targetOfTargetCurrentHPForLightMeleeEngineStartWeight = 0.15;
objectProximityToTargetForLightMeleeEngineStartWeight = 0.3;
percentageOfDamageToTargetCurrentHPForLightMeleeEngineStartWeight = 0.2;
// This one line below is the variable to set the ideal amount of allies in battle for each object, not including itself
idealAmountOfTotalEnemiesInBattleForLightMeleeEngine = 5;
totalEnemiesInBattleForLightMeleeEngineStartWeight = 0.15;
#endregion
#region Heavy Ranged Engine
targetCurrentHPPercentForHeavyRangedEngineStartWeight = 0.15;
targetOfTargetFocusIsDifferentArchetypesForHeavyRangedEngineStartWeight = 0.1;
selfCurrentHPPercentForHeavyRangedEngineStartWeight = 0.15;
objectProximityToTargetForHeavyRangedEngineStartWeight = 0.3;
// This one line below is the variable to set the ideal amount of allies in battle for each object, not including itself
idealAmountOfTotalEnemiesInBattleForHeavyRangedEngine = 5;
totalEnemiesInBattleForHeavyRangedEngineStartWeight = 0.05;
percentageOfDamageToTargetTotalHPForHeavyRangedEngineStartWeight = 0.25;
#endregion
#region Light Ranged Engine
targetCurrentHPPercentForLightRangedEngineStartWeight = 0.15;
targetOfTargetFocusIsDifferentArchetypesForLightRangedEngineStartWeight = 0.1;
selfCurrentHPPercentForLightRangedEngineStartWeight = 0.15;
objectProximityToTargetForLightRangedEngineStartWeight = 0.3;
// This one line below is the variable to set the ideal amount of allies in battle for each object, not including itself
idealAmountOfTotalEnemiesInBattleForLightRangedEngine = 5;
totalEnemiesInBattleForLightRangedEngineStartWeight = 0.05;
percentageOfDamageToTargetCurrentHPForLightRangedEngineStartWeight = 0.25;
#endregion
#region FOR HEALERS ONLY - Heal Ally
/*
I essentially need to determine a heal target, and then determine a heal weight off of that, and then compare it against all the other weights
Create another target variable, on top of currentTargetToFocus, called currentTargetToHeal
This variable is determined all within the targeting section in the step event, but only if the objectArchetype == "Healer"
Then, in the engine weight setting section, determine what the weight for healing the currentTargetToHeal would be, but again, only if objectArchetype == "Healer"
Lastly, the actions are executed like normal, but now if the objectArchetype == "Healer", the object also takes the Heal Ally Engine into account
tl;dr - if the object is a healer, a secondary target variable is set, and a Heal Ally Engine is also set, and if that engine has the highest weight, it executes a healing move on the
currentTargetToHeal.
*/
cumulativeCurrentHPPercentOfAllRemainingAlliesForHealAllyEngineStartWeight = 0.25;
archetypeOfCurrentLowestHPAllyForHealAllyEngineStartWeight = 0.15;
currentHPPercentOfLowestHPAllyForHealAllyEngineStartWeight = 0.35;
targetCurrentHPPercentForHealAllyEngineStartWeight = 0.05;
idealAmountOfTotalEnemiesInBattleForHealAllyEngine = 5;
totalEnemiesInBattleForHealAllyEngineStartWeight = 0.15;
selfCurrentHPPercentForHealAllyEngineStartWeight = 0.05;
#endregion


