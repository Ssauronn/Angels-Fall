/// @description Set up interaction variables
// Non Menu / Universal Variables
interactableName = "";
interactableBasicActive = false;
interactableSolid = false;
interactableWall = noone;
interactableWallUpdateTimer = -1;
interactableWallUpdateTimerStartTime = room_speed;
interactableImageIndex = 0;
interactableImageIndexSpeed = obj_player.playerImageIndexSpeed;
interactableBasicPhase = -1;
interactableRange = 32 * 2;
interactableWithinRange = false;
interactableXLocation = -1;
interactableYLocation = -1;

// Menu Variables
interactableOpensMenu = false;
interactableMenuActive = false;
interactableMenuPhase = -1;

// Dialogue Variables
interactableOpensDialogue = false;
interactableDialogueActive = false;
interactableDialoguePhase = -1;
interactableDialogueTimer = -1;
interactableDialogueTimerStartTime = room_speed * 2;



