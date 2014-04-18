//
//  GRTParseAPIClient.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/9/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface GRTParseAPIClient : NSObject

+ (instancetype)sharedClient;

// GRTUser
- (void)getUsersWithCompletion:(void (^)(NSArray *users))completionBlock;

- (void) postUserWithFacebookID:(NSString *)fbookID
                     Completion:(void (^)(NSDictionary *))completion;
- (void) postUserWithName:(NSString *)name
               FacebookID:(NSString *)fbookID
               Completion:(void (^)(NSDictionary *))completion;

// GRTPosts
- (void) getPostsWithFriendIDs:(NSArray *)friendsArray
                WithCompletion:(void (^)(NSArray *posts))completionBlock;
- (void) postPostWithContent: (NSString *)content
                     section: (NSString *)section
                userObjectId: (NSString *)userObjectId
              userFacebookID: (NSString *)userFacebookID
              withCompletion: (void (^)(NSDictionary *))completion;
- (void) flagPostID:(NSString *)postObjectID;

// GRTResponse
- (void) getValidResponsesWithCompletion:(void (^)(NSArray *))completion;
                   
@end
