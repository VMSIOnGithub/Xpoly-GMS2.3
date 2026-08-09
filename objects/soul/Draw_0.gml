/// @description Insert description here
// You can write your code in this editor
var soul_col = c_red
switch(soul_mode){
	case 1:
		soul_col = c_blue;
		break;
	default:
		soul_col = c_red;
		break;
}

draw_sprite_ext(spr_soul,0,x+1,y+1,1,1,soul_gravity_angle,soul_col,1)
