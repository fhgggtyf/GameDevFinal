/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_green);
if (room == ContentWarning) {
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 230, camera_get_view_y(view_camera[0]) + 300, "Warning: This game contains depictions of body horror and suicide.", 1, 1, 0);
	draw_text_transformed(camera_get_view_x(view_camera[0]) + 220, camera_get_view_y(view_camera[0]) + 350, "The content depicted within may be considered strange or disturbing.", 1, 1, 0);
}