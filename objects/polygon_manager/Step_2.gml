

//执行布尔运算，计算出合法区域，并缓存进buf_out
XPoly_Booleanation(objs)
//根据buf_out的缓存执行边框碰撞检测

//离散碰撞检测:如果出框则拉回来
with(soul){
	x += soul_velocity[0];
	y += soul_velocity[1];

	var result = Xpoly_Collision_Check(x,y,soul_collision_radius,soul_gravity_angle);
	if(!result[0]){
		x = result[4]
		y = result[5]
	}
	
	soul_touching_ceiling = result[2]
	soul_touching_floor = result[3]
}
