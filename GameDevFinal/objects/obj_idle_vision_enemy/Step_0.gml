/// @description Insert description here
// You can write your code in this editor
sm.update(self);

hmove_changed = hmove != prev_hmove;

event_inherited();

prev_hmove = hmove;

if (!first_detect && alert_val > alert_threshold) {
	first_detect = true;
	if (first_detect) {
		audio_play_sound_at(horror_sound_monster_breath_189934, x, y, 0, 100, 600, 1, false, 1);
	}
}
if (alert_val <= 0) {
	first_detect = false;
}


