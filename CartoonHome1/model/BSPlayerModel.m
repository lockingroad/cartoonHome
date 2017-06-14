//
//	BSPlayerModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BSPlayerModel.h"

NSString *const kBSPlayerModelData = @"data";
NSString *const kBSPlayerModelStatus = @"status";
NSString *const kBSPlayerModelTitle = @"title";

@interface BSPlayerModel ()
@end
@implementation BSPlayerModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kBSPlayerModelData] != nil && [dictionary[kBSPlayerModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kBSPlayerModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			BSData * dataItem = [[BSData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kBSPlayerModelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kBSPlayerModelStatus] boolValue];
	}

	if(![dictionary[kBSPlayerModelTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kBSPlayerModelTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(BSData * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kBSPlayerModelData] = dictionaryElements;
	}
	dictionary[kBSPlayerModelStatus] = @(self.status);
	if(self.title != nil){
		dictionary[kBSPlayerModelTitle] = self.title;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kBSPlayerModelData];
	}
	[aCoder encodeObject:@(self.status) forKey:kBSPlayerModelStatus];	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kBSPlayerModelTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kBSPlayerModelData];
	self.status = [[aDecoder decodeObjectForKey:kBSPlayerModelStatus] boolValue];
	self.title = [aDecoder decodeObjectForKey:kBSPlayerModelTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BSPlayerModel *copy = [BSPlayerModel new];

	copy.data = [self.data copy];
	copy.status = self.status;
	copy.title = [self.title copy];

	return copy;
}
@end