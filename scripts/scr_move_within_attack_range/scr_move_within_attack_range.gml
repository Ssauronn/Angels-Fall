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
if point_distance(x, y, target_.x, target_.y) <=  (distance_ * 1.2) {
	pathEndXGoal = target_.x + lengthdir_x(distance_, point_direction(target_.x, target_.y, pathStartX, pathStartY));
	pathEndYGoal = target_.y + lengthdir_y(distance_, point_direction(target_.x, target_.y, pathStartX, pathStartY));
}
else {
	pathEndXGoal = target_.x;
	pathEndYGoal = target_.y;
}

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
				mp_grid_add_instances(roomMovementGrid, obj_wall, false);
				mp_grid_path(roomMovementGrid, myPath, x, y, pathEndXGoal, pathEndYGoal, true);
			}
			if pathPos == path_get_number(myPath) {
				if point_distance(x, y, target_.x, target_.y) > distance_ {
					enemyGroundHurtbox.solid = false;
					mp_potential_step(pathEndXGoal, pathEndYGoal, maxSpeed, false);
					enemyGroundHurtbox.solid = true;
				}
			}
			else {
				if (x == pathNextXPos) && (y == pathNextYPos) {
					if !((pathPos + 1) > path_get_number(myPath)) {
						pathPos++;
					}
				}
				pathNextXPos = path_get_point_x(myPath, pathPos);
				pathNextYPos = path_get_point_y(myPath, pathPos);
				enemyGroundHurtbox.solid = false;
				//mp_potential_step(pathEndXGoal, pathEndYGoal, maxSpeed, false);
				mp_potential_step(pathNextXPos, pathNextYPos, maxSpeed, false);
				enemyGroundHurtbox.solid = true;
			}
			//path_start(myPath, maxSpeed, path_action_stop, 1)
		}
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
			pathPos = 0;
		}
		
	}
}
else {
	
}


