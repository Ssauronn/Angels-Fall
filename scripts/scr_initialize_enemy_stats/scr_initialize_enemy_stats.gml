///@argument0 enemyName

var enemy_name_ = argument0;
switch (enemy_name_) {
	case "Mage":
		#region Mage
		// Powerful Being?
		powerfulBeing = false;
		
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 500;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 500;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.3) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 500;
		enemyManaRegeneration = (enemyMaxMana * 0.3) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;
		
		// Animecro Reward to player for Killing Enemy
		animecroRewardUponDeath = 150;
		
		// Timer limiting time between attacks
		enemyTimeUntilNextAttackUsableTimerStartTime = room_speed * (2 + random_range(0, 0.5));
		enemyTimeUntilNextAttackUsableTimer = -1;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // * any other damage bonuses
		enemyTotalBonusResistance = 1; // * any other resistance bonuses

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 50;
		enemyHeavyMeleeAttackDamage = 100;
		enemyLightRangedAttackDamage = 50;
		enemyHeavyRangedAttackDamage = 100;

		// Enemies' Attack Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.6;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.9;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.6;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 0.9;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32 * 2;
		enemyHeavyMeleeAttackRange = 32 * 2;
		enemyLightRangedAttackRange = 32 * 8;
		enemyHeavyRangedAttackRange = 32 * 8;
		
		// Enemy Total Damage Dealt with attack after multipliers and resistances
		enemyTotalDamageDealt = 0;
		// Enemy Total Damage Taken from Attack after multipliers and resistances
		// This is used to calculate a variety of things. First its set to the hitbox value in the
		// collision event in obj_hitbox. Then all resistance and damage multipliers are applied to it,
		// changing its value, before its finally applied after all values are determined.
		enemyTotalDamageTaken = 0;
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 0.8;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		
		// Path variables
		// Path the enemy will follow
		myPath = undefined;
		// This is set to false because even though a path was created, it wasn't assigned an actual
		// path to follow
		pathCreated = false;
		// Enemy start locations for the path
		groundHurtboxX = 0;
		groundHurtboxY = 0;
		// Target Focus and Target Heal x and y locations to move to
		pathEndXGoal = 0;
		pathEndYGoal = 0;
		// The actual path coordinates on the next path position
		pathPos = 1;
		pathNextXPos = 0;
		pathNextYPos = 0;
		
		// Tethering to player range
		tetherToPlayerOutOfCombatRange = 32 * 3.5;
		
		#region Stun and Hitstun Values
		// Setting the stun values
		/*
		If stun timer is greater than 0, then the stun is active, which forces the state to be sent to stun state

		We never actually set enemyState = enemystates.stunned except for in other scripts, because depending on the action
		being taken, we'll need to reset/destroy certain variables
		*/
		stunActive = false;
		stunTimer = -1;
		// I use this variable to multiply against movement speed, and resource regeneration, to lock
		// the enemy in place while stunned. I also stop direction from being set while in the stun 
		stunMultiplier = 1;

		// Setting the hitstun values, different than stun
		hitstunActive = false;
		hitstunTimer = -1;
		// I use this to multiply against movement speed, resource regeneration, and image speed. The hitstun will
		// last for a max of just a few seconds, leaving an illusion of a hard hit for the player
		hitstunMultiplier = 1;
		#endregion
		
		#region Player Prime Ability Values
		// Overwhelming Chains
		overwhelmingChainsActiveOnSelf = false;
		overwhelmingChainsDamageMultiplier = 1;
		overwhelmingChainsBaseDamageMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageMultiplier;
		overwhelmingChainsDamageResistanceMultiplier = 1;
		overwhelmingChainsBaseDamageResistanceMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageResistanceMultiplier;
		
		// Forces of Life
		forcesOfLifeActive = false;
		forcesOfLifeBaseDamageMultiplier = obj_skill_tree.forcesOfLifeBaseDamageMultiplier;
		forcesOfLifeDamageMultiplier = -1;
		
		// Solidify
		solidifyEnemyMovementSpeedMultiplier = 1;
		solidifyEnemyImageSpeedMultiplier = 1;
		solidifyEnemyStaminaRegenerationMultiplier = 1;
		solidifyEnemyManaRegenerationMultiplier = 1;
		solidifyEnemyChaseTimerSpeedMultiplier = 1;
		#endregion
		#region Poison Values
		poisoned = false;
		
		
		// Sickly Proposition
		sicklyPropositionActive = false;
		// The damage of the ability on hit
		sicklyPropositionDamage = obj_skill_tree.sicklyPropositionDamage;
		// The multiplier that can be applied if the target is poisoned
		sicklyPropositionDamageMultiplierVsPoisonedTarget = obj_skill_tree.sicklyPropositionDamageMultiplierVsPoisonedTarget;
		// The damage of the dot itself
		sicklyPropositionDoTDamage = obj_skill_tree.sicklyPropositionDoTDamage;
		sicklyPropositionCanBeRefreshed = obj_skill_tree.sicklyPropositionCanBeRefreshed;
		sicklyPropositionTicTimer = -1;
		sicklyPropositionTicTimerStartTime = obj_skill_tree.sicklyPropositionTicTimerStartTime;
		sicklyPropositionTimer = -1;
		sicklyPropositionTimerStartTime = obj_skill_tree.sicklyPropositionTimerStartTime;
		
		
		// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
		finalPartingActive = false;
		finalPartingDamage = obj_skill_tree.finalPartingDamage;
		finalPartingNextTarget = noone;
		finalPartingCanBeRefreshed = obj_skill_tree.finalPartingCanBeRefreshed;
		finalPartingTicTimer = -1;
		finalPartingTicTimerStartTime = obj_skill_tree.finalPartingTicTimerStartTime;
		finalPartingTimer = -1;
		finalPartingTimerStartTime = obj_skill_tree.finalPartingTimerStartTime;
		
		// Dinner Is Served
		dinnerIsServedActive = false;
		dinnerIsServedBaseEnemyManaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyManaRegenerationMultiplier;
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyMovementSpeedMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyMovementSpeedMultiplier;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
		dinnerIsServedStartingDamage = obj_skill_tree.dinnerIsServedStartingDamage;
		dinnerIsServedRampMultiplier = obj_skill_tree.dinnerIsServedRampMultiplier;
		dinnerIsServedCanBeRefreshed = obj_skill_tree.dinnerIsServedCanBeRefreshed;
		dinnerIsServedTicTimer = -1;
		dinnerIsServedTicTimerStartTime = obj_skill_tree.dinnerIsServedTicTimerStartTime;
		dinnerIsServedTimer = -1;
		dinnerIsServedTimerStartTime = obj_skill_tree.dinnerIsServedTimerStartTime;
		
		// Exploit Weakness
		exploitWeaknessActive = false;
		exploitWeaknessTimer = -1;
		exploitWeaknessTimerStartTime = obj_skill_tree.exploitWeaknessTimerStartTime;
		exploitWeaknessTicTimer = -1;
		exploitWeaknessTicTimerStartTime = obj_skill_tree.exploitWeaknessTicTimerStartTime;
		exploitWeaknessDoTDamage = obj_skill_tree.exploitWeaknessDoTDamage;
		exploitWeaknessCanBeRefreshed = obj_skill_tree.exploitWeaknessCanBeRefreshed;
		// If exploitWeaknessActive is true, we add enemyTotalDamageTaken to this, add this value to
		// exploitWeaknessDamage, refresh exploitWeaknessDamage, and continue on. For balance purposes,
		// exploitWeaknessDamage does not proc this effect.
		exploitWeaknessPercentOfDamageToAdd = obj_skill_tree.exploitWeaknessPercentOfDamageToAdd;
		exploitWeaknessDamageToAdd = 0;
		#endregion
		#region Debuff Values
		// True Caelesti Wings
		trueCaelestiWingsActive = false;
		trueCaelestiWingsBaseDebuffDamageMultiplier = obj_skill_tree.trueCaelestiWingsBaseDebuffDamageMultiplier;
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee = obj_skill_tree.trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
		trueCaelestiWingsDebuffTimer = -1;
		trueCaelestiWingsDebuffTimerStartTime = obj_skill_tree.trueCaelestiWingsDebuffTimerStartTime;
		
		// Wrath of the Repentant
		wrathOfTheRepentantActive = false;
		wrathOfTheRepentantBaseMovementSpeedMultiplier = obj_skill_tree.wrathOfTheRepentantBaseMovementSpeedMultiplier;
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
		wrathOfTheRepentantDebuffTimerStartTime = obj_skill_tree.wrathOfTheRepentantDebuffTimerStartTime;
		wrathOfTheRepentantDebuffTimer = -1;
		
		// Angelic Barrage
		angelicBarrageActive = false;
		angelicBarrageBaseDamageMultiplier = obj_skill_tree.angelicBarrageBaseDamageMultiplier;
		angelicBarrageDamageMultiplier = 1;
		
		// Holy Defense
		holyDefenseActive = false;
		holyDefenseDoTDamage = obj_skill_tree.holyDefenseDoTDamage;
		holyDefenseCanBeRefreshed = obj_skill_tree.holyDefenseCanBeRefreshed;
		holyDefenseTicTimer = -1;
		holyDefenseTicTimerStartTime = obj_skill_tree.holyDefenseTicTimerStartTime;
		holyDefenseTimer = -1;
		holyDefenseTimerStartTime = obj_skill_tree.holyDefenseTimerStartTime;
		
		
		// Bindings of the Caelesti
		bindingsOfTheCaelestiActive = false;
		bindingsOfTheCaelestiDamage = obj_skill_tree.bindingsOfTheCaelestiDamage;
		bindingsOfTheCaelestiCanBeRefreshed = obj_skill_tree.bindingsOfTheCaelestiCanBeRefreshed;
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
		bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = obj_skill_tree.bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
		bindingsOfTheCaelestiTicTimer = -1;
		bindingsOfTheCaelestiTicTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTicTimerStartTime;
		bindingsOfTheCaelestiTimer = -1;
		bindingsOfTheCaelestiTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTimerStartTime;
		
		
		// Soul Tether
		soulTetherActive = false;
		soulTetherCanBeRefreshed = obj_skill_tree.soulTetherCanBeRefreshed;
		soulTetherTimer = -1;
		soulTetherTimerStartTime = obj_skill_tree.soulTetherTimerStartTime;
		
		
		// Hidden Dagger
		hiddenDaggerActive = false;
		hiddenDaggerDamageMultiplierActive = false;
		hiddenDaggerCanBeRefreshed = obj_skill_tree.hiddenDaggerCanBeRefreshed;
		hiddenDaggerDamageMultiplier = 1;
		hiddenDaggerBaseDamageMultiplier = obj_skill_tree.hiddenDaggerBaseDamageMultiplier;
		hiddenDaggerDamageMultiplierTimer = -1;
		hiddenDaggerDamageMultiplierTimerStartTime = obj_skill_tree.hiddenDaggerDamageMultiplierTimerStartTime;
		hiddenDaggerTicTimer = -1;
		hiddenDaggerTicTimerStartTime = obj_skill_tree.hiddenDaggerTicTimerStartTime;
		
		// Glinting Blade
		glintingBladeTimer = -1;
		glintingBladeActive = false;
		#endregion
		

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_mage_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_mage_run;
		enemySprite[enemystates.stunned, enemydirection.right] = spr_enemy_mage_stunned;
		enemySprite[enemystates.stunned, enemydirection.up] = spr_enemy_mage_stunned;
		enemySprite[enemystates.stunned, enemydirection.left] = spr_enemy_mage_stunned;
		enemySprite[enemystates.stunned, enemydirection.down] = spr_enemy_mage_stunned;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.right] = spr_enemy_mage_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.up] = spr_enemy_mage_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.left] = spr_enemy_mage_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.down] = spr_enemy_mage_run;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.right] = spr_enemy_mage_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.up] = spr_enemy_mage_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.left] = spr_enemy_mage_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.down] = spr_enemy_mage_light_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.right] = spr_enemy_mage_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.up] = spr_enemy_mage_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.left] = spr_enemy_mage_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.down] = spr_enemy_mage_heavy_melee;
		enemySprite[enemystates.lightRangedAttack, enemydirection.right] = spr_enemy_mage_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.up] = spr_enemy_mage_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.left] = spr_enemy_mage_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.down] = spr_enemy_mage_light_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.right] = spr_enemy_mage_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.up] = spr_enemy_mage_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.left] = spr_enemy_mage_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.down] = spr_enemy_mage_heavy_ranged;
		
		
		enemyStateSprite = enemystates.idle;
		enemyDirectionFacing = enemydirection.down;
		enemyImageIndex = 0.00;
		enemyImageIndexBaseSpeed = 0.3;
		enemyImageIndexSpeed = enemyImageIndexBaseSpeed * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		enemyAnimationX = 0;
		enemyAnimationY = 0;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxAttackType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, I set the hurtbox x and y coordinates,
		sprite_index, and image_index to equal that of its owner. 
		*/
		enemyHurtbox = instance_create_depth(x, y, -999, obj_hurtbox);
		enemyHurtbox.sprite_index = enemySprite[enemyStateSprite, enemyDirectionFacing];
		enemyHurtbox.image_index = enemyImageIndex;
		enemyHurtbox.visible = false;
		enemyHurtbox.owner = self;
		enemyGroundHurtbox = instance_create_depth(x, y + 13, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		
		#endregion
		break;
	case "Healer": 
		#region Healer
		// Powerful Being?
		powerfulBeing = false;
		
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 500;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 500;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.3) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 500;
		enemyManaRegeneration = (enemyMaxMana * 0.3) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;
		
		// Animecro Reward to player for Killing Enemy
		animecroRewardUponDeath = 100;
		
		// Timer limiting time between attacks
		enemyTimeUntilNextAttackUsableTimerStartTime = room_speed * (2 + random_range(0, 0.5));
		enemyTimeUntilNextAttackUsableTimer = -1;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // * any other damage bonuses
		enemyTotalBonusResistance = 1; // * any other resistance bonuses

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 50;
		enemyHeavyMeleeAttackDamage = 100;
		enemyLightRangedAttackDamage = 50;
		enemyHeavyRangedAttackDamage = 100;
		enemyHealValue = 150;

		// Enemies Attacks' Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.6;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.9;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.5;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 0.8;
		enemyHealManaCost = enemyMaxMana * 0.9;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32 * 2;
		enemyHeavyMeleeAttackRange = 32 * 2;
		enemyLightRangedAttackRange = 32 * 8;
		enemyHeavyRangedAttackRange = 32 * 8;
		enemyHealAllyRange = 32 * 4;
		
		// Enemy Total Damage Dealt with attack after multipliers and resistances
		enemyTotalDamageDealt = 0;
		// Enemy Total Damage Taken from Attack after multipliers and resistances
		// This is used to calculate a variety of things. First its set to the hitbox value in the
		// collision event in obj_hitbox. Then all resistance and damage multipliers are applied to it,
		// changing its value, before its finally applied after all values are determined.
		enemyTotalDamageTaken = 0;
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 0.8;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		
		// Path variables
		// Path the enemy will follow
		myPath = undefined;
		// This is set to false because even though a path was created, it wasn't assigned an actual
		// path to follow
		pathCreated = false;
		// Enemy start locations for the path
		groundHurtboxX = 0;
		groundHurtboxY = 0;
		// Target Focus and Target Heal x and y locations to move to
		pathEndXGoal = 0;
		pathEndYGoal = 0;
		// The actual path coordinates on the next path position
		pathPos = 1;
		pathNextXPos = 0;
		pathNextYPos = 0;
		
		// Tethering to player range
		tetherToPlayerOutOfCombatRange = 32 * 3.5;
		
		#region Stun and Hitstun Values
		// Setting the stun values
		/*
		If stun timer is greater than 0, then the stun is active, which forces the state to be sent to stun state

		We never actually set enemyState = enemystates.stunned except for in other scripts, because depending on the action
		being taken, we'll need to reset/destroy certain variables
		*/
		stunActive = false;
		stunTimer = -1;
		// I use this variable to multiply against movement speed, and resource regeneration, to lock
		// the enemy in place while stunned. I also stop direction from being set while in the stun 
		stunMultiplier = 1;

		// Setting the hitstun values, different than stun
		hitstunActive = false;
		hitstunTimer = -1;
		// I use this to multiply against movement speed, resource regeneration, and image speed. The hitstun will
		// last for a max of just a few seconds, leaving an illusion of a hard hit for the player
		hitstunMultiplier = 1;
		#endregion
		
		#region Player Prime Ability Values
		// Overwhelming Chains
		overwhelmingChainsActiveOnSelf = false;
		overwhelmingChainsDamageMultiplier = 1;
		overwhelmingChainsBaseDamageMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageMultiplier;
		overwhelmingChainsDamageResistanceMultiplier = 1;
		overwhelmingChainsBaseDamageResistanceMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageResistanceMultiplier;
		
		// Forces of Life
		forcesOfLifeActive = false;
		forcesOfLifeBaseDamageMultiplier = obj_skill_tree.forcesOfLifeBaseDamageMultiplier;
		forcesOfLifeDamageMultiplier = -1;
		
		// Solidify
		solidifyEnemyMovementSpeedMultiplier = 1;
		solidifyEnemyImageSpeedMultiplier = 1;
		solidifyEnemyStaminaRegenerationMultiplier = 1;
		solidifyEnemyManaRegenerationMultiplier = 1;
		solidifyEnemyChaseTimerSpeedMultiplier = 1;
		#endregion
		#region Poison Values
		poisoned = false;
		
		
		// Sickly Proposition
		sicklyPropositionActive = false;
		// The damage of the ability on hit
		sicklyPropositionDamage = obj_skill_tree.sicklyPropositionDamage;
		// The multiplier that can be applied if the target is poisoned
		sicklyPropositionDamageMultiplierVsPoisonedTarget = obj_skill_tree.sicklyPropositionDamageMultiplierVsPoisonedTarget;
		// The damage of the dot itself
		sicklyPropositionDoTDamage = obj_skill_tree.sicklyPropositionDoTDamage;
		sicklyPropositionCanBeRefreshed = obj_skill_tree.sicklyPropositionCanBeRefreshed;
		sicklyPropositionTicTimer = -1;
		sicklyPropositionTicTimerStartTime = obj_skill_tree.sicklyPropositionTicTimerStartTime;
		sicklyPropositionTimer = -1;
		sicklyPropositionTimerStartTime = obj_skill_tree.sicklyPropositionTimerStartTime;
		
		
		// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
		finalPartingActive = false;
		finalPartingDamage = obj_skill_tree.finalPartingDamage;
		finalPartingNextTarget = noone;
		finalPartingCanBeRefreshed = obj_skill_tree.finalPartingCanBeRefreshed;
		finalPartingTicTimer = -1;
		finalPartingTicTimerStartTime = obj_skill_tree.finalPartingTicTimerStartTime;
		finalPartingTimer = -1;
		finalPartingTimerStartTime = obj_skill_tree.finalPartingTimerStartTime;
		
		// Dinner Is Served
		dinnerIsServedActive = false;
		dinnerIsServedBaseEnemyManaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyManaRegenerationMultiplier;
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyMovementSpeedMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyMovementSpeedMultiplier;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
		dinnerIsServedStartingDamage = obj_skill_tree.dinnerIsServedStartingDamage;
		dinnerIsServedRampMultiplier = obj_skill_tree.dinnerIsServedRampMultiplier;
		dinnerIsServedCanBeRefreshed = obj_skill_tree.dinnerIsServedCanBeRefreshed;
		dinnerIsServedTicTimer = -1;
		dinnerIsServedTicTimerStartTime = obj_skill_tree.dinnerIsServedTicTimerStartTime;
		dinnerIsServedTimer = -1;
		dinnerIsServedTimerStartTime = obj_skill_tree.dinnerIsServedTimerStartTime;
		
		// Exploit Weakness
		exploitWeaknessActive = false;
		exploitWeaknessTimer = -1;
		exploitWeaknessTimerStartTime = obj_skill_tree.exploitWeaknessTimerStartTime;
		exploitWeaknessTicTimer = -1;
		exploitWeaknessTicTimerStartTime = obj_skill_tree.exploitWeaknessTicTimerStartTime;
		exploitWeaknessDoTDamage = obj_skill_tree.exploitWeaknessDoTDamage;
		exploitWeaknessCanBeRefreshed = obj_skill_tree.exploitWeaknessCanBeRefreshed;
		// If exploitWeaknessActive is true, we add enemyTotalDamageTaken to this, add this value to
		// exploitWeaknessDamage, refresh exploitWeaknessDamage, and continue on. For balance purposes,
		// exploitWeaknessDamage does not proc this effect.
		exploitWeaknessPercentOfDamageToAdd = obj_skill_tree.exploitWeaknessPercentOfDamageToAdd;
		exploitWeaknessDamageToAdd = 0;
		#endregion
		#region Debuff Values
		// True Caelesti Wings
		trueCaelestiWingsActive = false;
		trueCaelestiWingsBaseDebuffDamageMultiplier = obj_skill_tree.trueCaelestiWingsBaseDebuffDamageMultiplier;
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee = obj_skill_tree.trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
		trueCaelestiWingsDebuffTimer = -1;
		trueCaelestiWingsDebuffTimerStartTime = obj_skill_tree.trueCaelestiWingsDebuffTimerStartTime;
		
		// Wrath of the Repentant
		wrathOfTheRepentantActive = false;
		wrathOfTheRepentantBaseMovementSpeedMultiplier = obj_skill_tree.wrathOfTheRepentantBaseMovementSpeedMultiplier;
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
		wrathOfTheRepentantDebuffTimerStartTime = obj_skill_tree.wrathOfTheRepentantDebuffTimerStartTime;
		wrathOfTheRepentantDebuffTimer = -1;
		
		// Angelic Barrage
		angelicBarrageActive = false;
		angelicBarrageBaseDamageMultiplier = obj_skill_tree.angelicBarrageBaseDamageMultiplier;
		angelicBarrageDamageMultiplier = 1;
		
		// Holy Defense
		holyDefenseActive = false;
		holyDefenseDoTDamage = obj_skill_tree.holyDefenseDoTDamage;
		holyDefenseCanBeRefreshed = obj_skill_tree.holyDefenseCanBeRefreshed;
		holyDefenseTicTimer = -1;
		holyDefenseTicTimerStartTime = obj_skill_tree.holyDefenseTicTimerStartTime;
		holyDefenseTimer = -1;
		holyDefenseTimerStartTime = obj_skill_tree.holyDefenseTimerStartTime;
		
		
		// Bindings of the Caelesti
		bindingsOfTheCaelestiActive = false;
		bindingsOfTheCaelestiDamage = obj_skill_tree.bindingsOfTheCaelestiDamage;
		bindingsOfTheCaelestiCanBeRefreshed = obj_skill_tree.bindingsOfTheCaelestiCanBeRefreshed;
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
		bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = obj_skill_tree.bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
		bindingsOfTheCaelestiTicTimer = -1;
		bindingsOfTheCaelestiTicTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTicTimerStartTime;
		bindingsOfTheCaelestiTimer = -1;
		bindingsOfTheCaelestiTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTimerStartTime;
		
		
		// Soul Tether
		soulTetherActive = false;
		soulTetherCanBeRefreshed = obj_skill_tree.soulTetherCanBeRefreshed;
		soulTetherTimer = -1;
		soulTetherTimerStartTime = obj_skill_tree.soulTetherTimerStartTime;
		
		
		// Hidden Dagger
		hiddenDaggerActive = false;
		hiddenDaggerDamageMultiplierActive = false;
		hiddenDaggerCanBeRefreshed = obj_skill_tree.hiddenDaggerCanBeRefreshed;
		hiddenDaggerDamageMultiplier = 1;
		hiddenDaggerBaseDamageMultiplier = obj_skill_tree.hiddenDaggerBaseDamageMultiplier;
		hiddenDaggerDamageMultiplierTimer = -1;
		hiddenDaggerDamageMultiplierTimerStartTime = obj_skill_tree.hiddenDaggerDamageMultiplierTimerStartTime;
		hiddenDaggerTicTimer = -1;
		hiddenDaggerTicTimerStartTime = obj_skill_tree.hiddenDaggerTicTimerStartTime;
		
		// Glinting Blade
		glintingBladeTimer = -1;
		glintingBladeActive = false;
		#endregion
		

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_healer_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_healer_run;
		enemySprite[enemystates.stunned, enemydirection.right] = spr_enemy_healer_stunned;
		enemySprite[enemystates.stunned, enemydirection.up] = spr_enemy_healer_stunned;
		enemySprite[enemystates.stunned, enemydirection.left] = spr_enemy_healer_stunned;
		enemySprite[enemystates.stunned, enemydirection.down] = spr_enemy_healer_stunned;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.right] = spr_enemy_healer_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.up] = spr_enemy_healer_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.left] = spr_enemy_healer_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.down] = spr_enemy_healer_run;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.right] = spr_enemy_healer_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.up] = spr_enemy_healer_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.left] = spr_enemy_healer_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.down] = spr_enemy_healer_light_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.right] = spr_enemy_healer_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.up] = spr_enemy_healer_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.left] = spr_enemy_healer_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.down] = spr_enemy_healer_heavy_melee;
		enemySprite[enemystates.lightRangedAttack, enemydirection.right] = spr_enemy_healer_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.up] = spr_enemy_healer_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.left] = spr_enemy_healer_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.down] = spr_enemy_healer_light_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.right] = spr_enemy_healer_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.up] = spr_enemy_healer_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.left] = spr_enemy_healer_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.down] = spr_enemy_healer_heavy_ranged;
		enemySprite[enemystates.healAlly, enemydirection.right] = spr_enemy_healer_heal_ally;
		enemySprite[enemystates.healAlly, enemydirection.up] = spr_enemy_healer_heal_ally;
		enemySprite[enemystates.healAlly, enemydirection.left] = spr_enemy_healer_heal_ally;
		enemySprite[enemystates.healAlly, enemydirection.down] = spr_enemy_healer_heal_ally;
		
		
		enemyStateSprite = enemystates.idle;
		enemyDirectionFacing = enemydirection.down;
		enemyImageIndex = 0.00;
		enemyImageIndexBaseSpeed = 0.3;
		enemyImageIndexSpeed = enemyImageIndexBaseSpeed * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		enemyAnimationX = 0;
		enemyAnimationY = 0;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxAttackType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, I set the hurtbox and ground hurtbox 
		x and y coordinates, sprite_index, and image_index to equal that of its owner. 
		*/
		enemyHurtbox = instance_create_depth(x, y, -999, obj_hurtbox);
		enemyHurtbox.sprite_index = enemySprite[enemyStateSprite, enemyDirectionFacing];
		enemyHurtbox.image_index = enemyImageIndex;
		enemyHurtbox.visible = false;
		enemyHurtbox.owner = self;
		enemyGroundHurtbox = instance_create_depth(x, y + 13, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		
		#endregion
		break;
	case "Tank":
		#region Tank
		// Powerful Being?
		powerfulBeing = false;
		
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 750;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 500;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.3) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 500;
		enemyManaRegeneration = (enemyMaxMana * 0.3) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;
		
		// Animecro Reward to player for Killing Enemy
		animecroRewardUponDeath = 300;
		
		// Timer limiting time between attacks
		enemyTimeUntilNextAttackUsableTimerStartTime = room_speed * (2 + random_range(0, 0.5));
		enemyTimeUntilNextAttackUsableTimer = -1;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // * any other damage bonuses
		enemyTotalBonusResistance = 1; // * any other resistance bonuses

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 100;
		enemyHeavyMeleeAttackDamage = 150;
		enemyLightRangedAttackDamage = 25;
		enemyHeavyRangedAttackDamage = 50;

		// Enemies' Attack Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.5;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.75;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.75;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 1.0;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32 * 2;
		enemyHeavyMeleeAttackRange = 32 * 2;
		enemyLightRangedAttackRange = 32 * 8;
		enemyHeavyRangedAttackRange = 32 * 8;
		
		// Enemy Total Damage Dealt with attack after multipliers and resistances
		enemyTotalDamageDealt = 0;
		// Enemy Total Damage Taken from Attack after multipliers and resistances
		// This is used to calculate a variety of things. First its set to the hitbox value in the
		// collision event in obj_hitbox. Then all resistance and damage multipliers are applied to it,
		// changing its value, before its finally applied after all values are determined.
		enemyTotalDamageTaken = 0;
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 0.9;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		
		// Path variables
		// Path the enemy will follow
		myPath = undefined;
		// This is set to false because even though a path was created, it wasn't assigned an actual
		// path to follow
		pathCreated = false;
		// Enemy start locations for the path
		groundHurtboxX = 0;
		groundHurtboxY = 0;
		// Target Focus and Target Heal x and y locations to move to
		pathEndXGoal = 0;
		pathEndYGoal = 0;
		// The actual path coordinates on the next path position
		pathPos = 1;
		pathNextXPos = 0;
		pathNextYPos = 0;
		
		// Tethering to player range
		tetherToPlayerOutOfCombatRange = 32 * 3.5;
		
		#region Stun and Hitstun Values
		// Setting the stun values
		/*
		If stun timer is greater than 0, then the stun is active, which forces the state to be sent to stun state

		We never actually set enemyState = enemystates.stunned except for in other scripts, because depending on the action
		being taken, we'll need to reset/destroy certain variables
		*/
		stunActive = false;
		stunTimer = -1;
		// I use this variable to multiply against movement speed, and resource regeneration, to lock
		// the enemy in place while stunned. I also stop direction from being set while in the stun 
		stunMultiplier = 1;

		// Setting the hitstun values, different than stun
		hitstunActive = false;
		hitstunTimer = -1;
		// I use this to multiply against movement speed, resource regeneration, and image speed. The hitstun will
		// last for a max of just a few seconds, leaving an illusion of a hard hit for the player
		hitstunMultiplier = 1;
		#endregion
		
		#region Player Prime Ability Values
		// Overwhelming Chains
		overwhelmingChainsActiveOnSelf = false;
		overwhelmingChainsDamageMultiplier = 1;
		overwhelmingChainsBaseDamageMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageMultiplier;
		overwhelmingChainsDamageResistanceMultiplier = 1;
		overwhelmingChainsBaseDamageResistanceMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageResistanceMultiplier;
		
		// Forces of Life
		forcesOfLifeActive = false;
		forcesOfLifeBaseDamageMultiplier = obj_skill_tree.forcesOfLifeBaseDamageMultiplier;
		forcesOfLifeDamageMultiplier = -1;
		
		// Solidify
		solidifyEnemyMovementSpeedMultiplier = 1;
		solidifyEnemyImageSpeedMultiplier = 1;
		solidifyEnemyStaminaRegenerationMultiplier = 1;
		solidifyEnemyManaRegenerationMultiplier = 1;
		solidifyEnemyChaseTimerSpeedMultiplier = 1;
		#endregion
		#region Poison Values
		poisoned = false;
		
		
		// Sickly Proposition
		sicklyPropositionActive = false;
		// The damage of the ability on hit
		sicklyPropositionDamage = obj_skill_tree.sicklyPropositionDamage;
		// The multiplier that can be applied if the target is poisoned
		sicklyPropositionDamageMultiplierVsPoisonedTarget = obj_skill_tree.sicklyPropositionDamageMultiplierVsPoisonedTarget;
		// The damage of the dot itself
		sicklyPropositionDoTDamage = obj_skill_tree.sicklyPropositionDoTDamage;
		sicklyPropositionCanBeRefreshed = obj_skill_tree.sicklyPropositionCanBeRefreshed;
		sicklyPropositionTicTimer = -1;
		sicklyPropositionTicTimerStartTime = obj_skill_tree.sicklyPropositionTicTimerStartTime;
		sicklyPropositionTimer = -1;
		sicklyPropositionTimerStartTime = obj_skill_tree.sicklyPropositionTimerStartTime;
		
		
		// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
		finalPartingActive = false;
		finalPartingDamage = obj_skill_tree.finalPartingDamage;
		finalPartingNextTarget = noone;
		finalPartingCanBeRefreshed = obj_skill_tree.finalPartingCanBeRefreshed;
		finalPartingTicTimer = -1;
		finalPartingTicTimerStartTime = obj_skill_tree.finalPartingTicTimerStartTime;
		finalPartingTimer = -1;
		finalPartingTimerStartTime = obj_skill_tree.finalPartingTimerStartTime;
		
		// Dinner Is Served
		dinnerIsServedActive = false;
		dinnerIsServedBaseEnemyManaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyManaRegenerationMultiplier;
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyMovementSpeedMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyMovementSpeedMultiplier;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
		dinnerIsServedStartingDamage = obj_skill_tree.dinnerIsServedStartingDamage;
		dinnerIsServedRampMultiplier = obj_skill_tree.dinnerIsServedRampMultiplier;
		dinnerIsServedCanBeRefreshed = obj_skill_tree.dinnerIsServedCanBeRefreshed;
		dinnerIsServedTicTimer = -1;
		dinnerIsServedTicTimerStartTime = obj_skill_tree.dinnerIsServedTicTimerStartTime;
		dinnerIsServedTimer = -1;
		dinnerIsServedTimerStartTime = obj_skill_tree.dinnerIsServedTimerStartTime;
		
		// Exploit Weakness
		exploitWeaknessActive = false;
		exploitWeaknessTimer = -1;
		exploitWeaknessTimerStartTime = obj_skill_tree.exploitWeaknessTimerStartTime;
		exploitWeaknessTicTimer = -1;
		exploitWeaknessTicTimerStartTime = obj_skill_tree.exploitWeaknessTicTimerStartTime;
		exploitWeaknessDoTDamage = obj_skill_tree.exploitWeaknessDoTDamage;
		exploitWeaknessCanBeRefreshed = obj_skill_tree.exploitWeaknessCanBeRefreshed;
		// If exploitWeaknessActive is true, we add enemyTotalDamageTaken to this, add this value to
		// exploitWeaknessDamage, refresh exploitWeaknessDamage, and continue on. For balance purposes,
		// exploitWeaknessDamage does not proc this effect.
		exploitWeaknessPercentOfDamageToAdd = obj_skill_tree.exploitWeaknessPercentOfDamageToAdd;
		exploitWeaknessDamageToAdd = 0;
		#endregion
		#region Debuff Values
		// True Caelesti Wings
		trueCaelestiWingsActive = false;
		trueCaelestiWingsBaseDebuffDamageMultiplier = obj_skill_tree.trueCaelestiWingsBaseDebuffDamageMultiplier;
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee = obj_skill_tree.trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
		trueCaelestiWingsDebuffTimer = -1;
		trueCaelestiWingsDebuffTimerStartTime = obj_skill_tree.trueCaelestiWingsDebuffTimerStartTime;
		
		// Wrath of the Repentant
		wrathOfTheRepentantActive = false;
		wrathOfTheRepentantBaseMovementSpeedMultiplier = obj_skill_tree.wrathOfTheRepentantBaseMovementSpeedMultiplier;
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
		wrathOfTheRepentantDebuffTimerStartTime = obj_skill_tree.wrathOfTheRepentantDebuffTimerStartTime;
		wrathOfTheRepentantDebuffTimer = -1;
		
		// Angelic Barrage
		angelicBarrageActive = false;
		angelicBarrageBaseDamageMultiplier = obj_skill_tree.angelicBarrageBaseDamageMultiplier;
		angelicBarrageDamageMultiplier = 1;
		
		// Holy Defense
		holyDefenseActive = false;
		holyDefenseDoTDamage = obj_skill_tree.holyDefenseDoTDamage;
		holyDefenseCanBeRefreshed = obj_skill_tree.holyDefenseCanBeRefreshed;
		holyDefenseTicTimer = -1;
		holyDefenseTicTimerStartTime = obj_skill_tree.holyDefenseTicTimerStartTime;
		holyDefenseTimer = -1;
		holyDefenseTimerStartTime = obj_skill_tree.holyDefenseTimerStartTime;
		
		
		// Bindings of the Caelesti
		bindingsOfTheCaelestiActive = false;
		bindingsOfTheCaelestiDamage = obj_skill_tree.bindingsOfTheCaelestiDamage;
		bindingsOfTheCaelestiCanBeRefreshed = obj_skill_tree.bindingsOfTheCaelestiCanBeRefreshed;
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
		bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = obj_skill_tree.bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
		bindingsOfTheCaelestiTicTimer = -1;
		bindingsOfTheCaelestiTicTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTicTimerStartTime;
		bindingsOfTheCaelestiTimer = -1;
		bindingsOfTheCaelestiTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTimerStartTime;
		
		
		// Soul Tether
		soulTetherActive = false;
		soulTetherCanBeRefreshed = obj_skill_tree.soulTetherCanBeRefreshed;
		soulTetherTimer = -1;
		soulTetherTimerStartTime = obj_skill_tree.soulTetherTimerStartTime;
		
		
		// Hidden Dagger
		hiddenDaggerActive = false;
		hiddenDaggerDamageMultiplierActive = false;
		hiddenDaggerCanBeRefreshed = obj_skill_tree.hiddenDaggerCanBeRefreshed;
		hiddenDaggerDamageMultiplier = 1;
		hiddenDaggerBaseDamageMultiplier = obj_skill_tree.hiddenDaggerBaseDamageMultiplier;
		hiddenDaggerDamageMultiplierTimer = -1;
		hiddenDaggerDamageMultiplierTimerStartTime = obj_skill_tree.hiddenDaggerDamageMultiplierTimerStartTime;
		hiddenDaggerTicTimer = -1;
		hiddenDaggerTicTimerStartTime = obj_skill_tree.hiddenDaggerTicTimerStartTime;
		
		// Glinting Blade
		glintingBladeTimer = -1;
		glintingBladeActive = false;
		#endregion
		

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_tank_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_tank_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_tank_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_tank_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_tank_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_tank_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_tank_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_tank_run;
		enemySprite[enemystates.stunned, enemydirection.right] = spr_enemy_tank_stunned;
		enemySprite[enemystates.stunned, enemydirection.up] = spr_enemy_tank_stunned;
		enemySprite[enemystates.stunned, enemydirection.left] = spr_enemy_tank_stunned;
		enemySprite[enemystates.stunned, enemydirection.down] = spr_enemy_tank_stunned;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.right] = spr_enemy_tank_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.up] = spr_enemy_tank_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.left] = spr_enemy_tank_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.down] = spr_enemy_tank_run;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.right] = spr_enemy_tank_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.up] = spr_enemy_tank_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.left] = spr_enemy_tank_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.down] = spr_enemy_tank_light_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.right] = spr_enemy_tank_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.up] = spr_enemy_tank_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.left] = spr_enemy_tank_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.down] = spr_enemy_tank_heavy_melee;
		enemySprite[enemystates.lightRangedAttack, enemydirection.right] = spr_enemy_tank_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.up] = spr_enemy_tank_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.left] = spr_enemy_tank_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.down] = spr_enemy_tank_light_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.right] = spr_enemy_tank_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.up] = spr_enemy_tank_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.left] = spr_enemy_tank_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.down] = spr_enemy_tank_heavy_ranged;
		
		
		enemyStateSprite = enemystates.idle;
		enemyDirectionFacing = enemydirection.down;
		enemyImageIndex = 0.00;
		enemyImageIndexBaseSpeed = 0.3;
		enemyImageIndexSpeed = enemyImageIndexBaseSpeed * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		enemyAnimationX = 0;
		enemyAnimationY = 0;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxAttackType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, I set the hurtbox x and y coordinates,
		sprite_index, and image_index to equal that of its owner. 
		*/
		enemyHurtbox = instance_create_depth(x, y, -999, obj_hurtbox);
		enemyHurtbox.sprite_index = enemySprite[enemyStateSprite, enemyDirectionFacing];
		enemyHurtbox.image_index = enemyImageIndex;
		enemyHurtbox.visible = false;
		enemyHurtbox.owner = self;
		enemyGroundHurtbox = instance_create_depth(x, y + 13, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		
		#endregion
		break;
	case "Fighter":
		#region Fighter
		// Powerful Being?
		powerfulBeing = false;
		
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 500;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 500;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.3) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 500;
		enemyManaRegeneration = (enemyMaxMana * 0.3) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;
		
		// Animecro Reward to player for Killing Enemy
		animecroRewardUponDeath = 200;
		
		// Timer limiting time between attacks
		enemyTimeUntilNextAttackUsableTimerStartTime = room_speed * (2 + random_range(0, 0.5));
		enemyTimeUntilNextAttackUsableTimer = -1;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // * any other damage bonuses
		enemyTotalBonusResistance = 1; // * any other resistance bonuses

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 100;
		enemyHeavyMeleeAttackDamage = 150;
		enemyLightRangedAttackDamage = 50;
		enemyHeavyRangedAttackDamage = 75;

		// Enemies' Attack Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.5;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.75;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.75;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 1.0;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32 * 2;
		enemyHeavyMeleeAttackRange = 32 * 2;
		enemyLightRangedAttackRange = 32 * 8;
		enemyHeavyRangedAttackRange = 32 * 8;
		
		// Enemy Total Damage Dealt with attack after multipliers and resistances
		enemyTotalDamageDealt = 0;
		// Enemy Total Damage Taken from Attack after multipliers and resistances
		// This is used to calculate a variety of things. First its set to the hitbox value in the
		// collision event in obj_hitbox. Then all resistance and damage multipliers are applied to it,
		// changing its value, before its finally applied after all values are determined.
		enemyTotalDamageTaken = 0;
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 0.9;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		
		// Path variables
		// Path the enemy will follow
		myPath = undefined;
		// This is set to false because even though a path was created, it wasn't assigned an actual
		// path to follow
		pathCreated = false;
		// Enemy start locations for the path
		groundHurtboxX = 0;
		groundHurtboxY = 0;
		// Target Focus and Target Heal x and y locations to move to
		pathEndXGoal = 0;
		pathEndYGoal = 0;
		// The actual path coordinates on the next path position
		pathPos = 1;
		pathNextXPos = 0;
		pathNextYPos = 0;
		
		// Tethering to player range
		tetherToPlayerOutOfCombatRange = 32 * 3.5;
		
		#region Stun and Hitstun Values
		// Setting the stun values
		/*
		If stun timer is greater than 0, then the stun is active, which forces the state to be sent to stun state

		We never actually set enemyState = enemystates.stunned except for in other scripts, because depending on the action
		being taken, we'll need to reset/destroy certain variables
		*/
		stunActive = false;
		stunTimer = -1;
		// I use this variable to multiply against movement speed, and resource regeneration, to lock
		// the enemy in place while stunned. I also stop direction from being set while in the stun 
		stunMultiplier = 1;

		// Setting the hitstun values, different than stun
		hitstunActive = false;
		hitstunTimer = -1;
		// I use this to multiply against movement speed, resource regeneration, and image speed. The hitstun will
		// last for a max of just a few seconds, leaving an illusion of a hard hit for the player
		hitstunMultiplier = 1;
		#endregion
		
		#region Player Prime Ability Values
		// Overwhelming Chains
		overwhelmingChainsActiveOnSelf = false;
		overwhelmingChainsDamageMultiplier = 1;
		overwhelmingChainsBaseDamageMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageMultiplier;
		overwhelmingChainsDamageResistanceMultiplier = 1;
		overwhelmingChainsBaseDamageResistanceMultiplier = obj_skill_tree.overwhelmingChainsBaseDamageResistanceMultiplier;
		
		// Forces of Life
		forcesOfLifeActive = false;
		forcesOfLifeBaseDamageMultiplier = obj_skill_tree.forcesOfLifeBaseDamageMultiplier;
		forcesOfLifeDamageMultiplier = -1;
		
		// Solidify
		solidifyEnemyMovementSpeedMultiplier = 1;
		solidifyEnemyImageSpeedMultiplier = 1;
		solidifyEnemyStaminaRegenerationMultiplier = 1;
		solidifyEnemyManaRegenerationMultiplier = 1;
		solidifyEnemyChaseTimerSpeedMultiplier = 1;
		#endregion
		#region Poison Values
		poisoned = false;
		
		
		// Sickly Proposition
		sicklyPropositionActive = false;
		// The damage of the ability on hit
		sicklyPropositionDamage = obj_skill_tree.sicklyPropositionDamage;
		// The multiplier that can be applied if the target is poisoned
		sicklyPropositionDamageMultiplierVsPoisonedTarget = obj_skill_tree.sicklyPropositionDamageMultiplierVsPoisonedTarget;
		// The damage of the dot itself
		sicklyPropositionDoTDamage = obj_skill_tree.sicklyPropositionDoTDamage;
		sicklyPropositionCanBeRefreshed = obj_skill_tree.sicklyPropositionCanBeRefreshed;
		sicklyPropositionTicTimer = -1;
		sicklyPropositionTicTimerStartTime = obj_skill_tree.sicklyPropositionTicTimerStartTime;
		sicklyPropositionTimer = -1;
		sicklyPropositionTimerStartTime = obj_skill_tree.sicklyPropositionTimerStartTime;
		
		
		// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
		finalPartingActive = false;
		finalPartingDamage = obj_skill_tree.finalPartingDamage;
		finalPartingNextTarget = noone;
		finalPartingCanBeRefreshed = obj_skill_tree.finalPartingCanBeRefreshed;
		finalPartingTicTimer = -1;
		finalPartingTicTimerStartTime = obj_skill_tree.finalPartingTicTimerStartTime;
		finalPartingTimer = -1;
		finalPartingTimerStartTime = obj_skill_tree.finalPartingTimerStartTime;
		
		// Dinner Is Served
		dinnerIsServedActive = false;
		dinnerIsServedBaseEnemyManaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyManaRegenerationMultiplier;
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyStaminaRegenerationMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedBaseEnemyMovementSpeedMultiplier = obj_skill_tree.dinnerIsServedBaseEnemyMovementSpeedMultiplier;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
		dinnerIsServedStartingDamage = obj_skill_tree.dinnerIsServedStartingDamage;
		dinnerIsServedRampMultiplier = obj_skill_tree.dinnerIsServedRampMultiplier;
		dinnerIsServedCanBeRefreshed = obj_skill_tree.dinnerIsServedCanBeRefreshed;
		dinnerIsServedTicTimer = -1;
		dinnerIsServedTicTimerStartTime = obj_skill_tree.dinnerIsServedTicTimerStartTime;
		dinnerIsServedTimer = -1;
		dinnerIsServedTimerStartTime = obj_skill_tree.dinnerIsServedTimerStartTime;
		
		// Exploit Weakness
		exploitWeaknessActive = false;
		exploitWeaknessTimer = -1;
		exploitWeaknessTimerStartTime = obj_skill_tree.exploitWeaknessTimerStartTime;
		exploitWeaknessTicTimer = -1;
		exploitWeaknessTicTimerStartTime = obj_skill_tree.exploitWeaknessTicTimerStartTime;
		exploitWeaknessDoTDamage = obj_skill_tree.exploitWeaknessDoTDamage;
		exploitWeaknessCanBeRefreshed = obj_skill_tree.exploitWeaknessCanBeRefreshed;
		// If exploitWeaknessActive is true, we add enemyTotalDamageTaken to this, add this value to
		// exploitWeaknessDamage, refresh exploitWeaknessDamage, and continue on. For balance purposes,
		// exploitWeaknessDamage does not proc this effect.
		exploitWeaknessPercentOfDamageToAdd = obj_skill_tree.exploitWeaknessPercentOfDamageToAdd;
		exploitWeaknessDamageToAdd = 0;
		#endregion
		#region Debuff Values
		// True Caelesti Wings
		trueCaelestiWingsActive = false;
		trueCaelestiWingsBaseDebuffDamageMultiplier = obj_skill_tree.trueCaelestiWingsBaseDebuffDamageMultiplier;
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee = obj_skill_tree.trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
		trueCaelestiWingsDebuffTimer = -1;
		trueCaelestiWingsDebuffTimerStartTime = obj_skill_tree.trueCaelestiWingsDebuffTimerStartTime;
		
		// Wrath of the Repentant
		wrathOfTheRepentantActive = false;
		wrathOfTheRepentantBaseMovementSpeedMultiplier = obj_skill_tree.wrathOfTheRepentantBaseMovementSpeedMultiplier;
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
		wrathOfTheRepentantDebuffTimerStartTime = obj_skill_tree.wrathOfTheRepentantDebuffTimerStartTime;
		wrathOfTheRepentantDebuffTimer = -1;
		
		// Angelic Barrage
		angelicBarrageActive = false;
		angelicBarrageBaseDamageMultiplier = obj_skill_tree.angelicBarrageBaseDamageMultiplier;
		angelicBarrageDamageMultiplier = 1;
		
		// Holy Defense
		holyDefenseActive = false;
		holyDefenseDoTDamage = obj_skill_tree.holyDefenseDoTDamage;
		holyDefenseCanBeRefreshed = obj_skill_tree.holyDefenseCanBeRefreshed;
		holyDefenseTicTimer = -1;
		holyDefenseTicTimerStartTime = obj_skill_tree.holyDefenseTicTimerStartTime;
		holyDefenseTimer = -1;
		holyDefenseTimerStartTime = obj_skill_tree.holyDefenseTimerStartTime;
		
		
		// Bindings of the Caelesti
		bindingsOfTheCaelestiActive = false;
		bindingsOfTheCaelestiDamage = obj_skill_tree.bindingsOfTheCaelestiDamage;
		bindingsOfTheCaelestiCanBeRefreshed = obj_skill_tree.bindingsOfTheCaelestiCanBeRefreshed;
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
		bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier = obj_skill_tree.bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
		bindingsOfTheCaelestiTicTimer = -1;
		bindingsOfTheCaelestiTicTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTicTimerStartTime;
		bindingsOfTheCaelestiTimer = -1;
		bindingsOfTheCaelestiTimerStartTime = obj_skill_tree.bindingsOfTheCaelestiTimerStartTime;
		
		
		// Soul Tether
		soulTetherActive = false;
		soulTetherCanBeRefreshed = obj_skill_tree.soulTetherCanBeRefreshed;
		soulTetherTimer = -1;
		soulTetherTimerStartTime = obj_skill_tree.soulTetherTimerStartTime;
		
		
		// Hidden Dagger
		hiddenDaggerActive = false;
		hiddenDaggerDamageMultiplierActive = false;
		hiddenDaggerCanBeRefreshed = obj_skill_tree.hiddenDaggerCanBeRefreshed;
		hiddenDaggerDamageMultiplier = 1;
		hiddenDaggerBaseDamageMultiplier = obj_skill_tree.hiddenDaggerBaseDamageMultiplier;
		hiddenDaggerDamageMultiplierTimer = -1;
		hiddenDaggerDamageMultiplierTimerStartTime = obj_skill_tree.hiddenDaggerDamageMultiplierTimerStartTime;
		hiddenDaggerTicTimer = -1;
		hiddenDaggerTicTimerStartTime = obj_skill_tree.hiddenDaggerTicTimerStartTime;
		
		// Glinting Blade
		glintingBladeTimer = -1;
		glintingBladeActive = false;
		#endregion
		

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_fighter_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_fighter_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_fighter_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_fighter_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_fighter_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_fighter_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_fighter_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_fighter_run;
		enemySprite[enemystates.stunned, enemydirection.right] = spr_enemy_fighter_stunned;
		enemySprite[enemystates.stunned, enemydirection.up] = spr_enemy_fighter_stunned;
		enemySprite[enemystates.stunned, enemydirection.left] = spr_enemy_fighter_stunned;
		enemySprite[enemystates.stunned, enemydirection.down] = spr_enemy_fighter_stunned;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.right] = spr_enemy_fighter_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.up] = spr_enemy_fighter_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.left] = spr_enemy_fighter_run;
		enemySprite[enemystates.moveWithinAttackRange, enemydirection.down] = spr_enemy_fighter_run;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.right] = spr_enemy_fighter_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.up] = spr_enemy_fighter_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.left] = spr_enemy_fighter_light_melee;
		enemySprite[enemystates.lightMeleeAttack, enemydirection.down] = spr_enemy_fighter_light_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.right] = spr_enemy_fighter_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.up] = spr_enemy_fighter_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.left] = spr_enemy_fighter_heavy_melee;
		enemySprite[enemystates.heavyMeleeAttack, enemydirection.down] = spr_enemy_fighter_heavy_melee;
		enemySprite[enemystates.lightRangedAttack, enemydirection.right] = spr_enemy_fighter_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.up] = spr_enemy_fighter_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.left] = spr_enemy_fighter_light_ranged;
		enemySprite[enemystates.lightRangedAttack, enemydirection.down] = spr_enemy_fighter_light_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.right] = spr_enemy_fighter_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.up] = spr_enemy_fighter_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.left] = spr_enemy_fighter_heavy_ranged;
		enemySprite[enemystates.heavyRangedAttack, enemydirection.down] = spr_enemy_fighter_heavy_ranged;
		
		
		enemyStateSprite = enemystates.idle;
		enemyDirectionFacing = enemydirection.down;
		enemyImageIndex = 0.00;
		enemyImageIndexBaseSpeed = 0.3;
		enemyImageIndexSpeed = enemyImageIndexBaseSpeed * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		enemyAnimationX = 0;
		enemyAnimationY = 0;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxAttackType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, I set the hurtbox x and y coordinates,
		sprite_index, and image_index to equal that of its owner. 
		*/
		enemyHurtbox = instance_create_depth(x, y, -999, obj_hurtbox);
		enemyHurtbox.sprite_index = enemySprite[enemyStateSprite, enemyDirectionFacing];
		enemyHurtbox.image_index = enemyImageIndex;
		enemyHurtbox.visible = false;
		enemyHurtbox.owner = self;
		enemyGroundHurtbox = instance_create_depth(x, y + 13, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		
		#endregion
		break;
}


