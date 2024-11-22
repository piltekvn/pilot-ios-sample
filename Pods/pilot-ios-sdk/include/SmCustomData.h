//
//  SmCustomData.h
//  pilot-ios
//
//  Created by Kinniji on 18/10/24.
//

#import <Foundation/Foundation.h>

@interface SmCustomData : NSObject

// Khai báo thuộc tính (properties)
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *streamType;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *series;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoSourceUrl;

@end
