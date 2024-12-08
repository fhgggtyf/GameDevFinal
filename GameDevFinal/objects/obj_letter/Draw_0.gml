/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_red);
draw_sprite(spr_letter, 0, x, y);

draw_set_font(custom_font);
draw_text_ext(x - sprite_get_width(spr_letter)/2 + 25, y + 25, text, stringHeight, boxWidth);