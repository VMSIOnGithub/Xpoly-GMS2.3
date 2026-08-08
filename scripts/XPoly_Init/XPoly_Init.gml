// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro XPOLY_OPERATION_UNION 0
#macro XPOLY_OPERATION_DIFFERENCE 1
#macro XPOLY_OPERATION_INTERSECT 2
#macro XPOLY_OPERATION_XOR 3



function Xpoly_Init(){
	if(variable_global_exists("initialized")) return;
	global.initialized = true;
	global.buf_cap = 524288;
	global.buf_in = buffer_create(global.buf_cap,buffer_fixed,4);
	global.buf_out = buffer_create(global.buf_cap,buffer_fixed,4);
	global.buf_out_stroke = buffer_create(global.buf_cap,buffer_fixed,4);
}


function Xpoly_Is_Initialized(){
	if(!variable_global_exists("initialized")) return false;
	return global.initialized;
}

function Xpoly_Dispose(){
	global.initialized = false;
	buffer_decompress(global.buf_in)
	buffer_decompress(global.buf_out)
	buffer_decompress(global.buf_out_stroke)
}