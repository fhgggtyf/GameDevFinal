/// @description Insert description here
// You can write your code in this editor
with(other){
	if(global.manager_key_obtained){
		room_goto(Interroom_1);
	}
	else{
		room_goto(EndMenu);
	}
}