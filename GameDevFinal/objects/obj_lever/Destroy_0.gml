/// @description Insert description here
// You can write your code in this editor

global.door_list[key_num] = true;
global.door_opened = true;
var inst = instance_create_layer(x, y, "Instances", obj_readable_remainder);
inst.created = noone;
inst.my_text = my_text;