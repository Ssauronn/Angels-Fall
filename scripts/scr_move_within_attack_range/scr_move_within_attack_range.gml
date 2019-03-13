///@description Move within attack range
var distance_, target_, object_self_, melee_distance_multiplier_, ranged_distance_multiplier_, heal_distance_multiplier_;
distance_ = 0;
target_ = noone;
object_self_ = self;
/*
The 3 local variables set below are to decide how far closer to move to the object than the base
range itself - this means that the enemy will move closer than it needs to for attacks which will
avoid instances where the enemy is set just inside the max range for an attack, and then the target
moves 1 pixel away and the entire attack wiffs
*/
melee_distance_multiplier_ = 0.75;
ranged_distance_multiplier_ = 0.5;
heal_distance_multiplier_ = 0.5;

switch (chosenEngine) {
	case "Light Melee": distance_ = (enemyLightMeleeAttackRange  * melee_distance_multiplier_);
		target_ = currentTargetToFocus;
		break;
	case "Heavy Melee": distance_ = (enemyHeavyMeleeAttackRange * melee_distance_multiplier_);
		target_ = currentTargetToFocus;
		break;
	case "Light Ranged": distance_ = (enemyLightRangedAttackRange * ranged_distance_multiplier_);
		target_ = currentTargetToFocus;
		break;
	case "Heavy Ranged": distance_ = (enemyHeavyRangedAttackRange * ranged_distance_multiplier_);
		target_ = currentTargetToFocus;
		break;
	case "Heal Ally": distance_ = (enemyHealAllyRange * heal_distance_multiplier_);
		target_ = currentTargetToHeal;
		break;
}
// If the instance exists, set local variable target_ equal to the instance's target. Otherwise, if its
// target doesn't exist, reset variables, as we obviously don't want to chase a non-existant thing.
if instance_exists(target_) {
	// These variables are created before the path itself is created
	if target_.object_index == obj_player {
		target_ = target_.playerGroundHurtbox;
	}
	else {
		target_ = target_.enemyGroundHurtbox;
	}
}
else {
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChaseTimer = 0;
	alreadyTriedToChase = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	exit;
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


#region If the object isn't trying to get in range of a friendly object to heal an ally
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
							mp_potential_step(pathEndXGoal, pathEndYGoal, currentSpeed, false);
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
						mp_potential_step(pathNextXPos, pathNextYPos, currentSpeed, false);
					}
					solid = true;
				}
			}
		}
		// Else if we are within the correct range, revert to idle
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
			// Path variables being reset
			pathPos = 1;
			pathCreated = false;
			if path_exists(myPath) {
				path_delete(myPath);
			}
			// Reset the state variables, and set alreadyTriedToChase = true
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
		}
	}
	// Else if the currentTargetToFocus doesn't exist, revert to idle
	else {
		// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
		// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
		// Path variables being reset
		pathPos = 1;
		pathCreated = false;
		if path_exists(myPath) {
			path_delete(myPath);
		}
		// Reset the state variables, and set alreadyTriedToChase = true
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
	}
}
#endregion
#region If the object is trying to get in range of a friendly object to heal an ally
if chosenEngine == "Heal Ally" {
	if instance_exists(currentTargetToHeal) {
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
							mp_potential_step(pathEndXGoal, pathEndYGoal, currentSpeed, false);
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
						mp_potential_step(pathNextXPos, pathNextYPos, currentSpeed, false);
					}
					solid = true;
				}
			}
		}
		// Else if we are within correct range, revert to idle
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
			pathPos = 1;
			pathCreated = false;
			if path_exists(myPath) {
				path_delete(myPath);
			}
			// Reset the state variables, and set alreadyTriedToChase = true
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
		}
	}
	// Else if the currentTargetToHeal doesn't exist, revert to idle
	else {
		// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
		// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
		// Path variables being reset
		pathPos = 1;
		pathCreated = false;
		if path_exists(myPath) {
			path_delete(myPath);
		}
		// Reset the state variables, and set alreadyTriedToChase = true
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
	}
}
#endregion


// If the timer for alreadyTriedToChase (alreadyTriedToChaseTimer) hits 0, that means that the enemy
// has already tried to chase for the max amount of time, and we need to move onto a different attack.
if alreadyTriedToChaseTimer <= 0 {
	// Reset path variables
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
	// Reset the state variables, and set alreadyTriedToChase = true
	alreadyTriedToChase = true;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
}


