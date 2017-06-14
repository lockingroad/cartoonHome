//
//	BSAudio.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BSAudio.h"

NSString *const kBSAudioAudioname = @"audioname";
NSString *const kBSAudioAudiopath = @"audiopath";
NSString *const kBSAudioLanguage = @"language";

@interface BSAudio ()
@end
@implementation BSAudio




    
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBSAudioAudioname] isKindOfClass:[NSNull class]]){
		self.audioname = dictionary[kBSAudioAudioname];
	}	
	if(![dictionary[kBSAudioAudiopath] isKindOfClass:[NSNull class]]){
		self.audiopath = dictionary[kBSAudioAudiopath];
	}	
	if(![dictionary[kBSAudioLanguage] isKindOfClass:[NSNull class]]){
		self.language = dictionary[kBSAudioLanguage];
	}	
	return self;
}

    
    -(NSString*)description{
    
        return [NSString stringWithFormat:@"<%@: %p> {audioname: %@ ,audiopath: %@  }",[self class],self,self.audioname,self.audiopath];
    }

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.audioname != nil){
		dictionary[kBSAudioAudioname] = self.audioname;
	}
	if(self.audiopath != nil){
		dictionary[kBSAudioAudiopath] = self.audiopath;
	}
	if(self.language != nil){
		dictionary[kBSAudioLanguage] = self.language;
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
	if(self.audioname != nil){
		[aCoder encodeObject:self.audioname forKey:kBSAudioAudioname];
	}
	if(self.audiopath != nil){
		[aCoder encodeObject:self.audiopath forKey:kBSAudioAudiopath];
	}
	if(self.language != nil){
		[aCoder encodeObject:self.language forKey:kBSAudioLanguage];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.audioname = [aDecoder decodeObjectForKey:kBSAudioAudioname];
	self.audiopath = [aDecoder decodeObjectForKey:kBSAudioAudiopath];
	self.language = [aDecoder decodeObjectForKey:kBSAudioLanguage];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BSAudio *copy = [BSAudio new];

	copy.audioname = [self.audioname copy];
	copy.audiopath = [self.audiopath copy];
	copy.language = [self.language copy];

	return copy;
}
@end
