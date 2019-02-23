///@argument0 enemyName

var enemy_name_ = argument0;
switch (enemy_name_) {
	case "Mage": 
		
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
		enemyLightMeleeAttackRange = 1500;
		enemyHeavyMeleeAttackRange = 1500;
		enemyLightRangedAttackRange = camera_get_view_height(camera);
		enemyHeavyRangedAttackRange = camera_get_view_height(camera);
		#endregion
		
		// Enemy Movement Variables
		currentDirection = 0;
		baseMaxSpeed = obj_player.baseMaxSpeed * 1;
		maxSpeed = baseMaxSpeed * enemyTotalSpeed;
		currentSpeed = 0;

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.down] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.down] = spr_enemy;
		
		
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
		enemyGroundHurtbox = instance_create_depth(x, y + 450, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		#region Enemy Scripts to Use Table and Script Setting Variables
		scrAttack1 = scr_mage_attack1;
		scrAttack2 = scr_mage_attack2;
		scrAttack3 = scr_mage_attack3;
		scrAttack4 = scr_mage_attack4;
		#endregion
		break;
	
	case "Healer": 
		
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

		// Enemies Attacks' Resrouces Costs
		enemyLightMeleeAttackStamCost = enemyMaxStamina * 0.6;
		enemyHeavyMeleeAttackStamCost = enemyMaxStamina * 0.9;
		enemyLightRangedAttackManaCost = enemyMaxMana * 0.6;
		enemyHeavyRangedAttackManaCost = enemyMaxMana * 0.9;
		
		// Enemies' Attack Ranges
		enemyLightMeleeAttackRange = 1500;
		enemyHeavyMeleeAttackRange = 1500;
		enemyLightRangedAttackRange = camera_get_view_height(camera);
		enemyHeavyRangedAttackRange = camera_get_view_height(camera);
		#endregion
		
		// Enemy Movement Variables
		currentDirection = 0;
		baseMaxSpeed = obj_player.baseMaxSpeed * 1;
		currentSpeed = 0;

		#region Enemy Sprite Table and Sprite Setting Variables
		enemySprite[enemystates.idle, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.idle, enemydirection.down] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.melee, enemydirection.down] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.right] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.up] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.left] = spr_enemy;
		enemySprite[enemystates.magic, enemydirection.down] = spr_enemy;
		
		
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
		enemyGroundHurtbox = instance_create_depth(x, y + 450, -999, obj_ground_hurtbox);
		enemyGroundHurtbox.sprite_index = spr_ground_hurtbox;
		enemyGroundHurtbox.image_index = 0;
		enemyGroundHurtbox.visible = false;
		enemyGroundHurtbox.owner = self;
		#endregion
		#region Enemy Scripts to Use Table and Script Setting Variables
		scrAttack1 = scr_healer_attack1;
		scrAttack2 = scr_healer_attack2;
		scrAttack3 = scr_healer_attack3;
		scrAttack4 = scr_healer_attack4;
		#endregion
		break;
	
}


