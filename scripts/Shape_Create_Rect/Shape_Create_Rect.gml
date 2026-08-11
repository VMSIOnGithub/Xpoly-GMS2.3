// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Shape_Create_Rect(w,h){
	var half_w = w/2.0;
	var half_h = h/2.0;
	
	return [half_w,half_h,half_w,-half_h,-half_w,-half_h,-half_w,half_h]
}

function Shape_Create_Rect_Ext(left,right,top,bottom){
	return [left,top,right,top,right,bottom,left,bottom]
}