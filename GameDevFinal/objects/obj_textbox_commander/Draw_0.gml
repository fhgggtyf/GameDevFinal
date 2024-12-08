/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_red);
draw_sprite(spr_textbox, 0, x, y);

draw_set_font(custom_font);
draw_text_ext(x - sprite_get_width(spr_textbox)/2, y, text, stringHeight, boxWidth);