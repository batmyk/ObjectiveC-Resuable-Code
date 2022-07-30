//
//  ServiceCall.m
//  iRAVE
//
//  Created by Mayank on 18/12/20.
//  Copyright © 2020 Four Winds Tours & Travels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceCall.h"
#import "constants.h"
#import "UIView+Toast.h"

@implementation ServiceCall

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

// MARK:- Helper Methods
+ (NSURL *)makeURLWithService:(NSString *)service {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_URL, service]];
}

+ (NSURL *)makeTestsURLWithService:(NSString *)service {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_URL_TESTS, service]];
}

+ (NSData *)makeJSONWithDictionary:(NSDictionary *)dict {
    return [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
}

// MARK:- Send Connection Request

+ (void)makeRequestWithUrl:(NSString *)endPoint httpsMethod:(NSString *)httpMentod postData:(NSDictionary *)postDict onCompletion:(RequestCompletion)completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = 10;
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setURL:[self makeURLWithService:endPoint]];
//    if (![endPoint isEqual:kGetUser]) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
//    }
    [request setHTTPMethod:httpMentod];
    if (postDict.allKeys.count > 0) {
        [request setHTTPBody:[self makeJSONWithDictionary:postDict]];
    }
    [self sendRequest:request onCompletion:completion];
}

+ (void)makeTestAPIRequestWithUrl:(NSString *)endPoint httpsMethod:(NSString *)httpMentod postData:(NSDictionary *)postDict onCompletion:(RequestCompletion)completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    [request setURL:[self makeTestsURLWithService:endPoint]];
    
    [request setHTTPMethod:httpMentod];
    if (postDict.allKeys.count > 0) {
        [request setHTTPBody:[self makeJSONWithDictionary:postDict]];
    }
    [self sendRequest:request onCompletion:completion];
}


+ (void)sendRequest:(NSURLRequest *)request onCompletion:(RequestCompletion)completion {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse * httpResponse  = (NSHTTPURLResponse*)response;
        NSInteger statusCode = httpResponse.statusCode;
        if (statusCode == 200) {
            completion(data, error);
        } else {
            completion(data, error);
        }
    }];
    [dataTask resume];
    
    /*NSOperationQueue *queue = [NSOperationQueue mainQueue];
     [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     
     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
     
     if (data) {
     NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
     
     @try {
     if ((long)[httpResponse statusCode] == 200) {
     // We're getting token only on Login API
     if ([self.serviceName isEqualToString:kLogin]) {
     NSString * tokenType = [dict objectForKey:@"token_type"];
     NSString * accessToken = [dict objectForKey:@"access_token"];
     NSString *lifetime = [dict objectForKey:@"expires_in"];
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
     [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"access_token"];
     [[NSUserDefaults standardUserDefaults] setObject:tokenType forKey:@"token_type"];
     [[NSUserDefaults standardUserDefaults] setObject:lifetime forKey:@"lifetime"];
     }
     }
     }
     @catch (NSException *exception) { }
     
     // Forwarding data using protocol & delegate.
     if ([self.delegate respondsToSelector:@selector(communication:didReceiveData:serviceName:)]) {
     
     [self.delegate communication:self didReceiveData:dict serviceName:self.serviceName];
     }
     }
     }];*/
}



@end
