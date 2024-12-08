/// @description Insert description here
// You can write your code in this editor
if ((room == EndMenu || room == Interroom_1 || room == Interroom_2) && global.door_opened) {
	for (var i = 0; i < max_door_amount; i += 1) {
		global.door_list[i] = false;
	}
	global.door_opened = false;
}