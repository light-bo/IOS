//init model with dictionary data 
NSError *errorInfo = nil;
model = [[BaseReportInfoModel alloc] initWithDictionary:data 
					          error:&errorInfo];
if(errorInfo) {
	//...
}


//init model with array data
NSError *errorInfo = nil;
NSArray *dataArray = [[NSArray alloc] init];

dataArray = [model arrayOfModelsFromDictionaries:data error:&errorInfo];

