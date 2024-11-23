/// @description Insert description here
// You can write your code in this editor
hmove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
jump_press = keyboard_check_pressed(vk_space);

//do actions (see obj_actor)
event_inherited();

if(keyboard_check_pressed(ord("W"))){
	light_opened = !light_opened;
}

handle_collision_modifier(self, "LightNoise", "noise", light_source.clear_rad, calc_add, light_opened);
if(light_opened){
	instance_activate_object(light_source);
}
else{
	instance_deactivate_object(light_source);
}

light_source.x = x;
light_source.y = y;

if(platform != -1){
	handle_collision_modifier(self, "GroundNoise", "noise", platform.noise_multiplier, calc_multiply, moving);
}



