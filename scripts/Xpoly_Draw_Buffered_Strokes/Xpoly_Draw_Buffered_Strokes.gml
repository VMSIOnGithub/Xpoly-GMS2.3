

function Xpoly_Draw_Buffered_Strokes(is_debug,col_fill,col_debug){
	
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_out_stroke,buffer_seek_start,4)
	var triangle_count = buffer_read(global.buf_out_stroke,buffer_u32)
	var triangles = []
	for(var i = 0 ;i < triangle_count*6 ;i++){
		array_push(triangles, buffer_read(global.buf_out_stroke,buffer_f32) )
	}
	
	for(var i=0;i<array_length(triangles);i+=6){
		var pt_1_x = triangles[i];
		var pt_1_y = triangles[i+1];
		var pt_2_x = triangles[i+2];
		var pt_2_y = triangles[i+3];
		var pt_3_x = triangles[i+4];
		var pt_3_y = triangles[i+5];
		
		draw_set_color(col_fill)
		draw_triangle(
			pt_1_x,
			pt_1_y,
			pt_2_x,
			pt_2_y,
			pt_3_x,
			pt_3_y,
			false
		);
		if(is_debug){
			draw_set_color(col_debug)
				draw_triangle(
				pt_1_x,
				pt_1_y,
				pt_2_x,
				pt_2_y,
				pt_3_x,
				pt_3_y,
				true
			);
		}
	
	}
}