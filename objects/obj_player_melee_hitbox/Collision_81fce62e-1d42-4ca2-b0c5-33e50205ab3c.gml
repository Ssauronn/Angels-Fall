/// @description Deal damage to enemies
var other_owner_ = other.owner;
var self_ = self;
with (other_owner_) {
	if (alreadyHit == -1) || (alreadyHitTimer <= 0) {
		if combatFriendlyStatus == "Enemy" {
			enemyCurrentHP -= 100 * playerTotalBonusDamage;
			// This sets the variable located inside the obj_enemy being attacked to the amount of frames
			// the attack that just landed will take to finish. This means that because we check earlier 
			// if alreadyHit is below 0, and we reduce already by 1 every frame of the game in obj_enemy
			// step event, every obj_enemy will be able to be attacked by another hitbox the frame after
			// the current hitbox ends.
			with (obj_player) {
				other_owner_.alreadyHit = self_;
				other_owner_.alreadyHitTimer = 0.8 * room_speed;
			}
			// I multiply the addition to the amount of enemies dealt damage by the percentage I multiply player
			// bonus damage by while prime ability is active because I don't want to punish the player by limiting
			// the amount of the combo meter while this is active (because the player kills the enemies with less
			// hits). Essentially, upping the damage should not decrease the amount of "combo" the player can land
			// on the enemy, so I increase the amount the combo meter goes up by proportional to the amount I
			// increase the player damage by
			enemiesDealtDamage += 1 + (1 * obj_skill_tree.primeBonusDamagePercentAsDecimal);
			lastEnemyHitByPlayer = other_owner_;
			// Track the player's attack pattern's (melee or ranged) based on whether the attack was melee or ranged
			if !(obj_ai_decision_making.playerAttackPatternWeight + (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack) > (obj_ai_decision_making.attackPatternStartWeight * 2)) {
				obj_ai_decision_making.playerAttackPatternWeight += (obj_ai_decision_making.attackPatternStartWeight / obj_ai_decision_making.numberOfPlayerAttacksToTrack);
			}
		}
	}
}


