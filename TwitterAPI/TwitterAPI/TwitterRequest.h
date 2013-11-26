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
}

@property (nonatomic, weak) id<TwitterRequestDelegate> delegate;
@property (retain, strong) ACAccount *userAccount;

- (void) requestAuth;
- (void) tweetsForQuery:(NSString *)query;
- (void) usersForQuery:(NSString *)query;

@end

@protocol TwitterRequestDelegate
@required
- (void) didCompleteRequest:(NSArray *)requestData;
@end