/// @description Player Step Event
// Call input script
scr_player_input();
// Call script used to change player between attack scripts
execute_attacks();

// Track All Buffs and Debuffs
scr_track_player_buffs_and_debuffs();
// Track All Stats
scr_track_player_stats();



