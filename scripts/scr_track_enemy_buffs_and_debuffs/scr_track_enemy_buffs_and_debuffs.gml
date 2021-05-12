///@description Track Active Poisons, Buffs, and Debuffs
function scr_track_enemy_buffs_and_debuffs() {
	// If the enemy is poisoned by any poison, this will be set to true by the end of this script
	poisoned = false;

#region Debuffs
	// True Caelesti Wings
	if trueCaelestiWingsDebuffTimer >= 0 {
		trueCaelestiWingsActive = true;
	}
	if trueCaelestiWingsActive {
		if trueCaelestiWingsDebuffTimer < 0 {
			trueCaelestiWingsActive = false;
			trueCaelestiWingsDebuffDamageMultiplier = 1;
			trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
		}
		else if trueCaelestiWingsDebuffTimer >= 0 {
			trueCaelestiWingsDebuffTimer--;
			// The multiplier is equal to the base amount plus the multiplier bonus times the amount of
			// times the multiplier bonus has been applied.
			// Base Amount + (Multiplier Bonus * amount of times Multiplier Bonus has been applied)
			trueCaelestiWingsDebuffDamageMultiplier = trueCaelestiWingsBaseDebuffDamageMultiplier + (trueCaelestiWingsDebuffDamageMultiplierAddedPerBasicMelee * trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded);
		}
	}
	else {
		trueCaelestiWingsDebuffDamageMultiplier = 1;
		trueCaelestiWingsDebuffNumberOfDamageMultipliersAdded = 0;
	}

	// Wrath of the Repentant
	if wrathOfTheRepentantDebuffTimer >= 0 {
		wrathOfTheRepentantActive = true;
	}
	if wrathOfTheRepentantActive {
		if wrathOfTheRepentantDebuffTimer < 0 {
			wrathOfTheRepentantActive = false;
			wrathOfTheRepentantMovementSpeedMultiplier = 1;
		}
		else if wrathOfTheRepentantDebuffTimer >= 0 {
			if wrathOfTheRepentantDebuffTimer >= 0 {
				wrathOfTheRepentantDebuffTimer--;
				wrathOfTheRepentantMovementSpeedMultiplier = wrathOfTheRepentantBaseMovementSpeedMultiplier;
			}
		}
	}
	else {
		wrathOfTheRepentantMovementSpeedMultiplier = 1;
	}

	// Angelic Barrage
	// This is set as true in the collision event with the hitbox; otherwise its set as false
	if angelicBarrageTicTimer >= 0 {
		angelicBarrageTicTimer--;
	}
	if angelicBarrageActive {
		angelicBarrageDamageMultiplier = angelicBarrageBaseDamageMultiplier;
		if angelicBarrageTicTimer < 0 {
			angelicBarrageTicTimer = angelicBarrageTicTimerStartTime;
			create_dot_tic_hitbox(self.id, obj_skill_tree.angelicBarrageDamage, true);
		}
	}
	else {
		angelicBarrageDamageMultiplier = 1;
	}
	// Set it as false after the above code blocks run. This way angelicBarrage is never active
	// unless an active collision is happening, which is what I want. This way the multiplier is 
	// also always active until 
	angelicBarrageActive = false;

	// Holy Defense
	if holyDefenseTimer >= 0 {
		holyDefenseActive = true;
	}
	if holyDefenseActive {
		if holyDefenseTimer < 0 {
			holyDefenseActive = false;
		}
		else if holyDefenseTimer >= 0 {
			holyDefenseTimer--;
			if holyDefenseTicTimer <= 0 {
				holyDefenseTicTimer = holyDefenseTicTimerStartTime;
				create_dot_tic_hitbox(self.id, holyDefenseDoTDamage, true);
			}
			else {
				holyDefenseTicTimer--;
			}
		}
	}

	// Bindings of the Caelesti
	if bindingsOfTheCaelestiTimer >= 0 {
		bindingsOfTheCaelestiActive = true;
	}
	if bindingsOfTheCaelestiActive {
		if bindingsOfTheCaelestiTimer < 0 {
			bindingsOfTheCaelestiActive = false;
			bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
		}
		else if bindingsOfTheCaelestiTimer >= 0 {
			bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = bindingsOfTheCaelestiBaseEnemyMovementSpeedMultiplier;
			bindingsOfTheCaelestiTimer--;
			if bindingsOfTheCaelestiTicTimer <= 0 {
				bindingsOfTheCaelestiTicTimer = bindingsOfTheCaelestiTicTimerStartTime;
				create_dot_tic_hitbox(self.id, bindingsOfTheCaelestiDamage, true);
			}
			else {
				bindingsOfTheCaelestiTicTimer--;
			}
		}
	}
	else {
		bindingsOfTheCaelestiEnemyMovementSpeedMultiplier = 1;
	}

	// Hidden Dagger Debuff
	if hiddenDaggerDamageMultiplierTimer >= 0 {
		hiddenDaggerDamageMultiplierActive = true;
	}
	if hiddenDaggerDamageMultiplierActive {
		if hiddenDaggerDamageMultiplierTimer < 0 {
			hiddenDaggerDamageMultiplierActive = false;
			hiddenDaggerDamageMultiplier = 1;
		}
		else if hiddenDaggerDamageMultiplierTimer >= 0 {
			hiddenDaggerDamageMultiplier = hiddenDaggerBaseDamageMultiplier;
			hiddenDaggerDamageMultiplierTimer--;
		}
	}
	else {
		hiddenDaggerDamageMultiplier = 1;
	}

	// Glinting Blade
	if glintingBladeTimer >= 0 {
		glintingBladeActive = true;
	}
	if glintingBladeActive {
		if glintingBladeTimer < 0 {
			glintingBladeActive = false;
			obj_skill_tree.glintingBladeActive = false;
			obj_skill_tree.glintingBladeAttachedToEnemy = noone;
			obj_skill_tree.glintingBladeXPos = 0;
			obj_skill_tree.glintingBladeYPos = 0;
		}
		else if glintingBladeTimer >= 0 {
			glintingBladeTimer--;
			obj_skill_tree.glintingBladeActive = true;
			obj_skill_tree.glintingBladeAttachedToEnemy = self.id;
			obj_skill_tree.glintingBladeXPos = x;
			obj_skill_tree.glintingBladeYPos = y;
		}
	}

	// Soul Tether
	if soulTetherTimer >= 0 {
		soulTetherActive = true;
	}
	if soulTetherActive {
		var remove_self_from_soul_tether_targets_ = false;
		if soulTetherTimer < 0 {
			soulTetherActive = false;
			remove_self_from_soul_tether_targets_ = true;
			if ds_exists(objectIDsInBattle, ds_type_list) {
				var i, other_soul_tether_found_;
				other_soul_tether_found_= false;
				for (i = 0; i <= ds_list_size(objectIDsInBattle) - 1; i++) {
					var instance_to_reference_ = ds_list_find_value(objectIDsInBattle, i);
					if instance_exists(instance_to_reference_) {
						if instance_to_reference_.combatFriendlyStatus == "Enemy" {
							if instance_to_reference_.soulTetherActive {
								other_soul_tether_found_ = true;
							}
						}
					}
				}
				if !other_soul_tether_found_ {
					obj_skill_tree.soulTetherTargetArray = noone;
				}
			}
		}
		else if soulTetherTimer >= 0 {
			soulTetherTimer--;
		}
		if (combatFriendlyStatus == "Minion") || (remove_self_from_soul_tether_targets_) {
			// Remove buff and self from the target array - I include this line in case the player
			// decided to mind control the enemy while the enemy is afflicted with Soul Tether, to avoid
			// Soul Tether debuff from affecting minions.
			var self_ = self.id;
			with obj_skill_tree {
				if is_array(soulTetherTargetArray) {
					var i, array_location_to_remove_;
					array_location_to_remove_ = -1;
					// Loop through the array, find self, deactive debuff, and mark the array location
					// to shift everything down 1.
					for (i = 0; i <= array_length_1d(soulTetherTargetArray) - 1; i++) {
						var instance_to_reference_ = soulTetherTargetArray[i];
						if instance_exists(instance_to_reference_) {
							if instance_to_reference_ == self.id {
								// Remove buff from self
								self_.soulTetherTimer = -1;
								self_.soulTetherActive = false;
								array_location_to_remove_ = i;
							}
						}
					}
					// Find the location of self in the target array, remove self, and shift above targets
					// down by 1 in the array.
					if array_location_to_remove_ != -1 {
						// Start the for loop at the location of the index to remove and end at the end
						// of the array.
						for (i = array_location_to_remove_; i <= array_length_1d(soulTetherTargetArray) - (array_location_to_remove_ + 1); i++) {
							if i != 2 {
								soulTetherTargetArray[i] = soulTetherTargetArray[i + 1];
							}
							// Else no matter what, since we're shifting the targets downwards, set this to
							// equal noone.
							else {
								soulTetherTargetArray[i] = noone;
							}
						}
					}
					// Check to see if the array is empty now. If it is, remove the array.
					var other_soul_tether_found_ = false;
					for (i = 0; i <= array_length_1d(soulTetherTargetArray) - 1; i++) {
						if instance_exists(soulTetherTargetArray[i]) {
							other_soul_tether_found_ = true;
						}
					}
					if !other_soul_tether_found_ {
						soulTetherTargetArray = noone;
					}
				}
			}
		}
	}
#endregion

#region Poisons
	// Sickly Proposition
	if sicklyPropositionTimer >= 0 {
		sicklyPropositionActive = true;
	}
	if sicklyPropositionActive {
		if sicklyPropositionTimer < 0 {
			sicklyPropositionActive = false;
		}
		else if sicklyPropositionTimer >= 0 {
			poisoned = true;
			sicklyPropositionTimer--;
			if sicklyPropositionTicTimer <= 0 {
				sicklyPropositionTicTimer = sicklyPropositionTicTimerStartTime;
				create_dot_tic_hitbox(self.id, sicklyPropositionDoTDamage, true);
			}
			else {
				sicklyPropositionTicTimer--;
			}
		}
	}

	///////////// Final Parting - DEBUFF IS APPLIED TO NEW TARGET IN THE scr_track_enemy_stats SCRIPT
	if finalPartingTimer >= 0 {
		finalPartingActive = true;
	}
	if finalPartingActive {
		if finalPartingTimer < 0 {
			finalPartingActive = false;
		}
		else if finalPartingTimer >= 0 {
			poisoned = true;
			finalPartingTimer--;
			if finalPartingTicTimer <= 0 {
				finalPartingTicTimer = finalPartingTicTimerStartTime;
				create_dot_tic_hitbox(self.id, finalPartingDamage, true);
			}
			else {
				finalPartingTicTimer--;
			}
		}
	}
	else {
		finalPartingNextTarget = noone;
	}


	// Dinner Is Served
	if dinnerIsServedTimer >= 0 {
		dinnerIsServedActive = true;
	}
	if dinnerIsServedActive {
		if dinnerIsServedTimer < 0 {
			dinnerIsServedActive = false;
			// If Dinner Is Served is not poisoning the enemy, reset values to default of 1
			dinnerIsServedEnemyManaRegenerationMultiplier = 1;
			dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
			dinnerIsServedEnemyMovementSpeedMultiplier = 1;
		}
		else if dinnerIsServedTimer >= 0 {
			dinnerIsServedEnemyManaRegenerationMultiplier = dinnerIsServedBaseEnemyManaRegenerationMultiplier;
			dinnerIsServedEnemyStaminaRegenerationMultiplier = dinnerIsServedBaseEnemyStaminaRegenerationMultiplier;
			dinnerIsServedEnemyMovementSpeedMultiplier = dinnerIsServedBaseEnemyMovementSpeedMultiplier;
			poisoned = true;
			dinnerIsServedTimer--;
			if dinnerIsServedTicTimer <= 0 {
				dinnerIsServedTicTimer = dinnerIsServedTicTimerStartTime;
				dinnerIsServedStartingDamage = dinnerIsServedStartingDamage * dinnerIsServedRampMultiplier;
				create_dot_tic_hitbox(self.id, dinnerIsServedStartingDamage, true);
			}
			else {
				dinnerIsServedTicTimer--;
			}
		}
	}
	else {
		// If Dinner Is Served is not poisoning the enemy, reset values to default of 1
		dinnerIsServedEnemyManaRegenerationMultiplier = 1;
		dinnerIsServedEnemyStaminaRegenerationMultiplier = 1;
		dinnerIsServedEnemyMovementSpeedMultiplier = 1;
	}


	// Exploit Weakness
	if exploitWeaknessTimer >= 0 {
		exploitWeaknessActive = true;
	}
	if exploitWeaknessActive {
		if exploitWeaknessDamageToAdd > 0 {
			exploitWeaknessDoTDamage += exploitWeaknessDamageToAdd;
			exploitWeaknessDamageToAdd = 0;
		}
		if exploitWeaknessTimer < 0 {
			exploitWeaknessActive = false;
			exploitWeaknessDoTDamage = 0;
			exploitWeaknessDamageToAdd = 0;
		}
		else if exploitWeaknessTimer >= 0 {
			poisoned = true;
			exploitWeaknessTimer--;
			if exploitWeaknessTicTimer <= 0 {
				exploitWeaknessTicTimer = exploitWeaknessTicTimerStartTime;
				create_dot_tic_hitbox(self.id, exploitWeaknessDoTDamage, true);
			}
			else {
				exploitWeaknessTicTimer--;
			}
		}
	}
#endregion

#region Stuns
	// Hidden Dagger Poison and Stun
	if hiddenDaggerTicTimer >= 0 {
		hiddenDaggerActive = true;
	}
	if hiddenDaggerActive {
		if hiddenDaggerTicTimer < 0 {
			stunTimer = obj_skill_tree.hiddenDaggerStunDuration;
			hiddenDaggerDamageMultiplierTimer = hiddenDaggerDamageMultiplierTimerStartTime;
			hiddenDaggerActive = false;
		}
		else if hiddenDaggerTicTimer >= 0 {
			poisoned = true;
			hiddenDaggerTicTimer--;
		}
	}
#endregion





}
