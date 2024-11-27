/// @description Insert description here
// You can write your code in this editor

//open text box if colliding with player
if (place_meeting(x, y, obj_player)) {
	if (created == noone) {
		created = instance_create_layer(camera_get_view_x(view_camera[0]) + 512, camera_get_view_y(view_camera[0]) + 100, "Text", obj_textbox);
		created.text = my_text;
	}
}
else {
	if (created != noone) {
		instance_destroy(created);
		created = noone;
	}
}