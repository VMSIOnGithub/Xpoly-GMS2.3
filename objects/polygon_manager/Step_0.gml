/// @description Insert description here
// You can write your code in this editor
array_resize(objs,0)

with(polygon){
	if(bool_enabled)
		array_push(other.objs,self)
}
array_sort(objs, function(a, b) {
    return a.prio - b.prio;
});