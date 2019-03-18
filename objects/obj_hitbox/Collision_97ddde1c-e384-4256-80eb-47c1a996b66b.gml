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

// Destroy the hitbox if it collides with a wall AND its a projectile
if owner_is_player_ {
	if playerHitboxType == "Projectile" {
		playerHitboxCollisionFound = true;
	}
}
else if owner_is_enemy_ {
	if enemyHitboxType == "Projectile" {
		enemyHitboxCollisionFound = true;
	}
}



