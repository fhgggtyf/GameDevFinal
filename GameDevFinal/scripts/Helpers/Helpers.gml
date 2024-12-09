// Script assets have changed for v2.3.0 see

function world_to_gui(x_world, y_world) {
    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);

    var x_gui = x_world - cam_x;
    var y_gui = y_world - cam_y;

    return [x_gui, y_gui];
}