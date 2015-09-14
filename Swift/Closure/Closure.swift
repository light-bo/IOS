/**
 *
 * closure sample codes
 *
 */

#import Foundation


func hasClosureMatch(arr:[Int], cb:(number:Int)->Bool) -> Bool {
	for item in arr {
		if(cb(number:item)) {
			return true;
		}
	}

	return false;
}

var arr = [100, 12, 20, 30, 50];

var result = hasClosureMatch(arr, {
		(number:Int) -> Bool in //implementation the closure
		return number > 100;
		});


println(result)








