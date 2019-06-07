/// @description Draw Combo Counter and Animecro Multiplier
if comboCounterTimer > 0 {
	if (animecroPool > 0) || (bloodMagicPool > 0) {
		draw_set_alpha(1)
	}
	else {
		draw_set_alpha(0.5)
	}
	draw_ring_healthbar(32, 64, 32, 4, 100, (comboCounterTimer / comboCounterTimerStartTime) * 100, 90, 360, 1, c_red);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_text_ext_transformed(32, 64, string(animecroMultiplier) + "x", 0, 400, 1, 1, 0);
	draw_set_halign(fa_left);
	draw_set_halign(fa_top);
}
if obj_skill_tree.crawlOfTormentActive {
	draw_ring_healthbar(display_get_gui_width() - 40, 64, 32, 4, 100, (obj_skill_tree.crawlOfTormentTimer / obj_skill_tree.crawlOfTormentTimerStartTime) * 100, 90, 360, -1, c_blue);
}


