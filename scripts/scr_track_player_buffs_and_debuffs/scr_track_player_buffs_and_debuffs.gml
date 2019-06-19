///@description Track All Buffs and Debuffs That Effect Player Bonus Damage and Resistance
with obj_skill_tree {
	#region Buffs
	#region Tier 1 Abilities
	#region True Caelesti Wings
	if trueCaelestiWingsTimer >= 0 { 
		trueCaelestiWingsActive = true;
	}
	if trueCaelestiWingsActive {
		if trueCaelestiWingsTimer < 0 {
			trueCaelestiWingsActive = false;
			trueCaelestiWingsDamageMultiplier = 1;
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					instance_to_reference_.trueCaelestiWingsDebuffTimer = -1;
					instance_to_reference_.trueCaelestiWingsDebuffDamageMultiplier = 1;
					instance_to_reference_.trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
				}
			}
		}
		else if trueCaelestiWingsTimer >= 0 {
			trueCaelestiWingsTimer--;
			trueCaelestiWingsDamageMultiplier = trueCaelestiWingsBaseDamageMultiplier;
		}
	}
	
	#region Death Incarnate
	if !deathIncarnateFirstPhaseActive && !deathIncarnateSecondPhaseActive {
		deathIncarnateSecondPhaseCurrentDamage = deathIncarnateSecondPhaseStartDamage;
	}
	// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
	// Just put this here to find it later. I need to reset deathIncarnateSecondPhaseCurrentDamage to
	// equal deathIncarnateSecondPhaseStartDamage if the second phase is currently active and the player
	// sends out a new death incarnate, immediately setting to firstphaseactive without both ever being 
	// not active on either phase and resetting the current damage in the line above.
	#endregion
	#endregion
	#endregion
	
	#region Tier 2 Abilities
	#region Armor of the Caelesti
	if armorOfTheCaelestiTimer >= 0 {
		armorOfTheCaelestiActive = true;
	}
	if armorOfTheCaelestiActive {
		if armorOfTheCaelestiRemainingHPBeforeExplosion <= 0 {
			armorOfTheCaelestiActive = false;
			armorOfTheCaelestiTimer = -1;
			armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
			// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
		}
		if armorOfTheCaelestiTimer < 0 {
			armorOfTheCaelestiActive = false;
			armorOfTheCaelestiRemainingHPBeforeExplosion = 0;
		}
		else if armorOfTheCaelestiTimer >= 0 {
			armorOfTheCaelestiTimer--;
			armorOfTheCaelestiResistanceMultiplier = armorOfTheCaelestiBaseResistanceMultiplier;
		}
	}
	#endregion
	
	#region Glinting Blade
	if glintingBladeTimer >= 0 {
		if glintingBladeAttachedToEnemy == noone {
			glintingBladeActive = true;
		}
	}
	if glintingBladeActive {
		if glintingBladeAttachedToEnemy == noone {
			if glintingBladeTimer < 0 {
				glintingBladeActive = false;
				glintingBladeArrivedAtTargetPos = false;
				glintingBladeTargetXPos = 0;
				glintingBladeTargetYPos = 0;
				glintingBladeXPos = 0;
				glintingBladeYPos = 0;
			}
			else if glintingBladeTimer >= 0 {
				glintingBladeTimer--;
			}
		}
	}
	#endregion
	#endregion
	
	#region Tier 3 Abilities
	#region All Out Attack
	if allOutAttackTimer >= 0 {
		allOutAttackActive = true;
	}
	if allOutAttackActive {
		if allOutAttackTimer < 0 {
			allOutAttackActive = false;
		}
		else if allOutAttackTimer >= 0 {
			allOutAttackTimer--;
		}
	}
	#endregion
	
	#region Purifying Rage
	if purifyingRageTimer >= 0 {
		purifyingRageActive = true;
	}
	if purifyingRageActive {
		if purifyingRageTimer < 0 {
			purifyingRageActive = false;
			purifyingRageDamageMultiplierForPoisons = 1;
		}
		else if purifyingRageTimer >= 0 {
			purifyingRageTimer--;
			purifyingRageDamageMultiplierForPoisons = purifyingRageBaseDamageMultiplierForPoisons;
		}
	}
	#endregion
	
	#region Holy Defense
	if holyDefenseTimer >= 0 {
		holyDefenseActive = true;
	}
	if holyDefenseActive {
		if holyDefenseTimer < 0 {
			holyDefenseActive = false;
			holyDefenseDamage = 0;
		}
		else if holyDefenseTimer >= 0 {
			holyDefenseTimer--;
			holyDefenseDamage = holyDefenseBaseDamage;
		}
	}
	#endregion
	
	#region Wrath of the Repentant
	if wrathOfTheRepentantTimer >= 0 {
		wrathOfTheRepentantActive = true;
	}
	if wrathOfTheRepentantActive {
		if wrathOfTheRepentantTimer < 0 {
			wrathOfTheRepentantActive = false
			wrathOfTheRepentantBasicMeleeDamageBonus = 1;
		}
		else if wrathOfTheRepentantTimer >= 0 {
			wrathOfTheRepentantBasicMeleeDamageBonus = wrathOfTheRepentantBaseBasicMeleeDamageBonus;
		}
	}
	#endregion
	
	#region The One Power
	if theOnePowerTimer >= 0 {
		theOnePowerActive = true;
	}
	if theOnePowerActive {
		if theOnePowerTimer < 0 {
			theOnePowerActive = false;
		}
		else if theOnePowerTimer >= 0 {
			theOnePowerTimer--;
			theOnePowerOriginXPos = obj_player.x + lengthdir_x(theOnePowerRotationDistanceFromPlayer, theOnePowerRotationAngle);
			theOnePowerOriginYPos = obj_player.y + lengthdir_y(theOnePowerRotationDistanceFromPlayer, theOnePowerRotationAngle);
			theOnePowerRotationAngle += 360 / (theOnePowerRotationTimeForAFullCircle);
			if theOnePowerRotationAngle >= 360 {
				theOnePowerRotationAngle -= 360;
			}
			if theOnePowerTicTimer < 0 {
				// APPLY DAMAGE / CREATE HITBOX / APPLY BUFF / APPLY DEBUFF
				// Here, create a projectile with an origin point at theOnePowerOriginXPos and
				// theOnePowerOriginYPos, and with a direction towards the nearest enemy, as long as
				// the nearest enemy is within theOnePowerRange, and a speed of
				// theOnePowerPorjectileSpeed.
			}
			else if theOnePowerTicTimer >= 0 {
				theOnePowerTicTimer--;
			}
		}
	}
	#endregion
	
	#region Lightning Spear
	if lightningSpearBasicMeleeDamageMultiplierActive {
		lightningSpearBasicMeleeDamageMultiplier = lightningSpearBaseBasicMeleeDamageMultiplier;
	}
	else if !lightningSpearBasicMeleeDamageMultiplierActive {
		lightningSpearBasicMeleeDamageMultiplier = 1;
	}
	#endregion
	#endregion
	
	#region Tier 4 Abilities
	#region Rushdown
	if rushdownDashDamageMultiplierActive {
		rushdownDashDamageMultiplier = rushdownDashBaseDamageMultiplier;
	}
	else if !rushdownDashDamageMultiplierActive {
		rushdownDashDamageMultiplier = 1;
	}
	#endregion
	#endregion
	#endregion


	#region Debuffs

	#endregion


	#region Poisons

	#endregion


	#region Stuns

	#endregion
}


