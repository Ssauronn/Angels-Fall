///@function Approach Number
///@argument0 StartValue
///@argument1 TargetValue
///@argument2 RateOfChangePerSecond

var start = argument0;
var target = argument1;
var rate = argument2 / 60;

if start > target {
	return max(start - rate, target);
}
else if start < target {
	return min(start + rate, target);
}
else return target;


