/// @description Insert description here
// You can write your code in this editor

if(global.door_opened_x != [] && global.door_opened_y != []){
	// Draw GUI event
	for(var i = 0; i < array_length(global.door_opened_x); i++){
		var player = instance_find(obj_player, 0)
		var target_x = global.door_opened_x[i];
		var target_y = global.door_opened_y[i];
		
		var player_x = player.x;
		var player_y = player.y - 32;
	
		// Camera/view properties
		var cam_x = player_x - 100;
		var cam_y = player_y - 100;
		var cam_w = 200;
		var cam_h = 200;
		
		if(target_x >= cam_x - 100 && target_x <= cam_x + cam_w + 100 && target_y >= cam_y - 100 && target_y <= cam_y + cam_h + 100){
			array_delete(global.door_opened_x, i, 1);
			array_delete(global.door_opened_y, i, 1);
			i--;
			continue;
		}

		// Direction from player to target
		var dir = point_direction(player.x, player.y, global.door_opened_x[i], global.door_opened_y[i]);

		// Find intersection with the camera edge
		var edge_x, edge_y;

		// Check intersection with vertical edges
		if (target_x < cam_x) {
		    // Target is to the left of the camera
		    edge_x = cam_x;
		    edge_y = player_y - (edge_x - player_x) * tan(degtorad(dir));
		} else if (target_x > cam_x + cam_w) {
		    // Target is to the right of the camera
		    edge_x = cam_x + cam_w;
		    edge_y = player_y - (edge_x - player_x) * tan(degtorad(dir));
		} else if (target_y < cam_y) {
		    // Target is above the camera, within X bounds
		    edge_y = cam_y;
		    edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		} else if (target_y > cam_y + cam_h) {
		    // Target is below the camera, within X bounds
		    edge_y = cam_y + cam_h;
		    edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		}

		// Adjust to horizontal edges if necessary
		if (edge_y < cam_y || edge_y > cam_y + cam_h) {
		    if (target_y < cam_y) {
		        edge_y = cam_y;
		        edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		    } else if (target_y > cam_y + cam_h) {
		        edge_y = cam_y + cam_h;
		        edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		    }
		}

		// Draw the arrow
		draw_set_color(c_white);
		draw_triangle_color(
		    edge_x + lengthdir_x(arrow_size, dir),
		    edge_y + lengthdir_y(arrow_size, dir),
		    edge_x + lengthdir_x(arrow_size / 2, dir + 135),
		    edge_y + lengthdir_y(arrow_size / 2, dir + 135),
		    edge_x + lengthdir_x(arrow_size / 2, dir - 135),
		    edge_y + lengthdir_y(arrow_size / 2, dir - 135),
		    c_white, c_white, c_white, false
		);
	}
	
}