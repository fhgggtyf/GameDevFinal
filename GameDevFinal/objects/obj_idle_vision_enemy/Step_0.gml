/// @description Insert description here
// You can write your code in this editor
sm.update(self);

hmove_changed = hmove != prev_hmove;

event_inherited();

prev_hmove = hmove;

//if (eb.condition_scanned.check && !first_detect) {
//	first_detect = true;
//	if (first_detect) {
//		audio_play_sound_at(horror_sound_monster_breath_189934, x, y, 0, 100, 600, 1, false, 1);
//	}
//}

