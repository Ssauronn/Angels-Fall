///@function Round To Nth Multiple
///@argument0 ValueToRound
///@argument1 MultipleToRoundTo
var value_, multiple_;
value_ = argument0; 
multiple_ = argument1; 

var ratio_, second_ratio_;
/* THE SECTION BELOW
Get the two multiples of the multiple that the value is between (i.e., if the value provided
is 29 and the multiple is 3, this will set ratio_ to 27 and second_ratio_ to 30, since the value
is between those two multiples of the original multiple).
*/
ratio_ = value_ / multiple_; 
second_ratio_ = noone;
/* 
This if statement checks to make sure the ratio provided is positive; if it isn't, we manipulate
ratio_ and second_ratio_ below to still provide the correct multiples the number is between. 
*/
if (sign(ratio_) == 0) || (sign(ratio_) == 1) {
	if ratio_ != floor(ratio_) { 
		ratio_ = floor(ratio_); 
		second_ratio_ = ratio_ + 1; 
	}
	else {
		return value_;
	}
}
else {
	if -ratio_ != floor(-ratio_) { 
		ratio_ = floor(-ratio_);
		ratio_ = -ratio_;
		second_ratio_ = -ratio_ + 1; 
		second_ratio_ = -second_ratio_;
	}
	else {
		return value_;
	}
}

/* THE SECTION BELOW
If the first ratio variable (the multiple closer to 0 than the value) is closer to 0 than the 
second ratio variable (the multiple further away from 0 than the value), then return the multiple
times the first ratio variable (the multiple that is closer to the value). Else, return the multiple
times the second ratio variable.
*/
var first_ratio_check_, second_ratio_check_;
first_ratio_check_ = value_ - (ratio_ * multiple_);
second_ratio_check_ = value_ - (second_ratio_ * multiple_);

if first_ratio_check_ < second_ratio_check_ {
	return multiple_ * ratio_;
}
else {
	return multiple_ * second_ratio_;
}


