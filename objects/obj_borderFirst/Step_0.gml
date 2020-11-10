/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
function ArrayToFloat(array) {
	var temp = 0;
	var weishu = -4;
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			temp += array[cc][dd] * power(10, weishu);
			weishu += 1;
		}
	}
	return temp;
}

if (global.state == "calculate") {
	processValueMap = ds_map_create();
	step = 0;
	diedai = 0;
	for (var cc = 0; cc < 3; cc++) {
		originArray[cc] = array_create(3);
		array_copy(originArray[cc], 0, cubeArray[cc], 0, 3);
	}
	var array1 = array_create(9);
	var array2 = array_create(9);
	targetCubeArray = instance_find(obj_borderSecond, 0).cubeArray;
	var count = 0;
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			array1[count] = cubeArray[dd][cc];
			count += 1;
		}
	}
	count = 0;
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			array2[count] = targetCubeArray[dd][cc];
			count += 1;
		}
	}
	var backward1 = 0;
	var backward2 = 0;
	//逆序数判定
	for (var cc = 0; cc < array_length(array1) - 1; cc++) {
		for (var dd = cc + 1; dd < array_length(array1); dd++) {
			if (array1[cc] !=0 && array1[dd] != 0 && array1[cc] > array1[dd]) {
				backward1 += 1;
			}
			if (array2[cc] !=0 && array2[dd] != 0 && array2[cc] > array2[dd]) {
				backward2 += 1;
			}
		}
	}
	if ((backward1 - backward2) % 2 != 0) {
		global.state = "fail";
		return;
	}
	//可以转换，则进行启发式搜索
	var count = 0;
	var wdnmd = true;
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			if (cubeArray[cc][dd] != targetCubeArray[cc][dd]) {
				wdnmd = false;
				break;
			}
		}
	}
	ds_map_add(processValueMap, count, originArray);
	if (wdnmd) {
		ds_stack_push(resultStack, 0);
		global.state = "complete";
		return;
	}
	ds_priority_add(selfPriQueue, count, 1);
	var tempCubeArrayMap = ds_map_create();
	ds_map_add(tempCubeArrayMap, "fatherValue", -1);
	ds_map_add(tempCubeArrayMap, "stepCount", 0);
	ds_map_add_map(processArrayMap, ArrayToFloat(cubeArray), tempCubeArrayMap);
	while (!ds_priority_empty(selfPriQueue)) {	//优先队列不空则一直遍历
		//弹出优先队列第一个元素，并将其加入到processArrayMap中
		diedai += 1;
		var tempArrayId = ds_priority_find_min(selfPriQueue);
		ds_priority_delete_value(selfPriQueue, tempArrayId);
		var tempCubeArray = processValueMap[? tempArrayId];
		var tempCubeArrayInfor = processArrayMap[? ArrayToFloat(tempCubeArray)];
		var zeroX = 0;
		var zeroY = 0;
		//找到数组中0的位置
		for (var cc = 0; cc < 3; cc++) {
			for (var dd = 0; dd < 3; dd++) {
				if (tempCubeArray[cc][dd] == 0) {
					zeroX = cc;
					zeroY = dd;
					break;
				}
			}
		}
		//现在拥有了0的x和y的位置，可以进行不同情况的搜索了
		//首先，先获得不同情况的数组
		if (zeroX > 0) {
			var tempArrayToChange = array_create(3);
			for (var cc = 0; cc < 3; cc++) {
				tempArrayToChange[cc] = array_create(3);
				array_copy(tempArrayToChange[cc], 0, tempCubeArray[cc], 0, 3);
			}
			tempArrayToChange[zeroX][zeroY] = tempArrayToChange[zeroX - 1][zeroY];
			tempArrayToChange[zeroX - 1][zeroY] = 0;
			//若新数组状态是否曾经未出现过，则将其加入map和优先队列
			if (!ds_map_exists(processArrayMap, ArrayToFloat(tempArrayToChange))) {
				//processValueMap
				count++;
				ds_map_add(processValueMap, count, tempArrayToChange);
				//processArrayMap
				var tempCubeArrayMap = ds_map_create();
				ds_map_add(tempCubeArrayMap, "fatherValue", tempArrayId);
				ds_map_add(tempCubeArrayMap, "stepCount",
					tempCubeArrayInfor[? "stepCount"] + 1);
				ds_map_add_map(processArrayMap, ArrayToFloat(tempArrayToChange), tempCubeArrayMap);
				//selfPriQueue
				var priority = 0;
				for (var cc = 0; cc < 3; cc++) {	//获取有几个方块相同，作为权重
					for (var dd = 0; dd < 3; dd++) {
						if (tempArrayToChange[cc][dd] == targetCubeArray[cc][dd]) {
							priority += 1;
						}
					}
				}
				priority = 9 - priority;
				if (priority == 0) {
					var currPoint = count;
					ds_stack_push(resultStack, currPoint);
					while (true) {
						var tempStackArray = processValueMap[? currPoint];
						var fatherId = processArrayMap[? ArrayToFloat(tempStackArray)][? "fatherValue"];
						if (fatherId == -1) {	//找到根了
							break;
						}
						ds_stack_push(resultStack, fatherId);
						currPoint = fatherId;
					}
					global.state = "complete";
					break;
				}
				priority += tempCubeArrayInfor[? "stepCount"] + qifaCount;	//损失权重补正
				ds_priority_add(selfPriQueue, count, priority);
			}
		}
		if (zeroX < 2) {
			var tempArrayToChange = array_create(3);
			for (var cc = 0; cc < 3; cc++) {
				tempArrayToChange[cc] = array_create(3);
				array_copy(tempArrayToChange[cc], 0, tempCubeArray[cc], 0, 3);
			}
			tempArrayToChange[zeroX][zeroY] = tempArrayToChange[zeroX + 1][zeroY];
			tempArrayToChange[zeroX + 1][zeroY] = 0;
			//若新数组状态是否曾经未出现过，则将其加入map和优先队列
			if (!ds_map_exists(processArrayMap, ArrayToFloat(tempArrayToChange))) {
				//processValueMap
				count++;
				ds_map_add(processValueMap, count, tempArrayToChange);
				//processArrayMap
				var tempCubeArrayMap = ds_map_create();
				ds_map_add(tempCubeArrayMap, "fatherValue", tempArrayId);
				ds_map_add(tempCubeArrayMap, "stepCount",
					tempCubeArrayInfor[? "stepCount"] + 1);
				ds_map_add_map(processArrayMap, ArrayToFloat(tempArrayToChange), tempCubeArrayMap);
				//selfPriQueue
				var priority = 0;
				for (var cc = 0; cc < 3; cc++) {	//获取有几个方块相同，作为权重
					for (var dd = 0; dd < 3; dd++) {
						if (tempArrayToChange[cc][dd] == targetCubeArray[cc][dd]) {
							priority += 1;
						}
					}
				}
				priority = 9 - priority;
				if (priority == 0) {
					var currPoint = count;
					ds_stack_push(resultStack, currPoint);
					while (true) {
						var tempStackArray = processValueMap[? currPoint];
						var fatherId = processArrayMap[? ArrayToFloat(tempStackArray)][? "fatherValue"];
						if (fatherId == -1) {	//找到根了
							break;
						}
						ds_stack_push(resultStack, fatherId);
						currPoint = fatherId;
					}
					global.state = "complete";
					break;
				}
				priority += tempCubeArrayInfor[? "stepCount"] + qifaCount;	//损失权重补正
				ds_priority_add(selfPriQueue, count, priority);
			}
		}
		if (zeroY > 0) {
			var tempArrayToChange = array_create(3);
			for (var cc = 0; cc < 3; cc++) {
				tempArrayToChange[cc] = array_create(3);
				array_copy(tempArrayToChange[cc], 0, tempCubeArray[cc], 0, 3);
			}
			tempArrayToChange[zeroX][zeroY] = tempArrayToChange[zeroX][zeroY - 1];
			tempArrayToChange[zeroX][zeroY - 1] = 0;
			//若新数组状态是否曾经未出现过，则将其加入map和优先队列
			if (!ds_map_exists(processArrayMap, ArrayToFloat(tempArrayToChange))) {
				//processValueMap
				count++;
				ds_map_add(processValueMap, count, tempArrayToChange);
				//processArrayMap
				var tempCubeArrayMap = ds_map_create();
				ds_map_add(tempCubeArrayMap, "fatherValue", tempArrayId);
				ds_map_add(tempCubeArrayMap, "stepCount",
					tempCubeArrayInfor[? "stepCount"] + 1);
				ds_map_add_map(processArrayMap, ArrayToFloat(tempArrayToChange), tempCubeArrayMap);
				//selfPriQueue
				var priority = 0;
				for (var cc = 0; cc < 3; cc++) {	//获取有几个方块相同，作为权重
					for (var dd = 0; dd < 3; dd++) {
						if (tempArrayToChange[cc][dd] == targetCubeArray[cc][dd]) {
							priority += 1;
						}
					}
				}
				priority = 9 - priority;
				if (priority == 0) {
					var currPoint = count;
					ds_stack_push(resultStack, currPoint);
					while (true) {
						var tempStackArray = processValueMap[? currPoint];
						var fatherId = processArrayMap[? ArrayToFloat(tempStackArray)][? "fatherValue"];
						if (fatherId == -1) {	//找到根了
							break;
						}
						ds_stack_push(resultStack, fatherId);
						currPoint = fatherId;
					}
					global.state = "complete";
					break;
				}
				priority += tempCubeArrayInfor[? "stepCount"] + qifaCount;	//损失权重补正
				ds_priority_add(selfPriQueue, count, priority);
			}
		}
		if (zeroY < 2) {
			var tempArrayToChange = array_create(3);
			for (var cc = 0; cc < 3; cc++) {
				tempArrayToChange[cc] = array_create(3);
				array_copy(tempArrayToChange[cc], 0, tempCubeArray[cc], 0, 3);
			}
			tempArrayToChange[zeroX][zeroY] = tempArrayToChange[zeroX][zeroY + 1];
			tempArrayToChange[zeroX][zeroY + 1] = 0;
			//若新数组状态是否曾经未出现过，则将其加入map和优先队列
			if (!ds_map_exists(processArrayMap, ArrayToFloat(tempArrayToChange))) {
				//processValueMap
				count++;
				ds_map_add(processValueMap, count, tempArrayToChange);
				//processArrayMap
				var tempCubeArrayMap = ds_map_create();
				ds_map_add(tempCubeArrayMap, "fatherValue", tempArrayId);
				ds_map_add(tempCubeArrayMap, "stepCount",
					tempCubeArrayInfor[? "stepCount"] + 1);
				ds_map_add_map(processArrayMap, ArrayToFloat(tempArrayToChange), tempCubeArrayMap);
				//selfPriQueue
				var priority = 0;
				for (var cc = 0; cc < 3; cc++) {	//获取有几个方块相同，作为权重
					for (var dd = 0; dd < 3; dd++) {
						if (tempArrayToChange[cc][dd] == targetCubeArray[cc][dd]) {
							priority += 1;
						}
					}
				}
				priority = 9 - priority;
				if (priority == 0) {
					var currPoint = count;
					ds_stack_push(resultStack, currPoint);
					while (true) {
						var tempStackArray = processValueMap[? currPoint];
						var fatherId = processArrayMap[? ArrayToFloat(tempStackArray)][? "fatherValue"];
						if (fatherId == -1) {	//找到根了
							break;
						}
						ds_stack_push(resultStack, fatherId);
						currPoint = fatherId;
					}
					global.state = "complete";
					break;
				}
				priority += tempCubeArrayInfor[? "stepCount"] + qifaCount;	//损失权重补正
				ds_priority_add(selfPriQueue, count, priority);
			}
		}
		var tempArrayId = ds_priority_find_min(selfPriQueue);
		var tempCubeArray = processValueMap[? tempArrayId];
	}
}
if (global.state == "complete") {
	if (animateFlag) {
		step = ds_stack_size(resultStack) - 1;
		ds_stack_copy(alterStack, resultStack);
		alarm[0] = 1;	//放到警报器中去执行
		animateFlag = false;
	}
}
if (global.state == "again") {
	if (animateFlag) {
		ds_stack_copy(resultStack, alterStack);
		alarm[1] = 1;	//放到警报器中去执行
		animateFlag = false;
	}
}