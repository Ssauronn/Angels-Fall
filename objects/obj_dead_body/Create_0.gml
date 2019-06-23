/// @description Create Dead Body Variables
deadBodySprite = spr_dead_body;
deadBodyImageIndex = 0;
sprite_index = deadBodySprite;
image_index = deadBodyImageIndex;
deadBodyNumberOfFramesInDeathAnimation = sprite_get_number(deadBodySprite);
deadBodyImageIndexBaseSpeed = 0.3;
deadBodyImageIndexSpeed = deadBodyImageIndexBaseSpeed;

// Variables belonging to the object it was created from (the object that died)
combatFriendlyStatus = "";
objectArchetype = "";
enemyName = "";

// Variable used to control if the object is being resurrected, and by whom
deadBodyBeingResurrected = false;
deadBodyResurrectionSprite = spr_dead_body;
deadBodyResurrectedBy = noone;


