//
//  GRTGreatistAPIClient.h
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/10/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Section+Methods.h"
#import "Article+Methods.h"

extern const NSString *clientID;
extern const NSString *secret;

@interface GRTGreatistAPIClient : NSObject


- (void) postForAccessTokenWithCompletion:(void (^)(NSDictionary *))completion;

- (void) getArticlesWithCompletion:(void (^)(NSDictionary *))completion;

- (void)retrieveArticlesWithCompletion:(void (^)(NSArray *))completion;


- (void) postArticleWithArticleURL: (NSString *)articleURL
                          headline: (NSString *)headline
                          imageURL: (NSString *)imageURL
                         timeStamp: (NSDate *)timeStamp;


//For the header, the key should be Authorization and the value should be "Basic token_encoded" where token_encoded is the Base64 encode of client_id:secret
//The payload should be grant_type=client_credentials

//This should return an access token that you then append to any request to our API endpoint:
///api/articles_since
///api/articles_since/2013/
///api/articles_since/2013/1/23

@end
