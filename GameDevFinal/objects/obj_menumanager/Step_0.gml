/// @description Insert description here
// You can write your code in this editor

if (room == MainMenu) {
	if (keyboard_check_pressed(vk_anykey)) {
		room_goto_next();
	}
}

if (room == EndMenu) {
	if (keyboard_check_pressed(vk_anykey)) {
		room_goto(MainMenu);
	}
}