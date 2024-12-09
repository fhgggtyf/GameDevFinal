/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_green);
if (room == MainMenu) {
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 233, camera_get_view_y(view_camera[0]) + 300, "GO WITHOUT LIGHT", 4, 4, 0);
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 420, camera_get_view_y(view_camera[0]) + 450, "Press Any Key To Begin", 1, 1, 0);
}
if (room == EndMenu) {
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 590, camera_get_view_y(view_camera[0]) + 200, "THE END?", 2.5, 2.5, 0);
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 570, camera_get_view_y(view_camera[0]) + 400, "Press Any Key To Return...", 1, 1, 0);
	if (global.manager_key_obtained) {
		draw_text_transformed(camera_get_view_x(view_camera[0]) + 560, camera_get_view_y(view_camera[0]) + 500, " - Secret Level Unlocked - ", 1, 1, 0);
	}
}