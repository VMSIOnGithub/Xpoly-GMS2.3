// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Xpoly_Collision_Check(_x,_y,_radius,gravity_angle,foot_length){
	
	
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_in,buffer_seek_start,0)
	buffer_write(global.buf_in,buffer_u32, global.buf_cap)
	buffer_write(global.buf_in,buffer_f32,_x)
	buffer_write(global.buf_in,buffer_f32,_y)
	buffer_write(global.buf_in,buffer_f32,_radius)
	
	
	
	buffer_seek(global.buf_out,buffer_seek_start,0)
	buffer_write(global.buf_out,buffer_u32,global.buf_cap);

	collisionCheck(
		buffer_get_address(global.buf_in),
		buffer_get_address(global.buf_out)
	);
	
	buffer_seek(global.buf_out,buffer_seek_start,4)
	
	var is_inside =buffer_read(global.buf_out,buffer_u32)
	var is_slide = buffer_read(global.buf_out,buffer_u32)
	var new_x =buffer_read(global.buf_out,buffer_f32)
	var new_y =buffer_read(global.buf_out,buffer_f32)
	var result = [is_inside, is_slide, new_x, new_y];
	
	return result;
}