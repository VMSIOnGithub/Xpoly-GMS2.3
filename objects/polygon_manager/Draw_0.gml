/// @description Insert description here
// You can write your code in this editor
/*XPoly_Booleanation(objs, 5.0, 24.0)
Xpoly_Draw_Buffered_Strokes(false,c_white,c_blue)
Xpoly_Draw_Buffered_Polygons(false,c_black,c_blue)
*/
if (!surface_exists(surf_outset_a)) surf_outset_a = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surf_outset_b)) surf_outset_b = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surf_helper)) surf_helper = surface_create(window_get_width(), window_get_height());



if(array_length(objs)>=1){
	draw_strokes();
	draw_blacks();
	
	
	
	
}


