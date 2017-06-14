//
//	BSData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BSData.h"

NSString *const kBSDataAudio = @"audio";
NSString *const kBSDataImg = @"img";

@interface BSData ()
@end
@implementation BSData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kBSDataAudio] != nil && [dictionary[kBSDataAudio] isKindOfClass:[NSArray class]]){
		NSArray * audioDictionaries = dictionary[kBSDataAudio];
		NSMutableArray * audioItems = [NSMutableArray array];
		for(NSDictionary * audioDictionary in audioDictionaries){
			BSAudio * audioItem = [[BSAudio alloc] initWithDictionary:audioDictionary];
			[audioItems addObject:audioItem];
		}
		self.audio = audioItems;
	}
	if(![dictionary[kBSDataImg] isKindOfClass:[NSNull class]]){
		self.img = dictionary[kBSDataImg];
	}	
	return self;
}
    
    -(NSString*)description{
        
        return [NSString stringWithFormat:@"<%@: %p> {audio: %@ ,img: %@ }",[self class],self,self.audio,self.img];
    }

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.audio != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(BSAudio * audioElement in self.audio){
			[dictionaryElements addObject:[audioElement toDictionary]];
		}
		dictionary[kBSDataAudio] = dictionaryElements;
	}
	if(self.img != nil){
		dictionary[kBSDataImg] = self.img;
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
	if(self.audio != nil){
		[aCoder encodeObject:self.audio forKey:kBSDataAudio];
	}
	if(self.img != nil){
		[aCoder encodeObject:self.img forKey:kBSDataImg];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.audio = [aDecoder decodeObjectForKey:kBSDataAudio];
	self.img = [aDecoder decodeObjectForKey:kBSDataImg];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BSData *copy = [BSData new];

	copy.audio = [self.audio copy];
	copy.img = [self.img copy];

	return copy;
}
@end
