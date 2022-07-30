//
//  ServiceHelper.h
//  iRAVE
//
//  Created by Barkha Songara on 05/01/21.
//  Copyright © 2021 Four Winds Tours & Travels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceCall.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SuccessCompletionHandler)(id response, NSError *error);
typedef void(^FailureCompletionHandler)(NSError *error);

@interface ServiceHelper : NSObject

+ (void)loginWithEmail:(NSString *)email onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)getRegisterFormData:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)updateUserProfileWithEmail: (NSString *)email firstName: (NSString *)firstName lastName: (NSString *)lastName professionId:(NSNumber *)professionId specialityId:(NSNumber *)specialityId practiceId:(NSNumber *)practiceId onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)registerUserWithEmail: (NSString *)email firstName: (NSString *)firstName lastName: (NSString *)lastName professionId:(NSNumber *)professionId specialityId:(NSNumber *)specialityId practiceId:(NSNumber *)practiceId onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)getUserData:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;

+ (void)getTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)getPostTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)getEvalTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;
+ (void)submitTestWithResults:(NSDictionary *)resultsDic testType:(NSString *)testType onSuccessCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;

+ (void)attestTest:(NSDictionary *)attestTestDic onSuccessCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion;

@end

NS_ASSUME_NONNULL_END
