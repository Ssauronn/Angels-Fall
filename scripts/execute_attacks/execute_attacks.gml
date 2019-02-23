switch (lastAttackButtonPressed) {
	case "Attack Right 1":
	case "Attack Up 1":
	case "Attack Left 1":
	case "Attack Down 1":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack1;
		playerStateSprite = playerstates.attack1;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Attack Right 2":
	case "Attack Up 2":
	case "Attack Left 2":
	case "Attack Down 2":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack2;
		playerStateSprite = playerstates.attack2;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Attack Right 3":
	case "Attack Up 3":
	case "Attack Left 3":
	case "Attack Down 3":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack3;
		playerStateSprite = playerstates.attack3;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Attack Right 4":
	case "Attack Up 4":
	case "Attack Left 4":
	case "Attack Down 4":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack4;
		playerStateSprite = playerstates.attack4;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Attack Right 5":
	case "Attack Up 5":
	case "Attack Left 5":
	case "Attack Down 5":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack5;
		playerStateSprite = playerstates.attack5;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Attack Right 6":
	case "Attack Up 6":
	case "Attack Left 6":
	case "Attack Down 6":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.attack6;
		playerStateSprite = playerstates.attack6;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina -= meleeStaminaCost;
		playerCurrentMana += meleeManaRegen;
		break;
	case "Skillshot Magic Right":
	case "Skillshot Magic Up":
	case "Skillshot Magic Left":
	case "Skillshot Magic Down":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.skillshotmagic;
		playerStateSprite = playerstates.skillshotmagic;
		lastAttackButtonPressed = "";
		playerImageIndex = 0;
		playerCurrentStamina += magicStaminaRegen;
		playerCurrentMana -= magicManaCost;
		break;
	case "Skillshot Magic Combo Right":
	case "Skillshot Magic Combo Up":
	case "Skillshot Magic Combo Left":
	case "Skillshot Magic Combo Down":
		set_movement_variables(0, playerDirectionFacing, maxSpeed);
		playerState = playerstates.skillshotmagic;
		playerStateSprite = playerstates.skillshotmagic;
		lastAttackButtonPressed = "";
		playerImageIndex = 5;
		playerCurrentStamina += magicStaminaRegen;
		playerCurrentMana -= magicManaCost;
		break;
}


