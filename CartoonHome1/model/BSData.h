#import <UIKit/UIKit.h>
#import "BSAudio.h"

@interface BSData : NSObject

@property (nonatomic, strong) NSArray * audio;
@property (nonatomic, strong) NSString * img;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
   
@end
