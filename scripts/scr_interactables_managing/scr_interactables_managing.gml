/// Manage animations and background logic for interactables
// Count down dialogue timers if any exist
if interactableDialogueTimer >= 0 {
	interactableDialogueActive = true;
	interactableDialogueTimer--;
	if interactableDialogueTimer < 0 {
		dialogueOpen = false;
		interactableDialogueActive = false;
	}
}

if interactableName == "Dissolve Door 1" {
	if !interactableBasicActive {
		interactableImageIndex = 0;
		interactableImageIndexSpeed = 0;
		image_index = interactableImageIndex;
		image_speed = interactableImageIndexSpeed;
	}
}


