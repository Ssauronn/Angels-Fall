///@description Follow the player if no combat is present
// If combat starts up again, revert to idle to begin combat and reset all variables that need resetting
if ds_exists(objectIDsInBattle, ds_type_list) {
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
	// Path variables resetting and destroying the path to prevent memory leak
	pathPos = 1;
	pathCreated = false;
	if variable_instance_exists(self, "myPath") {
		if !is_undefined(myPath) {
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
	}
}
else {
	var target_ = obj_player.id;
	var distance_ = tetherToPlayerOutOfCombatRange;
	var object_self_ = self;
	groundHurtboxX = enemyGroundHurtbox.x;
	groundHurtboxY = enemyGroundHurtbox.y;
	pathEndXGoal = target_.x;
	pathEndYGoal = target_.y;
	if instance_exists(target_) {
		if point_distance(groundHurtboxX, groundHurtboxY, target_.x, target_.y) > distance_ {
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
		// Else if I'm within correct range, revert to idle
		else {
			// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
			// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
			enemyState = enemystates.idle;
			enemyStateSprite = enemystates.idle;
			chosenEngine = "";
			decisionMadeForTargetAndAction = false;
			alreadyTriedToChase = false;
			alreadyTriedToChaseTimer = 0;
			enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
			enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
			enemyTimeUntilNextManaAbilityUsableTimerSet = false;
			enemyTimeUntilNextManaAbilityUsableTimer = 0;
			// Path variables resetting and destroying the path to prevent memory leak
			pathPos = 1;
			pathCreated = false;
			if path_exists(myPath) {
				path_delete(myPath);
			}
		}
	}
	// Else if the target_ doesn't exist, revert to idle
	else {
		// Reset variables that need resetting (identified at end of scr_enemy_idle script) and 
		// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
		// Path variables being reset
		enemyState = enemystates.idle;
		enemyStateSprite = enemystates.idle;
		chosenEngine = "";
		decisionMadeForTargetAndAction = false;
		alreadyTriedToChase = false;
		alreadyTriedToChaseTimer = 0;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		// Path variables resetting and destroying the path to prevent memory leak
		pathPos = 1;
		pathCreated = false;
		if path_exists(myPath) {
			path_delete(myPath);
		}
	}
}

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
	// reset the timer for chasing, as well as setting alreadyTriedToChase to true.
	enemyState = enemystates.idle;
	enemyStateSprite = enemystates.idle;
	chosenEngine = "";
	decisionMadeForTargetAndAction = false;
	alreadyTriedToChase = false;
	alreadyTriedToChaseTimer = 0;
	enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
	enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
	enemyTimeUntilNextManaAbilityUsableTimerSet = false;
	enemyTimeUntilNextManaAbilityUsableTimer = 0;
	// Path variables resetting and destroying the path to prevent memory leak
	pathPos = 1;
	pathCreated = false;
	if path_exists(myPath) {
		path_delete(myPath);
	}
}


