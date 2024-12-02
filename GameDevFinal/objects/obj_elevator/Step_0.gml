/// @description Insert description here
// You can write your code in this editor
var triggered = place_meeting(x + 0.5 * (bbox_right - bbox_left), y - 1, obj_player);

if(triggered){
	vspeed -= 0.3;
	var player = instance_find(obj_player,0);
	player.yspd = vspeed;
}