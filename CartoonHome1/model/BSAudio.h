#import <UIKit/UIKit.h>

@interface BSAudio : NSObject

@property (nonatomic, strong) NSArray * audioname;
@property (nonatomic, strong) NSString * audiopath;
@property (nonatomic, strong) NSString * language;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end