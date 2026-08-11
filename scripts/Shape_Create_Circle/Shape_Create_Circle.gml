// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Shape_Create_Circle(radius, resolution=16){
	var result = []
	for(var i=0;i<resolution;i++){
		array_push(result,cos(2*pi*i/resolution)*radius)
		array_push(result,sin(2*pi*i/resolution)*radius)
	}
	return result;
}