/// @description Insert description here
// You can write your code in this editor
hmove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
jump_press = keyboard_check_pressed(ord("W"));
sprinting = keyboard_check(vk_shift) && !injured;
crouching = keyboard_check(ord("C"));
if (crouching && sprinting) crouching = sprinting = false;

top = bbox_top + (image_index == 1 ? 0.5 : 0) * sprite_height;
bot=bbox_bottom;
left=bbox_left;
right = bbox_right;
midl = [bbox_left, top + (image_index == 1 ? 0.25 : 0.5) * sprite_height];
midr = [bbox_right, top + (image_index == 1 ? 0.25 : 0.5) * sprite_height]

handle_collision_modifier(self, "SprintSpeed", "mspd", 1.5, calc_multiply, sprinting);
handle_collision_modifier(self, "SprintAccel", "accel", 1.5, calc_multiply, sprinting);
handle_collision_modifier(self, "SprintDecel", "decel", 1.2, calc_multiply, sprinting);

handle_collision_modifier(self, "CrouchSpeed", "mspd", 0.5, calc_multiply, crouching);
handle_collision_modifier(self, "CrouchIndex", "image_index", 1, calc_add, crouching);

handle_collision_modifier(self, "InjureJumpNum", "max_jumps", -1, calc_add, injured);

//do actions (see obj_actor)
event_inherited();

if(keyboard_check_pressed(vk_space)){
	light_opened = !light_opened;
}

handle_collision_modifier(self, "LightNoise", "noise", light_source.clear_rad, calc_add_high_prio, light_opened);
if(light_opened){
	instance_activate_object(light_source);
}
else{
	instance_deactivate_object(light_source);
}

handle_collision_modifier(self, "SprintNoise", "noise", 1.2, calc_multiply, sprinting && moving);
handle_collision_modifier(self, "CrouchNoise", "noise", 0.8, calc_multiply, crouching);

light_source.x = x;
light_source.y = y;

show_debug_message(noise);

if(platform != -1){
	handle_collision_modifier(self, "GroundNoise", "noise", platform.noise_multiplier, calc_multiply, moving);
}

show_debug_message(noise);




