///@description Move within attack range
var distance_ = 64;
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
		if point_distance(pathStartX, pathStartY, target_.x, target_.y) > distance_ {
			
			/*
			call add_movement, after doing so evaluate point_distance to pathEndGoal, if point distance
			plus currentSpeed is still greater than distance_ then do nothing, otherwise destroy myPath
			to prevent a memory leak, set it equal to undefined again, and set pathCreated = false;
			*/
			
			//old code
			if !pathCreated {
				myPath = path_add();
				path_set_kind(myPath, 1);
				path_set_precision(myPath, 8);
				mp_grid_path(roomMovementGrid, myPath, x, y, pathEndXGoal, pathEndYGoal, true);
			}
			//path_start(myPath, 3, path_action_stop, true);
			enemyGroundHurtbox.solid = false;
			mp_potential_step(pathEndXGoal, pathEndYGoal, 3, false);
			enemyGroundHurtbox.solid = true;
		}
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
		}
		
	}
}
else {
	
}


