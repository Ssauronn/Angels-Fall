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
ranged_distance_multiplier_ = 0.75;
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
// If the instance exists, set local variable target_ equal to the instance's target.
if instance_exists(target_) {
	// These variables are created before the path itself is created
	if target_.id == obj_player.id {
		target_ = target_.playerGroundHurtbox;
	}
	else {
		target_ = target_.enemyGroundHurtbox;
	}
	
	var target_x_, target_y_;
	target_x_ = target_.x;
	target_y_ = target_.y;
	// Commented out code is kept because its a nifty little trick to set target equal to whatever point
	// is at tether distance directly between object and target - might be useful later
	//if point_distance(x, y, target_.x, target_.y) <=  (distance_ * 1.2) {
		//pathEndXGoal = target_.x + lengthdir_x(distance_, point_direction(target_.x, target_.y, groundHurtboxX, groundHurtboxY));
		//pathEndYGoal = target_.y + lengthdir_y(distance_, point_direction(target_.x, target_.y, groundHurtboxX, groundHurtboxY));
	//}
	//else {
	pathEndXGoal = target_x_;
	pathEndYGoal = target_y_;
	//}
}
// Else if the target doesn't exist, and there is no point to move to, then just revert back to idle
else if (xPointToMoveTo == -1) && (yPointToMoveTo == -1) {
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

// If the enemy needs to move within line of sight, determined by scr_line_of_sight_exists state,
// then move the enemy instead towards the target location.
if (xPointToMoveTo != -1) && (yPointToMoveTo != -1) {
	distance_ = maxSpeed * 3;
	pathEndXGoal = xPointToMoveTo;
	pathEndYGoal = yPointToMoveTo;
	var target_x_, target_y_;
	target_x_ = xPointToMoveTo;
	target_y_ = yPointToMoveTo;
}


#region If the object isn't trying to get in range of a friendly object to heal an ally
if chosenEngine != "Heal Ally" {
	// If some sort of point to move to exists
	if (instance_exists(currentTargetToFocus)) || ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
		// If the point to move to is a point that will give the enemy line of sight, but line of sight
		// is found prematurely, then exit the script because the enemy has accomplished the goal even 
		// though the enemy hasn't yet reached its target.
		if (instance_exists(currentTargetToFocus)) && ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
			if !collision_line(x, y, target_x_, target_y_, obj_wall, true, true) {
				// I set a small timer, so that the enemy continues along its chosen path slightly longer
				// before stopping to attack. This is so that the enemy can move far enough to be within
				// line of sight and out of the way of any walls that may just barely clip the enemy
				// attacks.
				// If the default timer value was at -1, then set the new timer
				if pointToMoveToTimer < 0 {
					pointToMoveToTimer = room_speed * 0.25;
				}
			}
		}
		if point_distance(groundHurtboxX, groundHurtboxY, target_x_, target_y_) > distance_ {
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
					with object_self_ {
						if instance_exists(currentTargetToFocus) {
							scr_line_of_sight_exists(currentTargetToFocus, obj_wall);
						}
					}
					if point_distance(object_self_.x, object_self_.y, target_x_, target_y_) > distance_ {
						solid = false;
						with object_self_ {
							mp_potential_step(pathEndXGoal, pathEndYGoal, currentSpeed, false);
						}
						solid = true;
					}
				}
				else {
					if point_distance(object_self_.x, object_self_.y, object_self_.pathNextXPos, object_self_.pathNextYPos) <= (object_self_.maxSpeed * 4) { //(x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
						with object_self_ {
							if instance_exists(currentTargetToFocus) {
								scr_line_of_sight_exists(currentTargetToFocus, obj_wall);
							}
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
		// Else if I'm within the correct range, revert to idle
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
			xPointToMoveTo = -1;
			yPointToMoveTo = -1;
			exit;
		}
	}
	// Else if the currentTargetToFocus doesn't exist, and there's no target point to move to, 
	// revert to idle.
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
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		exit;
	}
}
#endregion
#region If the object is trying to get in range of a friendly object to heal an ally
if chosenEngine == "Heal Ally" {
	if (instance_exists(currentTargetToHeal)) || ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
		// If the point to move to is a point that will give the enemy line of sight, but line of sight
		// is found prematurely, then exit the script because the enemy has accomplished the goal even 
		// though the enemy hasn't yet reached its target.
		if (instance_exists(currentTargetToHeal)) && ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
			if !collision_line(x, y, target_x_, target_y_, obj_wall, true, true) {
				// I set a small timer, so that the enemy continues along its chosen path slightly longer
				// before stopping to attack. This is so that the enemy can move far enough to be within
				// line of sight and out of the way of any walls that may just barely clip the enemy
				// attacks.
				// If the default timer value was at -1, then set the new timer
				if pointToMoveToTimer < 0 {
					pointToMoveToTimer = room_speed * 0.25;
				}
			}
		}
		if point_distance(groundHurtboxX, groundHurtboxY, target_x_, target_y_) > distance_ {
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
					with object_self_ {
						if instance_exists(currentTargetToHeal) {
							scr_line_of_sight_exists(currentTargetToHeal, obj_wall);
						}
					}
					if point_distance(object_self_.x, object_self_.y, target_x_, target_y_) > distance_ {
						solid = false;
						with object_self_ {
							mp_potential_step(pathEndXGoal, pathEndYGoal, currentSpeed, false);
						}
						solid = true;
					}
				}
				else {
					if point_distance(object_self_.x, object_self_.y, object_self_.pathNextXPos, object_self_.pathNextYPos) <= (object_self_.maxSpeed * 4) { //(x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
						with object_self_ {
							if instance_exists(currentTargetToHeal) {
								scr_line_of_sight_exists(currentTargetToHeal, obj_wall);
							}
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
		// Else if I'm within correct range, revert to idle
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing.
			pathPos = 1;
			pathCreated = false;
			if path_exists(myPath) {
				path_delete(myPath);
			}
			// Reset the state variables
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
			xPointToMoveTo = -1;
			yPointToMoveTo = -1;
			exit;
		}
	}
	// Else if the currentTargetToHeal doesn't exist, and there's no target spot to move to, 
	// revert to idle
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
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		exit;
	}
}
#endregion

if (!instance_exists(currentTargetToFocus)) && (x == xPointToMoveTo) && (y == yPointToMoveTo) {
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	exit;
}

// If the timer is at or above 0, then reduce the value of the timer by 1. Then, if
// after reducing that value, the timer is below 0, that means the timer has run out and
// I can now stop the enemy from moving.
// This timer is set if the enemy is specifically trying to move within line of sight,
// and has reached its target.
if pointToMoveToTimer >= 0 {
	pointToMoveToTimer--;
	if pointToMoveToTimer < 0 {
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
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		exit;
	}
}

if point_distance(groundHurtboxX, groundHurtboxY, target_x_, target_y_) < distance_ {
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	exit;
}

// If the timer for alreadyTriedToChase (alreadyTriedToChaseTimer) hits 0, that means that the enemy
// has already tried to chase for the max amount of time, and I need to move onto a different attack.
// I don't exit the script and change to idle if the object is chasing a point to move to however,
// because there isn't a timer set for the point to move to.
if (alreadyTriedToChaseTimer <= 0) && ((xPointToMoveTo == -1) && (yPointToMoveTo == -1)) {
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
	exit;
}

// If the object is stunned, immediately send this object to the stun script
if stunActive {
	enemyState = enemystates.stunned;
	enemyStateSprite = enemystates.stunned;
	enemyImageIndex = 0;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	// Path variables resetting and destroying the path to prevent memory leak
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
}

if forceReturnToIdleState {
	forceReturnToIdleState = false;
	currentTargetToFocus = noone;
	currentTargetToHeal = noone;
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	exit;
}


