//
//  TwitterRequest.h
//  TwitterAPI
//
//  Created by Oscar Suro on 11/19/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@protocol TwitterRequestDelegate;

@interface TwitterRequest : NSObject{
    __strong ACAccountStore *accountStore;
    ACAccount *userAccount;
}

@property (nonatomic, weak) id<TwitterRequestDelegate> delegate;

- (void) requestAuth;
- (void) tweetsForQuery:(NSString *)query;
- (void) usersForQuery:(NSString *)query;

@end

@protocol TwitterRequestDelegate
@required
- (void) didCompleteRequest:(NSArray *)requestData;
@end