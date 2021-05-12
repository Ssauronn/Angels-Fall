/// @function approach_number(startValue, targetValue, rateOfChangePerSecond);
/// @param {real} startValue
/// @param {real} targetValue
/// @param {real} rateOfChangePerSecond
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


