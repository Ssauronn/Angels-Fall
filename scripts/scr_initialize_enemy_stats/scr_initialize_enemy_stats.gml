///@argument0 enemyName

var enemy_name_ = argument0;
switch (enemy_name_) {
	case "Mage":
		#region Mage
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 1000;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 1000;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.5) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 1000;
		enemyManaRegeneration = (enemyMaxMana * 0.5) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // + whatever resitances the player has
		enemyTotalBonusResistance = 0;

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
		

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_mage_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_mage_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_mage_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_mage_run;
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
		alreadyHit = -1;
		alreadyHitTimer = -1;
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, we set the hurtbox x and y coordinates,
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
		// Speed variable for specific enemies
		enemyGameSpeed = 1;
		enemyTotalSpeed = 1;
		#region Stats and Damage Values
		// Base Stats (HP, Stamina, Mana)
		enemyMaxHP = 1000;
		enemyHPRegeneration = 0 / room_speed;
		enemyCurrentHP = enemyMaxHP;
		enemyMaxStamina = 1000;
		enemyStaminaRegeneration = (enemyMaxStamina * 0.5) / room_speed;
		enemyTimeUntilNextStaminaAbilityUsableTimerSet = false;
		enemyTimeUntilNextStaminaAbilityUsableTimer = 0;
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 1000;
		enemyManaRegeneration = (enemyMaxMana * 0.5) / room_speed;
		enemyTimeUntilNextManaAbilityUsableTimerSet = false;
		enemyTimeUntilNextManaAbilityUsableTimer = 0;
		enemyCurrentMana = enemyMaxMana;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // + whatever resitances the player has
		enemyTotalBonusResistance = 0;

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 50;
		enemyHeavyMeleeAttackDamage = 100;
		enemyLightRangedAttackDamage = 50;
		enemyHeavyRangedAttackDamage = 100;
		enemyHealValue = 300;

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

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy_healer_idle;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy_healer_idle;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.right] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.up] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.left] = spr_enemy_healer_run;
		enemySprite[enemystates.passivelyFollowPlayer, enemydirection.down] = spr_enemy_healer_run;
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
		alreadyHit = -1;
		alreadyHitTimer = -1;
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyHitbox = noone;
		// Possible hitbox types are: "Projectile", "Target", "Target AoE", "Melee"
		enemyHitboxType = "";
		// If this is set to true, that's a switch telling the collisions to heal the correct targets
		// instead of dealing damage to enemies
		enemyHitboxHeal = false;
		if instance_exists(obj_player) {
			enemyProjectileHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyProjectileHitboxDirection = 0;
		
		// Enemy Hurtbox Creation and Variable Setting
		/*
		In the step event for each enemy object, we set the hurtbox and ground hurtbox 
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
}


