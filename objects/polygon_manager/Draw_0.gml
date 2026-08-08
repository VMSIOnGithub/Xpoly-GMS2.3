/// @description Insert description here
// You can write your code in this editor
/*XPoly_Booleanation(objs, 5.0, 24.0)
Xpoly_Draw_Buffered_Strokes(false,c_white,c_blue)
Xpoly_Draw_Buffered_Polygons(false,c_black,c_blue)
*/
if (!surface_exists(surf_a)) surf_a = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surf_b)) surf_b = surface_create(window_get_width(), window_get_height());
if (!surface_exists(surf_helper)) surf_helper = surface_create(window_get_width(), window_get_height());


if(array_length(objs)>=1){
	//draw strokes
	surface_set_target(surf_a);
	draw_clear_alpha(c_white,0)
	draw_set_alpha(1)
	var cur_obj = objs[0];
	Xpoly_Draw_Inflated(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,stroke_width,miter_limit,
		draw_debug_enabled,c_white)
	surface_reset_target();
	

	for(var i=1;i<array_length(objs);i++){
		var cur_obj = objs[i];
		
		surface_set_target(surf_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		var new_stroke_width = cur_obj.operation == XPOLY_OPERATION_DIFFERENCE ? -stroke_width : stroke_width
		Xpoly_Draw_Inflated(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,new_stroke_width,miter_limit,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_a,surf_b,surf_helper,cur_obj.operation)
	}
	
	draw_surface_ext(surf_a,0,0,1,1,0,c_white,1);
	
	
	//draw blacks
	surface_set_target(surf_a);
	draw_clear_alpha(c_white,0)
	draw_set_alpha(1)
	var cur_obj = objs[0];
	Xpoly_Draw(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,
		draw_debug_enabled,c_white)
	surface_reset_target();
	

	for(var i=1;i<array_length(objs);i++){
		var cur_obj = objs[i];
		
		surface_set_target(surf_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		Xpoly_Draw(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_a,surf_b,surf_helper,cur_obj.operation)
	}
	
	draw_surface_ext(surf_a,0,0,1,1,0,c_black,1.0);
	
}