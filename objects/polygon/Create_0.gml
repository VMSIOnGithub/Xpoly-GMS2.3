/// @description Insert description here
// You can write your code in this editor

//自绘开关
draw_enabled = false
//debug(显示三角化)
draw_debug_enabled = false;

//顶点，格式为[x1,y1,x2,y2....]
vertices = []
//原点位置
org_x = 0
org_y = 0
//布尔类型
operation = XPOLY_OPERATION_UNION
//运算优先级
prio = 0
//独立绘制的描边宽度
stroke_width = 5.0;
//独立绘制的锐角极限，（数字越大允许的锐角越尖）
miter_limit = 6.0;
//bool_enabled设置为false将不参与异形框运算
bool_enabled = true


on_step = function(){
	
}