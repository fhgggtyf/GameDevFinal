/// @description Insert description here
// You can write your code in this editor
event_inherited();

//game feel variables
accel = .6;
decel = .6;
mspd = 5;
grav = .4;
coyote_time = 8;
jump_str = 8;
wall_xjump = 10;

//mechanics
max_jumps = 1;

noise = 500;

modifiers=[];

sprinting = false;
crouching = false;

left = 0;
top = 0;
right = 0;
bot = 0;

light_source = instance_create_layer(x,y,"Instances",obj_lightsource);
instance_deactivate_object(light_source);

light_opened = false;

function land(){
}
