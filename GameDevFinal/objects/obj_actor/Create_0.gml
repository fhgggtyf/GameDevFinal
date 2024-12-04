/// @description Insert description here
// You can write your code in this editor
//cutomizable variables - override on children
mspd = 0;
accel = 0;
decel = 0;
grav = 0;
coyote_time = 1;
jump_str = 0;
max_jumps = 1;
jump_hold_time = 1;

//wall jumping
can_wall_jump = false;
wall_xjump = 0;

chase_multiplier = 1;
chasing = false;

//do not modify
grav_normal = grav;
grav_neg = -grav;
xspd = 0;
yspd = 0;
on_ground = false;
hmove = 0;
jump_press = false;
num_jumps = max_jumps;
moving = false;
jump_held = false;
on_wall_left = false;
on_wall_right = false;
on_wall = false;
was_grounded = false;

platform = -1;
prev_platform_slip = 1;

modifiers=[];


function land(){
	
}