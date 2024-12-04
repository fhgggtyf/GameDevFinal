/// @description Insert description here
// You can write your code in this editor
//detect if on ground, on wall, or if moving
on_ground = place_meeting(x, y+1, obj_platform);
on_wall_left = place_meeting(x-1, y, obj_platform);
on_wall_right = place_meeting(x+1, y, obj_platform);
on_wall = on_wall_left or on_wall_right;
moving = (hmove != 0);
image_xscale = sign(hmove) != 0 ? sign(hmove) : image_xscale;

//if on the ground, bump up coyote time and restore all jumps
if (on_ground){
	alarm_set(0, coyote_time);
	num_jumps = max_jumps;
}
else{
	handle_collision_modifier(self, "SlipAccel", "accel", prev_platform_slip, calc_multiply, on_ground);
	handle_collision_modifier(self, "SlipDccel", "decel", prev_platform_slip, calc_multiply, on_ground);
	num_jumps -= (num_jumps >= max_jumps && max_jumps > 1) ? 1 : 0;
}

//if the actor presses jump and has jumps available, jump
if (jump_press and num_jumps > 0){
	yspd = -jump_str;	
	num_jumps--;
}


//wall jump
//if (on_wall){
//	if (jump_press){
//		//jump up some and...
//		yspd = -jump_str/2;
//		//jump out in correct direction
//		if (on_wall_left){
//			xspd = wall_xjump;	
//		} else {
//			xspd = -wall_xjump;	
//		}
//	}
//}

//if moving, apply acceleration. otherwise decelerate
if (moving){
	xspd += accel * hmove;
} else {
	decelerate(decel);	
}

//clamp max speed
xspd = clamp(xspd, -mspd, mspd);

//apply gravity
yspd += grav;

//apply movement, checking for collisions
platform = move_collide();

if(platform != -1){
	prev_platform_slip = platform.slip;
}

if (on_ground and not was_grounded){
	handle_collision_modifier(self, "SlipAccel", "accel", prev_platform_slip, calc_multiply, on_ground);
	handle_collision_modifier(self, "SlipDccel", "decel", prev_platform_slip, calc_multiply, on_ground);
	land();	
}

was_grounded = on_ground;
