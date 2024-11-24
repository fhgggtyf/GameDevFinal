// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Script: create_enemy_behaviors
function create_enemy_behaviors() {
    return {
        // Modules
        module_idle: create_module(
            function (owner) { owner.hmove = 0; },
            function (owner) { show_debug_message("idle")}, // Update
            function (owner) { /* No exit logic */ }
        ),

        module_chase: create_module(
            function (owner) {  }, // Init
            function (owner) { owner.hmove = 3 * sign(player.x - owner.x); 
				show_debug_message("chasing")}, // Update
            function (owner) { owner.hmove = 0;} // Exit
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
				owner.vision_triangle.image_xscale *= sign(owner.image_xscale) == sign(owner.vision_triangle.image_xscale) ? 1 : -1 
				owner.vision_triangle.x = x + image_xscale * 0.5 * sprite_width;
				owner.vision_triangle.y = y - 0.5*sprite_height;
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
			function(owner) {}	
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
						if (collision_circle(owner.player.x, owner.player.y, owner.player.light_source.clear_rad, object_index, true, false)) {
						    return true;
						}
					}
					
		            // Vision triangle bounding box setup
		            var ax, ay_top, ay_bottom;
		            if (image_xscale == 1) {
		                ax = bbox_left; // Vision cone's farthest left edge
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
		            } else { // image_xscale == -1
		                ax = bbox_right; // Vision cone's farthest right edge (flipped)
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
		            }

		            // Target bounding box
		            var tx1 = owner.player.bbox_left;
		            var ty1 = owner.player.bbox_top;
		            var tx2 = owner.player.bbox_right;
		            var ty2 = owner.player.bbox_bottom;

		            // Debug the bounding boxes
		            show_debug_message("Vision Bounds: ax=" + string(ax) + ", ay_top=" + string(ay_top) + ", ay_bottom=" + string(ay_bottom));
		            show_debug_message("Target Bounds: tx1=" + string(tx1) + ", ty1=" + string(ty1) + ", tx2=" + string(tx2) + ", ty2=" + string(ty2));

		            // Bounding box overlap check
		            if (image_xscale == 1) { // Default orientation
		                if (tx2 < ax || tx1 > x || ty2 < ay_top || ty1 > ay_bottom) {
		                    show_debug_message("Target is completely outside the vision cone (image_xscale == 1)");
		                    return false;
		                }
		            } else { // Flipped orientation
		                if (tx1 > ax || tx2 < x || ty2 < ay_top || ty1 > ay_bottom) {
		                    show_debug_message("Target is completely outside the flipped vision cone (image_xscale == -1)");
		                    return false;
		                }
		            }

		            show_debug_message("Bounding box overlap confirmed (Step 1 passed).");

		            // Remaining steps (edge simplification and obstruction checks)...

		            // 2. Simplify by checking edges
		            var target_points = [];

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
		                show_debug_message("No points in the vision cone.");
		                return false;
		            }

		            show_debug_message("Edge points confirmed: " + string(array_length(target_points)) + " points.");

		            // 3. Obstruction check
		            for (var i = 0; i < array_length(target_points); i++) {
		                var px = target_points[i][0];
		                var py = target_points[i][1];
		                if (!collision_line(x, y, px, py, obj_platform, true, true)) {
		                    show_debug_message("Unobstructed point found: (" + string(px) + ", " + string(py) + ")");
		                    return true;
		                }
		            }

		            show_debug_message("All points obstructed.");
		            return false;
		        }
		    }
		),
		
		condition_not_scanned: create_condition(
			function (owner) {
		        with (owner.vision_triangle) {
					if(owner.player.light_opened){
						if (collision_circle(owner.player.x, owner.player.y, owner.player.light_source.clear_rad, object_index, true, false)) {
						    return false;
						}
					}
		            // Vision triangle bounding box setup
		            var ax, ay_top, ay_bottom;
		            if (image_xscale == 1) {
		                ax = bbox_left; // Vision cone's farthest left edge
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
		            } else { // image_xscale == -1
		                ax = bbox_right; // Vision cone's farthest right edge (flipped)
		                ay_top = bbox_top;
		                ay_bottom = bbox_bottom;
		            }

		            // Target bounding box
		            var tx1 = owner.player.bbox_left;
		            var ty1 = owner.player.bbox_top;
		            var tx2 = owner.player.bbox_right;
		            var ty2 = owner.player.bbox_bottom;

		            // Debug the bounding boxes
		            show_debug_message("Vision Bounds: ax=" + string(ax) + ", ay_top=" + string(ay_top) + ", ay_bottom=" + string(ay_bottom));
		            show_debug_message("Target Bounds: tx1=" + string(tx1) + ", ty1=" + string(ty1) + ", tx2=" + string(tx2) + ", ty2=" + string(ty2));

		            // Bounding box overlap check
		            if (image_xscale == 1) { // Default orientation
		                if (tx2 < ax || tx1 > x || ty2 < ay_top || ty1 > ay_bottom) {
		                    show_debug_message("Target is completely outside the vision cone (image_xscale == 1)");
		                    return true;
		                }
		            } else { // Flipped orientation
		                if (tx1 > ax || tx2 < x || ty2 < ay_top || ty1 > ay_bottom) {
		                    show_debug_message("Target is completely outside the flipped vision cone (image_xscale == -1)");
		                    return true;
		                }
		            }

		            show_debug_message("Bounding box overlap confirmed (Step 1 passed).");

		            // Remaining steps (edge simplification and obstruction checks)...

		            // 2. Simplify by checking edges
		            var target_points = [];

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
		                show_debug_message("No points in the vision cone.");
		                return true;
		            }

		            show_debug_message("Edge points confirmed: " + string(array_length(target_points)) + " points.");

		            // 3. Obstruction check
		            for (var i = 0; i < array_length(target_points); i++) {
		                var px = target_points[i][0];
		                var py = target_points[i][1];
		                if (!collision_line(x, y, px, py, obj_platform, true, true)) {
		                    show_debug_message("Unobstructed point found: (" + string(px) + ", " + string(py) + ")");
		                    return false;
		                }
		            }

		            show_debug_message("All points obstructed.");
		            return true;
		        }
		    }
        ),
		
    };
}