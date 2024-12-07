/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_green);
if (room == MainMenu) {
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 450, camera_get_view_y(view_camera[0]) + 200, "TITLE", 4, 4, 0);
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 430, camera_get_view_y(view_camera[0]) + 400, "Press Any Key To Begin", 1, 1, 0);
}
if (room == EndMenu) {
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 410, camera_get_view_y(view_camera[0]) + 400, "Press Any Key To Play Again", 1, 1, 0);
}