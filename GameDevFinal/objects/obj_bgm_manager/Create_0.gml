/// @description Insert description here
// You can write your code in this editor
if (!audio_is_playing(horror_background_atmosphere_156462)) {
	audio_play_sound(horror_background_atmosphere_156462, 10, true);
}
if (room != MainMenu && audio_is_playing(factory_fluorescent_light_buzz_6871)) {
	audio_stop_sound(factory_fluorescent_light_buzz_6871);
}