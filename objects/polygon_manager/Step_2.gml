/// @description Insert description here
// You can write your code in this editor
XPoly_Booleanation(objs)
with(soul){
	//3.31370849898 = 8*(sqrt[2]-1)
	var result = Xpoly_Collision_Check(x,y,8,soul_gravity_angle,3.31370849898);
	if(!result[0]){
		x = result[2]
		y = result[3]
	}
}