///@description Move within attack range
var distance_ = 0;
var target_ = noone;
switch (chosenEngine) {
	case "Light Melee": distance_ = enemyLightMeleeAttackRange;
		target_ = currentTargetToFocus;
		break;
	case "Heavy Melee": distance_ = enemyHeavyMeleeAttackRange;
		target_ = currentTargetToFocus;
		break;
	case "Light Ranged": distance_ = enemyLightRangedAttackRange;
		target_ = currentTargetToFocus;
		break;
	case "Heavy Ranged": distance_ = enemyHeavyRangedAttackRange;
		target_ = currentTargetToFocus;
		break;
	case "Heal Ally": distance_ = enemyHealAllyRange;
		target_ = currentTargetToHeal;
		break;
}
// These variables are created before the path itself is created
pathStartX = x;
pathStartY = y;
pathEndXGoal = target_.x + lengthdir_x(distance_, point_direction(target_.x, target_.y, pathStartX, pathStartY));
pathEndYGoal = target_.y + lengthdir_y(distance_, point_direction(target_.x, target_.y, pathStartX, pathStartY));

if weightAtWhichEnemyIsCurrentlyFocusingTargetAt >= weightAtWhichEnemyIsCurrentlyFocusingHealTargetAt {
	if instance_exists(currentTargetToFocus) {
		/*
		CODE BELOW NEEDS TO BE EDITED TO WORK INSTEAD WITH move_movement_entity (needs to be adapted) SCRIPT 
		USING add_movement SCRIPT (already adapted)
		*/
		if point_distance(pathStartX, pathStartY, pathEndXGoal, pathEndYGoal) > distance_ {
			if !pathCreated {
				myPath = path_add();
				pathCreated = true;
				if !mp_grid_path(roomMovementGrid, myPath, pathStartX, pathStartY, pathEndXGoal, pathEndYGoal, distance_) {
					// Set chosenEngine = "Light Ranged", reset other variables, set alreadyTriedToChase
					// equal to true, and reset timer for chasing
				}
				else {
					path_set_kind(myPath, 1);
					path_set_precision(myPath, 8);
				}
			}
			/*
			call add_movement, after doing so evaluate point_distance to pathEndGoal, if point distance
			plus currentSpeed is still greater than distance_ then do nothing, otherwise destroy myPath
			to prevent a memory leak, set it equal to undefined again, and set patchCreated = false;
			*/
			/*
			//old code
			myPath = path_add();
			path_set_kind(myPath, 1);
			path_set_precision(myPath, 8);
			mp_grid_path(roomMovementGrid, myPath, x, y, currentTargetToFocus.x - 32, currentTargetToFocus.y - 32, true);
			path_start(myPath, 3, path_action_stop, true);
			*/
		}
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
		}
		
	}
}
else {
	
}


