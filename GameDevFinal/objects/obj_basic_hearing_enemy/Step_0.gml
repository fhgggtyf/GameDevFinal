/// @description Insert description here
// You can write your code in this editor
event_inherited();

sm.update(self);

if (!first_detect && alert_val > alert_threshold) {
	first_detect = true;
	if (first_detect) {
		//audio_play_sound(monster_appearing_sound_41450, 3, false);
		audio_play_sound_at(monster_appearing_sound_41450, x, y, 0, 100, 600, 1, false, 1);
	}
}
if (alert_val <= 0) {
	first_detect = false;
}
