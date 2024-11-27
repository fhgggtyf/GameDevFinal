/// @description Insert description here
// You can write your code in this editor
// Inherit the parent event

event_inherited();

mspd = 3;
accel= .2;
decel = 0.2;

hmove = -1;

grav_normal = .2;
grav_neg = -.2;
grav = grav_normal;

change_direction_interval = 60;
direction_time = 0;

vision_triangle = instance_create_layer(x, y ,"Instances",obj_vision_cone)

player= instance_find(obj_player,0);

eb = create_enemy_behaviors()

// Create states
idle_state = create_state([eb.module_patrol, eb.module_update_vision_cone, eb.module_left_right_look]);
chase_state = create_state([eb.module_chase, eb.module_update_vision_cone]);

// Create state machine
sm = create_state_machine([idle_state, chase_state]);

sm.add_transition(0, 1, eb.condition_scanned); 
sm.add_transition(1, 0, eb.condition_not_scanned);  

// Initialize state machine
sm.init(0, self); // Start in idle state