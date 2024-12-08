/// @description Insert description here
// You can write your code in this editor
array_push(global.door_opened_x , x + 0.5 * sprite_width * image_xscale);
array_push(global.door_opened_y , y + 0.5 * sprite_height * image_yscale);
if (!readable_safe) {
	instance_destroy(instance_nearest(x, y, obj_readable));
}