//
//  ServiceHelper.m
//  iRAVE
//
//  Created by Barkha Songara on 05/01/21.
//  Copyright © 2021 Four Winds Tours & Travels. All rights reserved.
//

#import "ServiceHelper.h"
#import "constants.h"

@implementation ServiceHelper {
    ServiceCall *serviceCall;
}

// MARK:- Login & Registration APIs

+ (void)loginWithEmail:(NSString *)email onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    [ServiceCall makeRequestWithUrl:kLogin httpsMethod:@"POST" postData:@{@"email": email} onCompletion:^(NSData *responseData, NSError *error) {
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
            NSString * tokenType = [responseDict objectForKey:@"token_type"];
            NSString * accessToken = [responseDict objectForKey:@"access_token"];
            NSString *lifetime = [responseDict objectForKey:@"expires_in"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:tokenType forKey:@"token_type"];
            [[NSUserDefaults standardUserDefaults] setObject:lifetime forKey:@"lifetime"];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}


+ (void)getRegisterFormData:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    [ServiceCall makeRequestWithUrl:kGetFormData httpsMethod:@"GET" postData:@{} onCompletion:^(NSData *responseData, NSError *error) {
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}

+ (void)updateUserProfileWithEmail: (NSString *)email firstName: (NSString *)firstName lastName: (NSString *)lastName professionId:(NSNumber *)professionId specialityId:(NSNumber *)specialityId practiceId:(NSNumber *)practiceId onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    NSDictionary * dict =  @{
        @"email":email,
        @"first_name": firstName,
        @"last_name" : lastName,
        @"profession_id" : professionId,
        @"specialty_id" : specialityId,
        @"practice_id" : @2 // adding a constant value
    };
    [ServiceCall makeRequestWithUrl:kRegisteration httpsMethod:@"POST" postData:dict onCompletion:^(NSData *responseData, NSError *error) {
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}


+ (void)registerUserWithEmail: (NSString *)email firstName: (NSString *)firstName lastName: (NSString *)lastName professionId:(NSNumber *)professionId specialityId:(NSNumber *)specialityId practiceId:(NSNumber *)practiceId onSuccesCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    NSDictionary * dict =  @{
        @"email":email,
        @"first_name": firstName,
        @"last_name" : lastName,
        @"profession_id" : professionId,
        @"specialty_id" : specialityId,
        @"practice_id" : @2 // using constant value
    };
    [ServiceCall makeRequestWithUrl:kRegisteration httpsMethod:@"POST" postData:dict onCompletion:^(NSData *responseData, NSError *error) {
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
            NSString * accessToken = [responseDict objectForKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"access_token"];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
    
}

+ (void)getUserData:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    [ServiceCall makeRequestWithUrl:kGetUser httpsMethod:@"GET" postData:@{} onCompletion:^(NSData *responseData, NSError *error) {
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}

+ (void)getTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    
    [ServiceCall makeTestAPIRequestWithUrl:kGetPreTests httpsMethod:@"GET" postData:@{} onCompletion:^(NSData *responseData, NSError *error) {
        
        
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];

    
}

+ (void)getPostTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    
    [ServiceCall makeTestAPIRequestWithUrl:kGetPostTests httpsMethod:@"GET" postData:@{} onCompletion:^(NSData *responseData, NSError *error) {
        
        
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}

+ (void)getEvalTest:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    
    [ServiceCall makeTestAPIRequestWithUrl:kGetEvalTests httpsMethod:@"GET" postData:@{} onCompletion:^(NSData *responseData, NSError *error) {
        
        
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}


+ (void)attestTest:(NSDictionary *)attestTestDic onSuccessCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    
    NSDictionary * dict = attestTestDic;
    
    [ServiceCall makeTestAPIRequestWithUrl:kPostTestAttest httpsMethod:@"PUT" postData:dict onCompletion:^(NSData *responseData, NSError *error) {
        
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
}



+ (void)submitTestWithResults: (NSDictionary *)resultsDic testType: (NSString *)testType onSuccessCompletion:(SuccessCompletionHandler)completion andFailure:(FailureCompletionHandler)failureCompletion {
    NSDictionary * dict =  @{
        @"results":resultsDic,
    };
    
    NSString *url = [[NSString alloc] init];
    if ([testType isEqualToString:@"Pre-Test"]) {
        url = kSubmitPreTests;
    }
    else if ([testType isEqualToString:@"Post-Test"]) {
        url = kSubmitPostTests;
    }
    else if ([testType isEqualToString:@"Eval-Test"]) {
        url = kSubmitEvalTests;
    }
    
    [ServiceCall makeTestAPIRequestWithUrl:url httpsMethod:@"PUT" postData:dict onCompletion:^(NSData *responseData, NSError *error) {
        
        
        if (error) {
            failureCompletion(error);
        } else {
            NSError *parseError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&parseError];
            if (responseDict && responseDict.allKeys.count > 0) {
                completion(responseDict, error);
            } else {
                failureCompletion(error);
            }
        }
    }];
    
    
}


@end
