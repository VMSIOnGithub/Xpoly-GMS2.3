soul_velocity[0] = 0;
soul_velocity[1] = 0;

if(soul_mode==SOUL_RED){
	if (keyboard_check(vk_right) && !keyboard_check(vk_left))
	{
	    soul_velocity[0] = soul_speed;
	}
	else if (keyboard_check(vk_left) && !keyboard_check(vk_right))
	{
	    soul_velocity[0] = -soul_speed;
	}

	if (keyboard_check(vk_down) && !keyboard_check(vk_up))
	{
	    soul_velocity[1] = soul_speed;
	}
	else if (keyboard_check(vk_up) && !keyboard_check(vk_down))
	{
	    soul_velocity[1] = -soul_speed;
	}
}
else if(soul_mode == SOUL_BLUE){
	var cost = cos(soul_gravity_angle/180.0*pi)
	var sint = sin(soul_gravity_angle/180.0*pi)
	
	soul_gravity_velocity += soul_gravity_strength;
	if(soul_touching_floor) soul_gravity_velocity = 0
	
	
	var tmp_velocity_x = 0
	if (keyboard_check(vk_right) && !keyboard_check(vk_left))
	{
	    tmp_velocity_x = soul_speed;
	}
	else if (keyboard_check(vk_left) && !keyboard_check(vk_right))
	{
	    tmp_velocity_x = -soul_speed;
	}
	if (keyboard_check(vk_up) && soul_touching_floor)
	{
	    soul_gravity_velocity = -soul_jump_speed;
	}
	
	
	
	soul_velocity[0]+=sint*soul_gravity_velocity;
	soul_velocity[1]+=cost*soul_gravity_velocity;
	soul_velocity[0]+=cost*tmp_velocity_x;
	soul_velocity[1]+=-sint*tmp_velocity_x;
	
}

x += soul_velocity[0];
y += soul_velocity[1];
