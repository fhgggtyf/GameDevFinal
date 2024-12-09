/// @description Insert description here
// You can write your code in this editor
if(global.door_opened_x != [] && global.door_opened_y != []){

	while (array_length(global.door_arrow_timer) < array_length(global.door_opened_x)) {
        array_push(global.door_arrow_timer, 60); 
    }
	
	for(var i = 0; i < array_length(global.door_opened_x); i++){
		var player = instance_find(obj_player, 0)
		var target_x = global.door_opened_x[i];
		var target_y = global.door_opened_y[i];
		
		var player_x = player.x;
		var player_y = player.y - 32;
	
		var cam_x = player_x - 100;
		var cam_y = player_y - 100;
		var cam_w = 200;
		var cam_h = 200;
		
		global.door_arrow_timer[i]--;
		if((target_x >= cam_x - 100 && target_x <= cam_x + cam_w + 100 && target_y >= cam_y - 100 && target_y <= cam_y + cam_h + 100) || global.door_arrow_timer[i] <= 0){
			array_delete(global.door_opened_x, i, 1);
			array_delete(global.door_opened_y, i, 1);
			array_delete(global.door_arrow_timer, i, 1);
			i--;
			continue;
		}

		var dir = point_direction(player.x, player.y, global.door_opened_x[i], global.door_opened_y[i]);

		var edge_x, edge_y;

		if (target_x < cam_x) {
		    edge_x = cam_x;
		    edge_y = player_y - (edge_x - player_x) * tan(degtorad(dir));
		} else if (target_x > cam_x + cam_w) {
		    edge_x = cam_x + cam_w;
		    edge_y = player_y - (edge_x - player_x) * tan(degtorad(dir));
		} else if (target_y < cam_y) {
		    edge_y = cam_y;
		    edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		} else if (target_y > cam_y + cam_h) {
		    edge_y = cam_y + cam_h;
		    edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		}

		if (edge_y < cam_y || edge_y > cam_y + cam_h) {
		    if (target_y < cam_y) {
		        edge_y = cam_y;
		        edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		    } else if (target_y > cam_y + cam_h) {
		        edge_y = cam_y + cam_h;
		        edge_x = player_x - (edge_y - player_y) / tan(degtorad(dir));
		    }
		}

		draw_set_color(c_white);
		var final_cord = world_to_gui(edge_x,edge_y);
		
		draw_triangle_color(
		    final_cord[0] + lengthdir_x(arrow_size, dir),
		    final_cord[1] + lengthdir_y(arrow_size, dir),
		    final_cord[0] + lengthdir_x(arrow_size / 2, dir + 135),
		    final_cord[1] + lengthdir_y(arrow_size / 2, dir + 135),
		    final_cord[0] + lengthdir_x(arrow_size / 2, dir - 135),
		    final_cord[1] + lengthdir_y(arrow_size / 2, dir - 135),
		    c_white, c_white, c_white, false
		);
	}
	
}