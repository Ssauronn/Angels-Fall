/// @description Draw Self and Animations
if sprite_exists(self.sprite_index) {
	draw_self();
}

if (interactableBasicActive) || (interactableMenuActive) || (interactableDialogueActive) {
	if (interactableOpensMenu) || (interactableOpensDialogue) {
		scr_interactables_with_menu();
	}
	else {
		scr_interactables_with_no_menu();
	}
}


