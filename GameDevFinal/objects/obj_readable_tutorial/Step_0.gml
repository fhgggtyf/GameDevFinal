/// @description Insert description here
// You can write your code in this editor

//open text box if colliding with player
if (place_meeting(x, y, obj_player)) {
	if (created == noone) {
		created = instance_create_layer(452, 2500-384, "Text", obj_textbox);
		created.text = my_text;
	}
}
else {
	if (created != noone) {
		instance_destroy(created);
		created = noone;
	}
}