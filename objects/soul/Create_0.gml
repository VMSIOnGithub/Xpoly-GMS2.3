/// @description Insert description here
// You can write your code in this editor

#macro SOUL_RED 0
#macro SOUL_BLUE 1

//====EXTERNAL VARIBLES====
soul_speed = 3
soul_jump_speed = 7
soul_velocity = [0,0]

soul_mode = SOUL_RED

soul_gravity_angle = 0
soul_gravity_strength = 0.3
soul_gravity_velocity = 0
soul_collision_radius = 8

//=====internal variables====
soul_touching_floor = false
soul_touching_ceiling = false