/// @description Insert description here
// You can write your code in this editor
XPoly_Booleanation(objs)
with(soul){
	
	var result = Xpoly_Collision_Check(x,y,8,soul_gravity_angle);
	if(!result[0]){
		x = result[4]
		y = result[5]
	}
	
	soul_touching_ceiling = result[2]
	soul_touching_floor = result[3]
}