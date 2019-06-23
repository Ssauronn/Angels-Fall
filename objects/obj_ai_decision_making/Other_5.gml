/// @description Destroy DS_LISTS
if ds_exists(objectIDsInBattle, ds_type_list) {
	ds_list_destroy(objectIDsInBattle);
	objectIDsInBattle = -1;
}
if ds_exists(objectIDsFollowingPlayer, ds_type_list) {
	ds_list_destroy(objectIDsFollowingPlayer);
	objectIDsFollowingPlayer = -1;
}


