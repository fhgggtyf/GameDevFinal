/// @description Insert description here
// You can write your code in this editor
var player = instance_find(obj_player,0);
if (global.door_list[door_number]){
	if(!door_registered){
		array_push(global.door_opened_x, x + 0.5 * sprite_width * image_xscale);
		array_push(global.door_opened_y, y + 0.5 * sprite_height * image_yscale);
		door_registered = true;
	}
	if(distance_to_object(player) <= 150) {
		instance_destroy();
	}
}