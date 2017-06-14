#import <UIKit/UIKit.h>
#import "BSData.h"

@interface BSPlayerModel : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end