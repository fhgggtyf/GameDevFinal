// Script assets have changed for v2.3.0 see

function world_to_gui(x_world, y_world) {
    // Get the camera's position
    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);

    // Convert world space to GUI space
    var x_gui = x_world - cam_x;
    var y_gui = y_world - cam_y;

    // Return the converted coordinates
    return [x_gui, y_gui];
}