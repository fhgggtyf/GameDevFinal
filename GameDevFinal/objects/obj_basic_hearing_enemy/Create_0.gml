/// @description Insert description here
// You can write your code in this editor
event_inherited();

spr = spr_basic;

mspd = 3;
accel= .2;
decel = 0.2;

hmove = -1;

grav_normal = .2;
grav_neg = -.2;
grav = grav_normal;

sound_threshold = 350;

alert_val = 0;

alert_speed = 0.05;       
decay_speed = 0.02;      
alert_threshold = 100; 

player= instance_find(obj_player,0);

eb = create_enemy_behaviors()

// Create states
idle_state = create_state([eb.module_idle]);
chase_state = create_state([eb.module_chase]);
alarmed_state = create_state([eb.module_alert_update, eb.module_alert_bar_update]);

// Create state machine
sm = create_state_machine([idle_state, alarmed_state, chase_state]);

sm.add_transition(0, 1, eb.condition_player_noise_heard); 
sm.add_transition(1, 0, eb.condition_alarm_off);  
sm.add_transition(1, 2, eb.condition_alarmed);
sm.add_transition(2, 1, eb.condition_player_noise_not_heard);

// Initialize state machine
sm.init(0, self);

first_detect = false;