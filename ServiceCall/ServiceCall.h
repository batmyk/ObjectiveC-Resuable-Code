//
//  ServiceCall.h
//  iRAVE
//
//  Created by Mayank on 18/12/20.
//  Copyright © 2020 Four Winds Tours & Travels. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompletion)(NSData *responseData, NSError *error);

@interface ServiceCall : NSObject

+ (void)makeRequestWithUrl:(NSString *)endPoint httpsMethod:(NSString *)httpMentod postData:(NSDictionary *)postDict onCompletion:(RequestCompletion)completion;

+ (void)makeTestAPIRequestWithUrl:(NSString *)endPoint httpsMethod:(NSString *)httpMentod postData:(NSDictionary *)postDict onCompletion:(RequestCompletion)completion;

@end
