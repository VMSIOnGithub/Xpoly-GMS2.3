<img width="642" height="512" alt="image" src="https://github.com/user-attachments/assets/3613b22f-63d6-4fb3-b504-6054b2aaae9b" />

# XPoly - GMS2 多边形运算扩展

基于 Clipper2 库的 GameMaker Studio 2 原生 DLL 扩展，提供高性能的多边形布尔运算、三角剖分、碰撞检测、仿射变换和膨胀/偏置功能。

## 目录

- [功能概览](#功能概览)
- [安装配置](#安装配置)
- [API 参考](#api-参考)
  - [初始化](#初始化)
  - [形状创建辅助函数](#形状创建辅助函数)
  - [布尔运算](#布尔运算)
  - [三角剖分](#三角剖分)
  - [碰撞检测](#碰撞检测)
  - [仿射变换](#仿射变换)
  - [绘制函数](#绘制函数)
  - [调试工具](#调试工具)



---
## 功能概览

| 功能 | 说明 |
|------|------|
| **布尔运算** | 并集、交集、差集、异或 |
| **三角剖分** | 将多边形分解为三角形，用于 GPU 渲染，解决GMS2无法渲染复杂多变形的限制 |
| **膨胀/偏置** | 多边形扩大或缩小指定像素距离，同时输出三角形 |
| **碰撞检测** | 检测两个多边形是否重叠 |
| **仿射变换** | 平移、旋转、缩放多边形 |
| **碰撞交叉点** | 计算两个多边形碰撞产生的交集多边形 |
| **点到 Surface** | 将布尔运算/碰撞结果直接写入 Surface 缓冲区用于绘制 |

所有运算均通过 GMS2 的 `buffer_*` 函数与 DLL 进行数据交换，无需文件 I/O。

---
## 安装配置

### 复制必要的文件即可
这个项目当前在GameMakerStudio2.3.7.606下创建。
如果有人需要会更新支持其他版本。


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
| `Xpoly_Draw` | 执行多边形交集/合并并绘制 |
| `Xpoly_Draw_Buffered_Polygons` | 绘制缓冲的多边形 |
| `Xpoly_Clear_Buffered_Polygons` | 清空缓冲区 |
| `Xpoly_Draw_Debug_Segment` | 绘制调试线段 |
| `Xpoly_Draw_Inflated` | 绘制膨胀后的多边形 |
| `Xpoly_Draw_Triangulated` | 绘制三角剖分结果 |
| `Xpoly_Draw_Triangulated_Inflated` | 绘制膨胀并三角剖分的结果 |
| `Xpoly_Debug_Log_Buffer` | 输出缓冲区调试信息 |
| `Shape_Create_Circle` | 创建圆形顶点缓冲区 |
| `Shape_Create_Rect` | 创建矩形顶点缓冲区 |
| `Shape_Create_Rect_Rounded` | 创建圆角矩形顶点缓冲区 |
| `Shape_Create_Star` | 创建星形顶点缓冲区 |

### 3. 创建 init 对象

在项目的最早房间中放置一个持久化对象（如示例中的 `init` 对象），在其 **Create** 事件中初始化扩展：

```gml
// init Create 事件
XPoly_Init();
```


## API 参考

### 初始化
#### `XPoly_Init()`

初始化扩展。必须在任何其他操作之前调用。


### 形状创建辅助函数

这些函数帮助创建标准的几何形状，返回 GMS2 顶点数组[x1,x2,y1,y2....]。

#### `Shape_Create_Circle(cx, cy, radius, segments)`

创建一个圆形/正多边形的顶点列表。

| 参数 | 类型 | 说明 |
|------|------|------|
| `cx` | real | 圆心 X 坐标 |
| `cy` | real | 圆心 Y 坐标 |
| `radius` | real | 半径 |
| `segments` | real | 分段数（越大越圆滑） |

```gml
var circle = Shape_Create_Circle(400, 300, 100, 32);
```
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