// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function create_enemy_behaviors() {
    return {
        // Modules
        module_idle: create_module(
            function (owner) { owner.hmove = 0; },
            function (owner) { },
            function (owner) { }
        ),
		
		module_search: create_module(
		    function (owner) { owner.hmove = 0; },
            function (owner) { idle_timer++},
            function (owner) { idle_timer = 0; }
		
		),
		
		module_patrol: create_module(
			function (owner) { owner.hmove = -1; }, 
            function (owner) {
				if (place_meeting(owner.x + sign(owner.hmove), owner.y, obj_platform) || place_meeting(owner.x + sign(owner.hmove), owner.y, obj_patrol_ledge)){
					if(hmove_changed || stuck){
						stuck = true;	
					}
					else{
						owner.xspd = 0;
						owner.hmove *= -1;
					}
				}
				else{
					stuck = false;
				}
			}, 
            function (owner) { 
				owner.hmove = 0;} 
		),

        module_chase: create_module(
            function (owner) { owner.chasing = true;
								handle_collision_modifier(self, "ChaseAccel", "mspd", chase_multiplier, calc_multiply, chasing);
								
								if (!variable_instance_exists(owner, "sound_id")) {
								    owner.sound_id = -1; 
								}

								if (owner.sound_id == -1 || !audio_is_playing(owner.sound_id)) {
							
								    owner.sound_id = audio_play_sound_at(monster_appearing_sound_41450, owner.x,owner.y, 0, 100, 600, 1, false, 1);
								}
								}, 
            function (owner) {
				if(abs(player.x - owner.x) < 20){
					owner.hmove = 0;
				}
				else{
					owner.hmove = 3 * sign(player.x - owner.x);
				}
				}, 
            function (owner) { 
				owner.chasing = false;
				owner.hmove = 0;
				handle_collision_modifier(self, "ChaseAccel", "mspd", chase_multiplier, calc_multiply, chasing);}
        ),
		
		module_alert_update: create_module(
			function (owner) { },
			function (owner) {  
								if(player.noise - point_distance(owner.x, owner.y, player.x, player.y) >= owner.sound_threshold){
									owner.alert_val += alert_speed * (player.noise - point_distance(owner.x, owner.y, player.x, player.y) - owner.sound_threshold);
								}
								else{
									owner.alert_val += decay_speed * (player.noise - point_distance(owner.x, owner.y, player.x, player.y) - owner.sound_threshold);
								}
							},
			function (owner) { }
			
		),
		
		module_vision_alert_update: create_module(
			function (owner) { },
			function (owner) {  
								
							owner.alert_val += alert_speed * 40;
								
							},
			function (owner) { owner.alert_val = 0; }
			
		),
		
		module_alert_bar_update: create_module(
			function (owner) { alarm_bar = instance_create_layer(x, bbox_top - 15, "Instances", obj_temp_alarm_display);},
			function (owner) {  alarm_bar.x = x;
								alarm_bar.y = bbox_top - 10;
								
								alarm_bar.number = owner.alert_val / owner.alert_threshold * 100;
								},
			function (owner) { instance_destroy(alarm_bar);
								alarm_bar = noone;
								}
			
		),
		
		module_update_vision_cone: create_module(
			function(owner) {},
			function(owner) { 
				owner.vision_triangle.image_xscale *= sign(owner.image_xscale) == -sign(owner.vision_triangle.image_xscale) ? 1 : -1 
				owner.vision_triangle.x = owner.x - owner.vision_triangle.image_xscale * 0.5 * abs(owner.sprite_width);
				owner.vision_triangle.y = owner.y - 0.5 * owner.sprite_height;
				owner.vision_triangle.image_index = owner.sm.current_state;
				},
			function(owner) {}	
		),
		
		module_left_right_look: create_module(
			function(owner) {},
			function(owner) { owner.direction_time++;
								if(owner.direction_time >= owner.change_direction_interval){
									owner.image_xscale *= -1;
									owner.direction_time = 0;
								}
							},
			function(owner) { owner.direction_time = 0;}	
		),
		
		module_reset_alert_on_exit: create_module(
			function(owner) {},
			function(owner) {},
			function(owner) { owner.alert_val = 0.5 * owner.alert_threshold}	
		),

        // Conditions
        condition_player_noise_heard: create_condition(
            function (owner) { return player.noise - point_distance(owner.x, owner.y, player.x, player.y) >= owner.sound_threshold; }
        ),
		
		condition_player_noise_not_heard: create_condition(
            function (owner) { return player.noise - point_distance(owner.x, owner.y, player.x, player.y)< owner.sound_threshold; }
        ),
		
		condition_alarm_off: create_condition(
			function (owner) { return owner.alert_val <= 0; }
        ),
		
		condition_alarmed: create_condition(
			function (owner) { return owner.alert_val >= owner.alert_threshold; }
        ),
		
		condition_scanned: create_condition(
		    function (owner) {
		        with (owner.vision_triangle) {
					if(owner.player.light_opened){
						if (collision_circle(owner.player.x, owner.player.y, owner.player.light_source.clear_rad, self, true, false)) {
						    return true;
						}
					}
					
		           
		            var ax, ay_top, ay_bottom, ay;
		            if (image_xscale == 1) {
		                ax = bbox_left; 
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
						ay = y;
		            } else { 
		                ax = bbox_right; 
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
						ay = y;
		            }   

		
		            var tx1 = owner.player.left;
		            var ty1 = owner.player.top;
		            var tx2 = owner.player.right;
		            var ty2 = owner.player.bot;
					var midl = owner.player.midl;
					var midr = owner.player.midr;

		            if (image_xscale == 1) { 
		                if (tx2 < ax || tx1 > x || ty2 < ay_top || ty1 > ay_bottom) {
		                  
		                    return false;
		                }
		            } else { 
		                if (tx1 > ax || tx2 < x || ty2 < ay_top || ty1 > ay_bottom) {
		                
		                    return false;
		                }
		            }

		          
		            var target_points = [midl, midr];

		            if (ty1 <= ay_bottom && ty1 >= ay_top) {
		                if (image_xscale == 1) {
		                    if (tx1 >= ax && tx1 <= x) array_push(target_points, [tx1, ty1]);
		                    if (tx2 >= ax && tx2 <= x) array_push(target_points, [tx2, ty1]);
		                } else {
		                    if (tx1 >= x && tx1 <= ax) array_push(target_points, [tx1, ty1]);
		                    if (tx2 >= x && tx2 <= ax) array_push(target_points, [tx2, ty1]);
		                }
		            }

		            if (ty2 <= ay_bottom && ty2 >= ay_top) {
		                if (image_xscale == 1) {
		                    if (tx1 >= ax && tx1 <= x) array_push(target_points, [tx1, ty2]);
		                    if (tx2 >= ax && tx2 <= x) array_push(target_points, [tx2, ty2]);
		                } else {
		                    if (tx1 >= x && tx1 <= ax) array_push(target_points, [tx1, ty2]);
		                    if (tx2 >= x && tx2 <= ax) array_push(target_points, [tx2, ty2]);
		                }
		            }

		            if (array_length(target_points) == 0) {
		             
		                return false;
		            }

					var length = abs(sprite_width) * abs(image_xscale);  
					var height = abs(sprite_height) * abs(image_yscale); 
					var half_angle = radtodeg(arctan((0.5 * height) / length));

					var full_angle = 2 * half_angle;
					
					var cone_direction = 90 + image_xscale * 90; 
					var cone_angle = full_angle;
					for (var i = 0; i < array_length(target_points); i++) {
				        var px = target_points[i][0];
				        var py = target_points[i][1];

				        if (is_point_in_vision_cone(x, y, px, py, cone_angle, cone_direction)) {
				            if (!collision_line(x, y, px, py, obj_platform, true, true)) {
				             
				                return true;
				            }
				        }
				    }


		            return false;
		        }
		    }
		),
		
		condition_not_scanned: create_condition(
			function (owner) {
		        with (owner.vision_triangle) {
					if(owner.player.light_opened){
						if (collision_circle(owner.player.x, owner.player.y, owner.player.light_source.clear_rad, self, true, false)) {
						    return false;
						}
					}
		            var ax, ay_top, ay_bottom, ay;
		            if (image_xscale == 1) {
		                ax = bbox_left; 
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
						ay = y;
		            } else { 
		                ax = bbox_right; 
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
						ay = y;
		            }

				    var tx1 = owner.player.left;
		            var ty1 = owner.player.top;
		            var tx2 = owner.player.right;
		            var ty2 = owner.player.bot;
					var midl = owner.player.midl;
					var midr = owner.player.midr;

		            if (image_xscale == 1) { 
		                if (tx2 < ax || tx1 > x || ty2 < ay_top || ty1 > ay_bottom) {
		                    return true;
		                }
		            } else { 
		                if (tx1 > ax || tx2 < x || ty2 < ay_top || ty1 > ay_bottom) {
		                    return true;
		                }
		            }

		            var target_points = [midl, midr];

		            if (ty1 <= ay_bottom && ty1 >= ay_top) {
		                if (image_xscale == 1) {
		                    if (tx1 >= ax && tx1 <= x) array_push(target_points, [tx1, ty1]);
		                    if (tx2 >= ax && tx2 <= x) array_push(target_points, [tx2, ty1]);
		                } else {
		                    if (tx1 >= x && tx1 <= ax) array_push(target_points, [tx1, ty1]);
		                    if (tx2 >= x && tx2 <= ax) array_push(target_points, [tx2, ty1]);
		                }
		            }

		            if (ty2 <= ay_bottom && ty2 >= ay_top) {
		                if (image_xscale == 1) {
		                    if (tx1 >= ax && tx1 <= x) array_push(target_points, [tx1, ty2]);
		                    if (tx2 >= ax && tx2 <= x) array_push(target_points, [tx2, ty2]);
		                } else {
		                    if (tx1 >= x && tx1 <= ax) array_push(target_points, [tx1, ty2]);
		                    if (tx2 >= x && tx2 <= ax) array_push(target_points, [tx2, ty2]);
		                }
		            }

		            if (array_length(target_points) == 0) {
		                return true;
		            }

					var length = abs(sprite_width) * abs(image_xscale);  
					var height = abs(sprite_height) * abs(image_yscale); 
					
					var half_angle = radtodeg(arctan((0.5 * height) / length));

					var full_angle = 2 * half_angle;
					
					var cone_direction = 90 + image_xscale * 90; 
					var cone_angle = full_angle;   

					for (var i = 0; i < array_length(target_points); i++) {
				        var px = target_points[i][0];
				        var py = target_points[i][1];

				        if (is_point_in_vision_cone(x, y, px, py, cone_angle, cone_direction)) {
				            if (!collision_line(x, y, px, py, obj_platform, true, true)) {
				               
				                return false;
				            }
				        }
				    }


		            return true;
		        }
		    }
        ),
		
        condition_idle_timered: create_condition(
            function (owner) { return idle_timer > 2 * change_direction_interval; }
        ),
		
    };
}

function is_point_in_vision_cone(x1, y1, x2, y2, cone_angle, cone_direction) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    var point_angle = point_direction(0, 0, dx, dy);

    var half_cone = cone_angle / 2;
    var min_angle = cone_direction - half_cone;
    var max_angle = cone_direction + half_cone;

    if (min_angle < 0) min_angle += 360;
    if (max_angle >= 360) max_angle -= 360;

    if (min_angle < max_angle) {
        return point_angle >= min_angle && point_angle <= max_angle;
    } else {
        return point_angle >= min_angle || point_angle <= max_angle;
    }
}