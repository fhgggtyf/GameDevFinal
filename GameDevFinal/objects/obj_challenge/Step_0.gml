/// @description Insert description here
// You can write your code in this editor
var player = instance_find(obj_player,0);
if (global.manager_key_obtained){
	if(distance_to_object(player) <= 64) {
		instance_destroy();
	}
}