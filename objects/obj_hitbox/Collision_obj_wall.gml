/// @description Destroy object if collision found with wall
var owner_is_player_, owner_is_enemy_;
owner_is_player_ = false;
owner_is_enemy_ = false;

// Determine whether the owner of the hitbox is the player or enemy
if owner.object_index == obj_player {
	owner_is_player_ = true;
}
else if owner.object_index == obj_enemy {
	owner_is_enemy_ = true;
}

// Destroy the hitbox if it collides with a wall AND its a projectile or something that should
// be destroyed upon collision
if owner_is_player_ {
	if playerHitboxAttackType == "Projectile" {
		if playerHitboxAbilityOrigin != "Taken for Pain" {
			playerHitboxCollisionFound = true;
			playerHitboxCollidedWithWall = true;
		}
		else if !obj_skill_tree.takenForPainFirstPhaseActive {
			playerHitboxCollisionFound = true;
			playerHitboxCollidedWithWall = true;
		}
	}
}
else if owner_is_enemy_ {
	if enemyHitboxAttackType == "Projectile" {
		enemyHitboxCollisionFound = true;
		enemyHitboxCollidedWithWall = true;
	}
}


