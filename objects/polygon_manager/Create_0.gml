/// @description Insert description here
// You can write your code in this editor
objs = []


surf_outset_a = -1;
surf_outset_b = -1;

surf_helper = -1;

draw_debug_enabled = false
stroke_width = 5.0;
miter_limit = 6.0;

col_strokes = c_white;
col_blacks = c_black;


function draw_strokes(){
	surface_set_target(surf_outset_a);
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
		var operation = cur_obj.operation;
		
		surface_set_target(surf_outset_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		var new_stroke_width = operation == XPOLY_OPERATION_DIFFERENCE ? -stroke_width : stroke_width
		Xpoly_Draw_Inflated(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,new_stroke_width,miter_limit,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_outset_a,surf_outset_b,surf_helper,cur_obj.operation)
	}
	
	draw_surface_ext(surf_outset_a,0,0,1,1,0,col_strokes,1);
}


function draw_blacks(){
	surface_set_target(surf_outset_a);
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
		
		surface_set_target(surf_outset_b);
		draw_clear_alpha(c_white,0)
		draw_set_alpha(1)
		Xpoly_Draw(cur_obj.vertices,
			cur_obj.x,cur_obj.y,
			cur_obj.image_angle,
			cur_obj.image_xscale,cur_obj.image_yscale,
			cur_obj.org_x,cur_obj.org_y,
			draw_debug_enabled,c_white)
		surface_reset_target();
		Xpoly_Surface_Boolean(surf_outset_a,surf_outset_b,surf_helper,cur_obj.operation)
	}
	
	draw_surface_ext(surf_outset_a,0,0,1,1,0,col_blacks,1.0);
}