<img width="642" height="512" alt="image" src="https://github.com/user-attachments/assets/3613b22f-63d6-4fb3-b504-6054b2aaae9b" />

# XPoly - GMS2 多边形运算扩展

基于 Clipper2 库的 GameMaker Studio 2 原生 DLL 扩展，提供高性能的多边形布尔运算、三角剖分、碰撞检测、仿射变换和膨胀/偏置功能。为制作undertale-like游戏提供支持。
目前只支持GMS2.3.7.606版本,如果有人需要的话会提供其他版本支持。

## 目录

- [功能概览](#功能概览)
- [安装配置](#安装配置)
- [基础使用](#基础使用)
- [API 参考](#api-参考)
  - [初始化](#初始化)
  - [形状创建辅助函数](#形状创建辅助函数)
  - [绘制函数](#绘制函数)
  - [布尔运算](#布尔运算)
  - [三角剖分](#三角剖分)
  - [碰撞检测](#碰撞检测)



---
## 功能概览

| 功能 | 说明 |
|------|------|
| **布尔运算** | 并集、交集、差集 |
| **三角剖分** | 将多边形分解为三角形，用于 GPU 渲染，解决GMS2无法渲染复杂多变形的限制 |
| **膨胀/偏置** | 多边形扩大或缩小指定像素距离，同时输出三角形，适合用于渲染描边/边框 |
| **碰撞检测** | 检测并限制"灵魂" |
| **仿射变换** | 多边形可以跟随物体平移、旋转、缩放 |
| **Surface布尔运算** | 以Surface Alpha图为单位进行布尔运算，用于最终的布尔结果绘制 |

所有运算均通过 GMS2 的 `buffer_*` 函数与 DLL 进行数据交换，无需文件 I/O。

---
## 安装配置

### 复制必要的文件即可
### 1. 导入扩展

将 `extensions/Extension_Xpoly/` 文件夹下的扩展资源导入你的 GMS2 项目。
### 2. 导入脚本

将 `scripts/` 文件夹下的以下脚本导入你的项目。这些脚本包装了 DLL 调用，提供了更友好的 GML 接口：

| 脚本名 | 用途 |
|--------|------|
| `XPoly_Init` | 初始化扩展 |
| `XPoly_Booleanation` | 多边形布尔运算 |
| `Xpoly_Surface_Boolean` | 布尔运算结果写入 Surface |
| `Xpoly_Collision_Check` | 碰撞检测 |
| `Xpoly_Draw` | 多边形绘制 |
| `Xpoly_Draw_Inflated` | 绘制膨胀后的多边形 |
| `Xpoly_Draw_Buffered_Polygons` | 绘制缓冲中的多边形 |
| `Xpoly_Clear_Buffered_Polygons` | 清空缓冲区 |
| `Shape_Create_Circle` | 创建圆形顶点数组 |
| `Shape_Create_Rect` | 创建矩形顶点数组 |
| `Shape_Create_Rect_Rounded` | 创建圆角顶点数组 |
| `Shape_Create_Star` | 创建星形顶点数组 |

### 3. 创建 init 对象

在项目的最早房间中放置一个持久化对象（如示例中的 `init` 对象），在其 **Create** 事件中初始化扩展：

```gml
// init Create 事件
XPoly_Init();
```



## 基础使用
在场景中创建polygon物体
设置polygon的vertices顶点数组，使用prio变量可以影响不同polygon物体的布尔优先级。
vertices格式: [x1,y1,x2,y2,x3,y3....]
polygon物体的位置，缩放，旋转会改变最终渲染出来的多边形以及布尔的结果，无需手动计算。
polygon_manager会在游戏中自动收集所有的polygon物体，渲染，并执行布尔运算
详细请自行阅读实例。


## API 参考

### 初始化
#### `XPoly_Init()`

初始化扩展。必须在任何其他操作之前调用。


### 形状创建辅助函数

这些函数帮助创建标准的几何形状，返回 GMS2 顶点数组[x1,x2,y1,y2....]。

#### `Shape_Create_Circle(radius, resolution)`

创建一个圆形/正多边形的顶点列表。

| 参数 | 类型 | 说明 |
|------|------|------|
| `radius` | real | 半径 |
| `resolution` | real | 分段数（越大越圆滑） |


#### `Shape_Create_Rect(w,h)`

输入长宽创建一个矩形。


#### `Shape_Create_Rect_Ext(left, right, top, bottom)`

输入上下左右的偏移量，创建一个矩形。

#### `Shape_Create_Rect_Rounded(w, h, r, segments)`

创建一个圆角矩形。

| 参数 | 类型 | 说明 |
|------|------|------|
| `r` | real | 圆角半径 |
| `segments` | real | 每个角的细分段数 |

#### `Shape_Create_Star(r1, r2, tip_count)`

创建一个星形。

| 参数 | 类型 | 说明 |
|------|------|------|
| `r1` | real | 外半径（尖角） |
| `r2` | real | 内半径（凹角） |
| `tip_count` | real | 角的数量 |

---
### 绘制函数
#### `Xpoly_Draw(points,pos_x,pos_y,rot_deg,scl_x,scl_y,org_x,org_y,is_debug=false,col_fill=c_white,col_debug=c_red)`
绘制多边形

| 参数 | 类型 | 说明 |
|------|------|------|
| `points` | [] | 顶点数组，必须是顺时针或者逆时针定义，不能有自交 |
| `pos_x` | real | 位置x |
| `pos_y` | real | 位置y |
| `rot_deg` | real | 旋转角度 |
| `scl_x` | real | 缩放x |
| `scl_y` | real | 缩放y |
| `org_x` | real | 原点x |
| `org_y` | real | 原点y |
| `is_debug` | boolean | 是否绘制调试线 |
| `col_fill` | color | 填充颜色 |
| `col_debug` | color | 调试线颜色 |

#### `Xpoly_Draw_Inflated(points, pos_x, pos_y, rot_deg, scl_x, scl_y, org_x, org_y, stroke_width, miter_limit, is_debug=false,col_fill=c_white,col_debug=c_red`
将多边形膨胀（偏置）后三角剖分并绘制。适合用来制作多边形描边

| 参数 | 类型 | 说明 |
|------|------|------|
| `points` | [] | 顶点数组，必须是顺时针或者逆时针定义，不能有自交 |
| `pos_x` | real | 位置x |
| `pos_y` | real | 位置y |
| `rot_deg` | real | 旋转角度 |
| `scl_x` | real | 缩放x |
| `scl_y` | real | 缩放y |
| `org_x` | real | 原点x |
| `org_y` | real | 原点y |
| `stroke_width` | real | 膨胀宽度(正数为膨胀，负数为收缩) |
| `miter_limit` | real | 锐角限制，数字越大，允许的锐角越尖锐。超过miter_limit的锐角会被磨平 |
| `is_debug` | boolean | 是否绘制调试线 |
| `col_fill` | color | 填充颜色 |
| `col_debug` | color | 调试线颜色 |

#### `Xpoly_Draw_Buffered_Polygons()`

绘制所有buf_out缓冲区中的多边形。一般你不需要手动调用这个函数，Draw函数里已经自动调用。

#### `Xpoly_Clear_Buffered_Polygons()`

清空多边形缓冲区。一般你不需要手动调用这个函数，Draw函数里已经自动调用。


### 布尔运算
#### `Xpoly_Booleanation(objs)`
将多变形物体列表objs进行布尔运算，并将结果写入dll内置缓存。
随后可以使用Xpoly_Collision_Check来进行碰撞检测。

#### `Xpoly_Surface_Boolean(surface1, surface2, surface_helper, op_code)`
将两个Surface进行布尔运算，并将结果写入surface1。
**op_code 对照表：**

| 值 | 运算 | 说明 |
|----|------|------|
| `0` | Union（并集） | A ∪ B |
| `1` | Intersection（交集） | A ∩ B |
| `2` | Difference（差集 A-B） | A - B |
| `3` | Xor（异或） | A ⊕ B |


### 三角剖分
`triangulation(in*, out*)`
用法请参考Xpoly_Draw，调用后将把三角形数据储存进buf_out缓冲区
```gml
//这个函数绘制输入的多边形
function Xpoly_Draw(points,pos_x,pos_y,rot_deg,scl_x,scl_y,org_x,org_y,is_debug=false,col_fill=c_white,col_debug=c_red){
	
	if(!Xpoly_Is_Initialized()) return;
	buffer_seek(global.buf_in,buffer_seek_start,0)
	buffer_write(global.buf_in,buffer_u32,global.buf_cap)
	buffer_write(global.buf_in,buffer_f32,pos_x)
	buffer_write(global.buf_in,buffer_f32,pos_y)
	buffer_write(global.buf_in,buffer_f32,rot_deg)
	buffer_write(global.buf_in,buffer_f32,scl_x)
	buffer_write(global.buf_in,buffer_f32,scl_y)
	buffer_write(global.buf_in,buffer_f32,org_x)
	buffer_write(global.buf_in,buffer_f32,org_y)
	buffer_write(global.buf_in,buffer_u32,array_length(points) div 2);
	for(var i=0;i<array_length(points);i++){
		buffer_write(global.buf_in,buffer_f32,points[i]);
	}

	Xpoly_Clear_Buffered_Polygons()

	triangulation(
		buffer_get_address(global.buf_in),
		buffer_get_address(global.buf_out)
	)

	Xpoly_Draw_Buffered_Polygons(is_debug,col_fill,col_debug)
	
}

```



### 碰撞检测
`Xpoly_Collision_Check(_x,_y,_radius,gravity_angle)`
支持任意重力方向，可得到是否碰到天花板，地板等等，详情请自行阅读示例。
请注意Xpoly_Collision_Check，必须在调用Xpoly_Booleanation，计算出最终边界后才能使用。
gravity_angle 0时为正下，随着gravity_angle增加逆时针旋转。

| 参数 | 类型 | 说明 |
|------|------|------|
| `_x` | real | 位置x |
| `_y` | real | 位置y |
| `_radius` | real | 物体半径 |
| `gravity_angle` | real | 重力方向 |
