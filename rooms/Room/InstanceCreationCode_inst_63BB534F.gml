vertices = [100,100,100,-100,-100,-100,-100,100]
prio = 3
operation = XPOLY_OPERATION_DIFFERENCE
time = 0

initial_x = x

on_step = function(){
	image_angle++
	x = initial_x+sin(time*2*pi/60)*50
	
	time++;
}