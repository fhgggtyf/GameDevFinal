/// @description Insert description here
// You can write your code in this editor

//open text box if colliding with player
if (place_meeting(x, y, obj_player)) {
	if (created == noone && mouse_check_button_pressed(mb_left)) {
		created = instance_create_layer(mouse_x, mouse_y, "Text", obj_textbox);
		created.text = my_text;
	}
	else if (created != noone &&  mouse_check_button_pressed(mb_left)) {
		instance_destroy(created);
		created = noone;
	}
}
else {
	if (created != noone) {
		instance_destroy(created);
		created = noone;
	}
}