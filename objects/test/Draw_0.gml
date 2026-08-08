/// @description Insert description here
// You can write your code in this editor
// 1. 在 surface 上填满白色（不透明）

if (!surface_exists(surfA)) surfA = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surfB)) surfB = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surfHelper)) surfHelper = surface_create(window_get_width(), window_get_height());


draw_set_alpha(1)

surface_set_target(surfA);
draw_clear_alpha(c_white,0);
draw_set_color(c_white);
draw_circle(200,200,100,false);
surface_reset_target();

surface_set_target(surfB);
draw_clear_alpha(c_white,0);
draw_set_color(c_white);
draw_circle(350,200,100,false);
surface_reset_target();



surface_set_target(surfHelper);
draw_clear_alpha(c_white,0);
surface_reset_target();

Xpoly_Surface_Boolean(surfA,surfB,surfHelper,XPOLY_OPERATION_XOR);

draw_surface_ext(surfA,0,0,1,1,0,c_white,1);
