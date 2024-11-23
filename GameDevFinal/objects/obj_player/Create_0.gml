/// @description Insert description here
// You can write your code in this editor
event_inherited();

//game feel variables
accel = .2;
decel = .4;
mspd = 5;
grav = .2;
coyote_time = 8;
jump_str = 5;
wall_xjump = 10;

//mechanics
max_jumps = 2;

noise = 500;

modifiers=[];

light_source = instance_create_layer(x,y,"Instances",obj_lightsource);
instance_deactivate_object(light_source);

light_opened = false;

function land(){
}