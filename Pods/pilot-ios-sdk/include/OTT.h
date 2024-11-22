//
//  OTT.h
//  pilot-ios-sdk
//
//  Created by DinhPhuc on 23/01/2024.
//

#import <Foundation/Foundation.h>
#import "SmMonitor.h"
#import "SmCustomData.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTT : NSObject
+(OTT *)getInstance;
-(void)initialize:(NSString *)clientKey;
-(NSString *)generate:(NSString *)url configKey:(NSString *)configKey;
@end

NS_ASSUME_NONNULL_END
