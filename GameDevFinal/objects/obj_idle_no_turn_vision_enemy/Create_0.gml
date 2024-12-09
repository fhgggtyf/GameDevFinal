/// @description Insert description here
// You can write your code in this editor

event_inherited();

mspd = 3;
accel= .2;
decel = 0.2;

hmove = -1;
prev_hmove = -1;
hmove_changed = false;
stuck = false;

grav_normal = .2;
grav_neg = -.2;
grav = grav_normal;

change_direction_interval = 60;
direction_time = 0;

alert_val = 0;
alert_speed = 0.05;       
decay_speed = 0.02;    
alert_threshold = 100; 

chase_multiplier = 2;

idle_timer = 0;

vision_triangle = instance_create_layer(x, y ,"Instances",obj_vision_cone)

player= instance_find(obj_player,0);

eb = create_enemy_behaviors()

// Create states
idle_state = create_state([eb.module_idle, eb.module_update_vision_cone]);
alarmed_state = create_state([eb.module_vision_alert_update, eb.module_update_vision_cone, eb.module_alert_bar_update]);
chase_state = create_state([eb.module_chase, eb.module_update_vision_cone]);

// Create state machine
sm = create_state_machine([idle_state, alarmed_state, chase_state]);

sm.add_transition(0, 1, eb.condition_scanned); 
sm.add_transition(1, 2, eb.condition_alarmed);
sm.add_transition(2, 0, eb.condition_not_scanned);   
sm.add_transition(1, 0, eb.condition_not_scanned);  

// Initialize state machine
sm.init(0, self); 