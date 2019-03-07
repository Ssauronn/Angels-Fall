///@description Move within attack range
var distance_ = 0;
var target_ = noone;
var object_self_ = self;
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
if target_.object_index == obj_player {
	target_ = target_.playerGroundHurtbox;
}
else {
	target_ = target_.enemyGroundHurtbox;
}
groundHurtboxX = enemyGroundHurtbox.x;
groundHurtboxY = enemyGroundHurtbox.y;

// Commented out code is kept because its a nifty little trick to set target equal to whatever point
// is at tether distance directly between object and target - might be useful later
//if point_distance(x, y, target_.x, target_.y) <=  (distance_ * 1.2) {
	//pathEndXGoal = target_.x + lengthdir_x(distance_, point_direction(target_.x, target_.y, groundHurtboxX, groundHurtboxY));
	//pathEndYGoal = target_.y + lengthdir_y(distance_, point_direction(target_.x, target_.y, groundHurtboxX, groundHurtboxY));
//}
//else {
	pathEndXGoal = target_.x;
	pathEndYGoal = target_.y;
//}

if chosenEngine != "Heal Ally" {
	if instance_exists(currentTargetToFocus) {
		/*
		CODE BELOW NEEDS TO BE EDITED TO WORK INSTEAD WITH move_movement_entity (needs to be adapted) SCRIPT 
		USING add_movement SCRIPT (already adapted)
		*/
		if point_distance(groundHurtboxX, groundHurtboxY, target_.x, target_.y) > distance_ {
			
			/*
			call add_movement, after doing so evaluate point_distance to pathEndGoal, if point distance
			plus currentSpeed is still greater than distance_ then do nothing, otherwise destroy myPath
			to prevent a memory leak, set it equal to undefined again, and set pathCreated = false;
			*/
			
			if !pathCreated {
				pathCreated = true;
				myPath = path_add();
				path_set_kind(myPath, 1);
				path_set_precision(myPath, 8);
				mp_grid_add_instances(roomMovementGrid, obj_wall, false);
			}
			with enemyGroundHurtbox {
				mp_grid_path(roomMovementGrid, object_self_.myPath, object_self_.x, object_self_.y, object_self_.pathEndXGoal, object_self_.pathEndYGoal, true);
				if object_self_.pathPos == path_get_number(object_self_.myPath) {
					if point_distance(x, y, target_.x, target_.y) > distance_ {
						solid = false;
						with object_self_ {
							mp_potential_step(pathEndXGoal, pathEndYGoal, maxSpeed, false);
						}
						solid = true;
					}
				}
				else {
					if (x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
						if !((object_self_.pathPos + 1) > path_get_number(object_self_.myPath)) {
							object_self_.pathPos++;
						}
					}
					object_self_.pathNextXPos = path_get_point_x(object_self_.myPath, object_self_.pathPos);
					object_self_.pathNextYPos = path_get_point_y(object_self_.myPath, object_self_.pathPos);
					solid = false;
					with object_self_ {
						mp_potential_step(pathNextXPos, pathNextYPos, maxSpeed, false);
					}
					solid = true;
				}
			}
		}
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
			pathPos = 1;
			pathCreated = false;
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
		
	}
}
else {
	
}


