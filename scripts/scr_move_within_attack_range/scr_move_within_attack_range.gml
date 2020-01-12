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


var target_x_, target_y_;
// If the target instance exists, set local variable target_ equal to this instance's target.
if instance_exists(target_) {
	// These variables are created before the path itself is created
	if target_.id == obj_player.id {
		target_ = target_.playerGroundHurtbox;
	}
	else {
		target_ = target_.enemyGroundHurtbox;
	}
	target_x_ = target_.x;
	target_y_ = target_.y;
	pathEndXGoal = target_x_;
	pathEndYGoal = target_y_;
	pointToMoveToTimer = -1;
}
// If the enemy needs to move within line of sight, determined by scr_line_of_sight_exists state,
// then move the enemy towards the target location.
else if !lineOfSightExists {
	// The following section of code is inefficient, but I can't seem to find another way around it
	// without changing the way scr_line_of_sight_exists works, and right now it works perfectly for
	// every single other situation, so changing the whole script won't be worth it unless running
	// scr_ai_decisions ends up taking more processing power than I originally thought. Right now, it
	// only runs scr_ai_decisions when the AI is out of sight. And this makes it so that the AI always
	// chooses the shortest path to its target, and it also will never get stuck trying to walk around
	// enemies while within line of sight. Its a really good fix to a bunch of problems, but again, it
	// runs that complicated script and so it eats processing power while its going. I'll have to test
	// further later on.
	var path_exists_ = scr_path_exists_to_player_or_minions();
	if (path_exists_ || path_exists_ == noone) {
		scr_ai_decisions();
	}
	else {
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChaseTimer = 0;
		alreadyTriedToChase = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
	if ds_exists(objectIDsInBattle, ds_type_list) {
		if chosenEngine != "Heal Ally" {
			if currentTargetToFocus.id == obj_player.id {
				target_ = currentTargetToFocus.playerGroundHurtbox;
			}
			else {
				target_ = currentTargetToFocus.enemyGroundHurtbox;
			}
			target_x_ = target_.x;
			target_y_ = target_.y;
			scr_line_of_sight_exists(target_x_, target_y_, obj_wall);
		}
		else {
			if currentTargetToHeal.id == obj_player.id {
				target_ = currentTargetToHeal.playerGroundHurtbox;
			}
			else {
				target_ = currentTargetToHeal.enemyGroundHurtbox;
			}
			target_x_ = target_.x;
			target_y_ = target_.y;
			scr_line_of_sight_exists(target_x_, target_y_, obj_wall);
		}
	}
	else if combatFriendlyStatus == "Minion" {
		if (chosenEngine != "Heal Ally") || ((chosenEngine == "Heal Ally") && (!instance_exists(currentTargetToHeal))) {
			target_x_ = obj_player.x;
			target_y_ = obj_player.y;
			scr_line_of_sight_exists(target_x_, target_y_, obj_wall);
		}
		else {
			if instance_exists(currentTargetToHeal) {
				target_x_ = currentTargetToHeal.x;
				target_y_ = currentTargetToHeal.y;
				scr_line_of_sight_exists(target_x_, target_y_, obj_wall);
			}
		}
	}
	else {
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChaseTimer = 0;
		alreadyTriedToChase = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
	chosenEngine = "";
	distance_ = maxSpeed * 3;
	pathEndXGoal = xPointToMoveTo;
	pathEndYGoal = yPointToMoveTo;
	target_x_ = xPointToMoveTo;
	target_y_ = yPointToMoveTo;
	if !collision_line(enemyGroundHurtbox.x, enemyGroundHurtbox.y, xPointToMoveTo, yPointToMoveTo, obj_wall, true, true) {
		lineOfSightExists = true;
		if pointToMoveToTimer < 0 {
			pointToMoveToTimer = room_speed * 0.25;
		}
	}
}
// Else if the enemy is a minion, and it needs to move within tether range of player, move the minion
// towards the player location.
else if followingPlayer {
	if !ds_exists(objectIDsInBattle, ds_type_list) {
		// set in scr_enemy_idle - followingPlayerTarget, followingPlayerTargetX, and
		// followingPlayerTargetY are variables that choose a random location within
		// a circle around the player, and move to that location. This makes for enemies
		// that don't look stale, or follow you around in pre-determined ways.
		if instance_exists(followingPlayerTarget) {
			distance_ = tetherToPlayerOutOfCombatRange * 0.75;
			xPointToMoveTo = followingPlayerTarget.x;
			yPointToMoveTo = followingPlayerTarget.y;
		}
		else if (followingPlayerTargetX != -1) && (followingPlayerTargetY != -1) {
			distance_ = maxSpeed * 5;
			xPointToMoveTo = followingPlayerTargetX;
			yPointToMoveTo = followingPlayerTargetY;
		}
		pathEndXGoal = xPointToMoveTo;
		pathEndYGoal = yPointToMoveTo;
		target_x_ = xPointToMoveTo;
		target_y_ = yPointToMoveTo;
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
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
	if point_distance(x, y, target_x_, target_y_) > distance_ {
		pointToMoveToTimer = -1;
	}
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
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
	exit;
}
else {
	var path_exists_ = scr_path_exists_to_player_or_minions();
	if (path_exists_ || path_exists_ == noone) {
		scr_ai_decisions();
		distance_ = maxSpeed * 5;
		target_x_ = xPointToMoveTo;
		target_y_ = yPointToMoveTo;
		pathEndXGoal = xPointToMoveTo;
		pathEndYGoal = yPointToMoveTo;
		chosenEngine = "";
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
	}
	else {
		currentTargetToFocus = noone;
		currentTargetToHeal = noone;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChaseTimer = 0;
		alreadyTriedToChase = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
}

// Finally, set ground hurtbox locations
groundHurtboxX = enemyGroundHurtbox.x;
groundHurtboxY = enemyGroundHurtbox.y;



#region If the object isn't trying to get in range of a friendly object to heal an ally
if chosenEngine != "Heal Ally" {
	// If some sort of point to move to exists
	if (instance_exists(currentTargetToFocus)) || ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
		// If the point to move to is a point that will give the enemy line of sight, but line of sight
		// is found prematurely, then exit the script because the enemy has accomplished the goal even 
		// though the enemy hasn't yet reached its target.
		if (instance_exists(currentTargetToFocus)) && ((xPointToMoveTo != -1) && (yPointToMoveTo != -1)) {
			if !collision_line(groundHurtboxX, groundHurtboxY, target_x_, target_y_, obj_wall, true, true) {
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
			// As long as the object isn't a minion out of combat trying to move to the player, move
			// the object. Otherwise, check for a path.
			if ds_exists(objectIDsInBattle, ds_type_list) || ((!ds_exists(objectIDsInBattle, ds_type_list)) && (scr_path_exists_to_player_or_minions())) {
				if !pathCreated {
					pathCreated = true;
					myPath = path_add();
					path_set_kind(myPath, 1);
					path_set_precision(myPath, 8);
					mp_grid_add_instances(roomMovementGrid, obj_wall, false);
				}
				with enemyGroundHurtbox {
					mp_grid_path(roomMovementGrid, object_self_.myPath, object_self_.groundHurtboxX, object_self_.groundHurtboxY, object_self_.pathEndXGoal, object_self_.pathEndYGoal, true);
					if object_self_.pathPos == path_get_number(object_self_.myPath) {
						with object_self_ {
							if instance_exists(currentTargetToFocus) {
								var current_target_to_focus_ground_hurtbox_;
								if currentTargetToFocus.object_index == obj_player.object_index {
									current_target_to_focus_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
								}
								else {
									current_target_to_focus_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
								}
								scr_line_of_sight_exists(current_target_to_focus_ground_hurtbox_.x, current_target_to_focus_ground_hurtbox_.y, obj_wall);
							}
						}
						if point_distance(object_self_.groundHurtboxX, object_self_.groundHurtboxY, target_x_, target_y_) > distance_ {
							solid = false;
							// In this instance, I instead move the ground hurtbox first, and then move the
							// enemy object to match the ground hurtbox location. I do this so that I can move
							// the enemy objects more smoothly around obstacles.
							mp_potential_step(object_self_.pathEndXGoal, object_self_.pathEndYGoal, object_self_.currentSpeed, false);
							object_self_.x = x;
							object_self_.y = y - 13;
							solid = true;
						}
					}
					else {
						if point_distance(object_self_.groundHurtboxX, object_self_.groundHurtboxY, object_self_.pathNextXPos, object_self_.pathNextYPos) <= (object_self_.maxSpeed * 4) { //(x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
							with object_self_ {
								if instance_exists(currentTargetToFocus) {
									var current_target_to_focus_ground_hurtbox_;
									if currentTargetToFocus.object_index == obj_player.object_index {
										current_target_to_focus_ground_hurtbox_ = currentTargetToFocus.playerGroundHurtbox;
									}
									else {
										current_target_to_focus_ground_hurtbox_ = currentTargetToFocus.enemyGroundHurtbox;
									}
									scr_line_of_sight_exists(current_target_to_focus_ground_hurtbox_.x, current_target_to_focus_ground_hurtbox_.y, obj_wall);
								}
							}
						}
						if (x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
							if !((object_self_.pathPos + 1) > path_get_number(object_self_.myPath)) {
								object_self_.pathPos++;
							}
						}
						object_self_.pathNextXPos = path_get_point_x(object_self_.myPath, object_self_.pathPos);
						object_self_.pathNextYPos = path_get_point_y(object_self_.myPath, object_self_.pathPos);
						solid = false;
						// In this instance, I instead move the ground hurtbox first, and then move the
						// enemy object to match the ground hurtbox location. I do this so that I can move
						// the enemy objects more smoothly around obstacles.
						mp_potential_step(object_self_.pathNextXPos, object_self_.pathNextYPos, object_self_.currentSpeed, false);
						object_self_.x = x;
						object_self_.y = y - 13;
						solid = true;
					}
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
			if !is_undefined(myPath) {
				if path_exists(myPath) {
					path_delete(myPath);
				}
			}
			// Reset the state variables, and set alreadyTriedToChase = true
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
			xPointToMoveTo = -1;
			yPointToMoveTo = -1;
			lineOfSightExists = true;
			followingPlayer = false;
			followingPlayerTarget = noone;
			followingPlayerTargetX = -1;
			followingPlayerTargetY = -1;
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
		if !is_undefined(myPath) {
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
		// Reset the state variables, and set alreadyTriedToChase = true
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
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
			if !collision_line(enemyGroundHurtbox.x, enemyGroundHurtbox.y, target_x_, target_y_, obj_wall, true, true) {
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
							var current_target_to_heal_ground_hurtbox_;
							if currentTargetToHeal.object_index == obj_player.object_index {
								current_target_to_heal_ground_hurtbox_ = currentTargetToHeal.playerGroundHurtbox;
							}
							else {
								current_target_to_heal_ground_hurtbox_ = currentTargetToHeal.enemyGroundHurtbox;
							}
							scr_line_of_sight_exists(current_target_to_heal_ground_hurtbox_.x, current_target_to_heal_ground_hurtbox_.y, obj_wall);
						}
					}
					if point_distance(object_self_.x, object_self_.y, target_x_, target_y_) > distance_ {
						solid = false;
						// In this instance, I instead move the ground hurtbox first, and then move the
						// enemy object to match the ground hurtbox location. I do this so that I can move
						// the enemy objects more smoothly around obstacles.
						mp_potential_step(object_self_.pathEndXGoal, object_self_.pathEndYGoal, object_self_.currentSpeed, false);
						object_self_.x = x;
						object_self_.y = y - 13;
						solid = true;
					}
				}
				else {
					if point_distance(object_self_.x, object_self_.y, object_self_.pathNextXPos, object_self_.pathNextYPos) <= (object_self_.maxSpeed * 4) { //(x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
						with object_self_ {
							if instance_exists(currentTargetToHeal) {
								var current_target_to_heal_ground_hurtbox_;
								if currentTargetToHeal.object_index == obj_player.object_index {
									current_target_to_heal_ground_hurtbox_ = currentTargetToHeal.playerGroundHurtbox;
								}
								else {
									current_target_to_heal_ground_hurtbox_ = currentTargetToHeal.enemyGroundHurtbox;
								}
								scr_line_of_sight_exists(current_target_to_heal_ground_hurtbox_.x, current_target_to_heal_ground_hurtbox_.y, obj_wall);
							}
						}
					}
					if (x == object_self_.pathNextXPos) && (y == object_self_.pathNextYPos) {
						if !((object_self_.pathPos + 1) > path_get_number(object_self_.myPath)) {
							object_self_.pathPos++;
						}
					}
					object_self_.pathNextXPos = path_get_point_x(object_self_.myPath, object_self_.pathPos);
					object_self_.pathNextYPos = path_get_point_y(object_self_.myPath, object_self_.pathPos);
					solid = false;
					// In this instance, I instead move the ground hurtbox first, and then move the
					// enemy object to match the ground hurtbox location. I do this so that I can move
					// the enemy objects more smoothly around obstacles.
					mp_potential_step(object_self_.pathNextXPos, object_self_.pathNextYPos, object_self_.currentSpeed, false);
					object_self_.x = x;
					object_self_.y = y - 13;
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
			if !is_undefined(myPath) {
				if path_exists(myPath) {
					path_delete(myPath);
				}
			}
			// Reset the state variables
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
			xPointToMoveTo = -1;
			yPointToMoveTo = -1;
			lineOfSightExists = true;
			followingPlayer = false;
			followingPlayerTarget = noone;
			followingPlayerTargetX = -1;
			followingPlayerTargetY = -1;
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
		if !is_undefined(myPath) {
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
		// Reset the state variables, and set alreadyTriedToChase = true
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
}
#endregion


if (!instance_exists(currentTargetToFocus)) && (x == xPointToMoveTo) && (y == yPointToMoveTo) {
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if !is_undefined(myPath) {
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
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
		if !is_undefined(myPath) {
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
		// Reset the state variables
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		xPointToMoveTo = -1;
		yPointToMoveTo = -1;
		lineOfSightExists = true;
		followingPlayer = false;
		followingPlayerTarget = noone;
		followingPlayerTargetX = -1;
		followingPlayerTargetY = -1;
		exit;
	}
}

if point_distance(groundHurtboxX, groundHurtboxY, target_x_, target_y_) < distance_ {
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if !is_undefined(myPath) {
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
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
	if !is_undefined(myPath) {
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
	// Reset the state variables, and set alreadyTriedToChase = true
	alreadyTriedToChase = true;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
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
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
	// Path variables resetting and destroying the path to prevent memory leak
	pathPos = 1;
	pathCreated = false;
	if !is_undefined(myPath) {
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
}

// If the enemy is being forced to return to idle, reset all variables and destroy anything that would
// cause a memory leak.
if forceReturnToIdleState {
	forceReturnToIdleState = false;
	currentTargetToFocus = noone;
	currentTargetToHeal = noone;
	// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
	// reset the timer for chasing.
	pathPos = 1;
	pathCreated = false;
	if !is_undefined(myPath) {
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
	// Reset the state variables
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	xPointToMoveTo = -1;
	yPointToMoveTo = -1;
	lineOfSightExists = true;
	followingPlayer = false;
	followingPlayerTarget = noone;
	followingPlayerTargetX = -1;
	followingPlayerTargetY = -1;
	exit;
}


