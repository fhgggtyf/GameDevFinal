if (shader_opened) {
    shader_set(gradient_shader);

    var centers = [];
    var clear_rads = [];
    var dim_rads = [];
    var num_lights = 0;
    var directions = [];
    var angles = [];

    // Collect data from all light sources
    if (instance_exists(obj_lightsource)) {
        with (obj_lightsource) {
            if (num_lights < 16) { // Max 16 lights
                array_push(centers, x);
                array_push(centers, y);
                array_push(clear_rads, clear_rad);
                array_push(dim_rads, dim_rad);

                // Convert direction (angle) to normalized vector
                var dir_x = dcos(direction);
                var dir_y = -dsin(direction); // Use negative sin due to GameMaker's coordinate system
                array_push(directions, dir_x);
                array_push(directions, dir_y);

                array_push(angles, angle * pi / 180); // Convert angle to radians
                num_lights++;
            }
        }
    }

    // Pass data to the shader
    shader_set_uniform_i(shader_get_uniform(gradient_shader, "u_num_lights"), num_lights);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_centers"), centers);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_clear_rads"), clear_rads);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_dim_rads"), dim_rads);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_directions"), directions);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_angles"), angles);
    shader_set_uniform_f(shader_get_uniform(gradient_shader, "u_alpha_env"), 1.0);
    shader_set_uniform_f_array(shader_get_uniform(gradient_shader, "u_env_color"), [0.0, 0.0, 0.0, 1.0]); // Change this line if don't want black background

    // Trigger the shader by drawing a rectangle
    draw_rectangle(0, 0, room_width, room_height, false);

    shader_reset();
}