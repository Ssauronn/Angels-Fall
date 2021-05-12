///@function Approach Number
///@argument0 StartValue
///@argument1 TargetValue
///@argument2 RateOfChangePerSecond
function approach_number(argument0, argument1, argument2) {

	var start = argument0;
	var target_ = argument1;
	var rate = argument2 / room_speed;

	if start > target_ {
		return max(start - rate, target_);
	}
	else if start < target_ {
		return min(start + rate, target_);
	}
	else {
		return target_;
	}





}
