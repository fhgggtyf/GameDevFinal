// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function decelerate(_amt)
{
	var prev_sign = sign(xspd);
	xspd -= prev_sign * _amt;
	if (sign(xspd) != prev_sign){
		xspd = 0;	
	}
}

function move_collide() {
    for (var i = 0; i < abs(xspd); i++) {
        var platform = instance_place(x + sign(xspd), y, obj_platform);
        if (!platform) {
            x += sign(xspd);
        } else {
            xspd = 0;
        }
    }

    for (var i = 0; i < abs(yspd); i++) {
        var platform = instance_place(x, y + sign(yspd), obj_platform);
        if (!platform) {
            y += sign(yspd);
        } else {
            yspd = 0;
            return platform;
        }
    }
	
	return -1;
}