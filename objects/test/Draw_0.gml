/// @description Insert description here
// You can write your code in this editor
// 1. 在 surface 上填满白色（不透明）

if (!surface_exists(surfA)) surfA = surface_create(window_get_width(), window_get_height());

surface_set_target(surfA)
draw_set_color(c_white)
draw_set_alpha(sqrt(0.5))
draw_sprite_ext(spr_icon,0,100,100,4,4,0,c_white,sqrt(0.5))
surface_reset_target()

draw_surface(surfA,0,0);

draw_set_color(c_white)
draw_set_alpha(0.5)
draw_sprite_ext(spr_icon,0,200,100,4,4,0,c_white,0.5)