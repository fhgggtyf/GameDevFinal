if (shader_opened) {
    shader_set(gradient_shader);

    // Get the camera's X and Y position
    var cam = view_camera[0];
    var camera_x = camera_get_view_x(cam);
    var camera_y = camera_get_view_y(cam);

    // Pass the camera offset to the shader
    shader_set_uniform_f(shader_get_uniform(gradient_shader, "u_camera_offset"), camera_x, camera_y);

    var centers = [];
    var clear_rads = [];
    var dim_rads = [];
    var directions = [];
    var angles = [];
    var num_lights = 0;

    // Collect data from all light sources
    if (instance_exists(obj_lightsource)) {
        with (obj_lightsource) {
            if (num_lights < 16) { // Max 16 lights
                // Add light positions relative to world space
                array_push(centers, x);
                array_push(centers, y);

                // Add light radii
                array_push(clear_rads, clear_rad);
                array_push(dim_rads, dim_rad);

                // Add light direction (normalized vector)
                var dir_x = dcos(direction); // Direction X component
                var dir_y = -dsin(direction); // Direction Y component (negative for GameMaker coordinates)
                array_push(directions, dir_x);
                array_push(directions, dir_y);

                // Add light cone angle (in radians)
                array_push(angles, angle * pi / 180); // Convert angle to radians
                num_lights++;
            }
        }
    }

    // Pass the number of lights
    shader_set_uniform_i(shader_get_uniform(gradient_shader, "u_num_lights"), num_lights);

    // Pass the light data
	if(num_lights > 0){
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_centers"), centers);
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_clear_rads"), clear_rads);
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_dim_rads"), dim_rads);
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_directions"), directions);
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_angles"), angles);

	    // Pass environment properties
	    shader_set_uniform_f(shader_get_uniform(gradient_shader, "u_alpha_env"), 1.0); // Base alpha for the environment
	    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_env_color"), [0.0, 0.0, 0.0, 1.0]); // Environment color

	}
    // Trigger the shader by drawing a rectangle
    draw_rectangle(0, 0, room_width, room_height, false);

    // Reset the shader
    shader_reset();
}