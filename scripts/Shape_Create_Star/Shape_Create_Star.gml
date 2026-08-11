
function Shape_Create_Star(r1,r2,tip_count){
	var true_count = tip_count*2;
	var result = []
	for(var i=0;i<true_count;i++){
		var radius = r2;
		if(i%2==0){
			radius = r1;
		}
		array_push(result,cos(2*pi*(i-0.5)/true_count)*radius)
		array_push(result,sin(2*pi*(i-0.5)/true_count)*radius)
	}
	
	return result;
	
}