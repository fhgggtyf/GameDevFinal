/// @description Insert description here
// You can write your code in this editor
audio_play_sound(door_click, 1, false);
if (!readable_safe) {
	instance_destroy(instance_nearest(x, y, obj_readable));
}