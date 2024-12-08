/// @description Insert description here
// You can write your code in this editor

if (room == MainMenu) {
	if (keyboard_check_pressed(vk_anykey)) {
		if (global.manager_key_obtained) {
			room_goto(GameLevel1_P);
		}
		else {
			room_goto(GameLevel1);
		}
	}
}

if (room == EndMenu) {
	if (keyboard_check_pressed(vk_anykey)) {
		room_goto(MainMenu);
	}
}