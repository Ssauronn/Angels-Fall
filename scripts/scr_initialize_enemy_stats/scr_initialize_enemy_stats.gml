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
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 1000;
		enemyManaRegeneration = (enemyMaxMana * 0.5) / room_speed;
		enemyCurrentMana = enemyMaxMana;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // + whatever resitances the player has
		enemyTotalBonusResistance = 0;

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 100;
		enemyHeavyMeleeAttackDamage = 200;
		enemyLightRangedAttackDamage = 100;
		enemyHeavyRangedAttackDamage = 200;

		// Enemies' Attack Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.6;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.9;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.6;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 0.9;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32;
		enemyHeavyMeleeAttackRange = 32;
		enemyLightRangedAttackRange = camera_get_view_height(view_camera[0]);
		enemyHeavyRangedAttackRange = camera_get_view_height(view_camera[0]);
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 1;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		myPath = undefined;

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
		enemyImageIndexSpeed = 0.3 * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		alreadyHit = -1;
		alreadyHitTimer = -1;
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyBulletHitbox = noone;
		if instance_exists(obj_player) {
			enemyBulletHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyBulletHitboxDirection = 0;
		
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
		enemyGroundHurtbox = instance_create_depth(x, y + (32 / 2) - (32 / 5), -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		#region Enemy Scripts to Use Table and Script Setting Variables
		scrMoveWithinAttackRange = scr_move_within_attack_range()
		scrAttack1 = scr_mage_light_melee();
		scrAttack2 = scr_mage_heavy_melee();
		scrAttack3 = scr_mage_light_ranged();
		scrAttack4 = scr_mage_heavy_ranged();
		scrHealAlly = noone;
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
		enemyCurrentStamina = enemyMaxStamina;
		enemyMaxMana = 1000;
		enemyManaRegeneration = (enemyMaxMana * 0.5) / room_speed;
		enemyCurrentMana = enemyMaxMana;

		// Enemies' Bonus Damage and Resistance
		enemyTotalBonusDamage = 1; // + whatever resitances the player has
		enemyTotalBonusResistance = 0;

		// Enemies' Attack Damages and Resistances
		enemyLightMeleeAttackDamage = 100;
		enemyHeavyMeleeAttackDamage = 200;
		enemyLightRangedAttackDamage = 100;
		enemyHeavyRangedAttackDamage = 200;
		enemyHealValue = 300;

		// Enemies Attacks' Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.6;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.9;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.5;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 0.8;
		enemyHealManaCost = enemyMaxMana * 0.9;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 32;
		enemyHeavyMeleeAttackRange = 32;
		enemyLightRangedAttackRange = camera_get_view_height(view_camera[0]);
		enemyHeavyRangedAttackRange = camera_get_view_height(view_camera[0]);
		enemyHealRange = camera_get_view_height(view_camera[0]);
		#endregion
		
		// Enemy Movement Variables
		baseMaxSpeed = obj_player.baseMaxSpeed * 1;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		baseFrictionAmount = maxSpeed * 2.700;
		frictionAmount = baseFrictionAmount * enemyTotalSpeed;
		baseAcceleration = maxSpeed * 0.250;
		acceleration = baseAcceleration * enemyTotalSpeed;
		currentSpeed = 0;
		currentDirection = 0;
		collisionFound = -1;
		myPath = undefined;

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
		enemyImageIndexSpeed = 0.3 * enemyTotalSpeed;
		enemyAnimationImageIndex = 0.00;
		enemyAnimationSprite = noone;
		#endregion
		#region Hitbox and Hurtbox Variables
		// Enemy Hitbox variables
		alreadyHit = -1;
		alreadyHitTimer = -1;
		hitboxCreated = false;

		// Enemy Hitbox variables cont.
		enemyBulletHitbox = noone;
		if instance_exists(obj_player) {
			enemyBulletHitboxSpeed = obj_player.maxSpeed * 1.1;
		}
		enemyBulletHitboxDirection = 0;
		
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
		enemyGroundHurtbox = instance_create_depth(x, y + (32 / 2) - (32 / 5), -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		#region Enemy Scripts to Use Table and Script Setting Variables
		scrMoveWithinAttackRange = scr_move_within_attack_range();
		scrAttack1 = scr_healer_light_melee();
		scrAttack2 = scr_healer_heavy_melee();
		scrAttack3 = scr_healer_light_ranged();
		scrAttack4 = scr_healer_heavy_ranged();
		scrHealAlly = scr_healer_heal_ally();
		#endregion
		
		#endregion
		break;
}


