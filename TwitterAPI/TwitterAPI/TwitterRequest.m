//
//  TwitterRequest.m
//  TwitterAPI
//
//  Created by Oscar Suro on 11/19/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "TwitterRequest.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

static NSString* kAPITweetSearch = @"https://api.twitter.com/1.1/search/tweets.json";
static NSString* kAPIUserSearch = @"https://api.twitter.com/1.1/users/search.json";

@implementation TwitterRequest

- (void) requestAuth{
    accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accType];
            if (accounts.count > 0) {
                userAccount = [accounts objectAtIndex:0];
                NSLog(@"Logged as: %@", userAccount.username);
                return;
            }
        }
        NSLog(@"Failed Auth");
    }];
}

- (void) tweetsForQuery:(NSString *)query{
    [self queryWithAPICall:kAPITweetSearch parameters:@{@"q": query, @"result_type": @"popular"}];
}

- (void) usersForQuery:(NSString *)query{
    [self queryWithAPICall:kAPIUserSearch parameters:@{@"q": query, @"result_type": @"popular"}];
}

- (void) queryWithAPICall:(NSString *)APIRequest parameters:(NSDictionary *)queryParams{
    if (userAccount == nil) {
        NSLog(@"Uninitialized account");
        return;
    }
    
    NSURL *queryURL = [NSURL URLWithString:APIRequest];
    SLRequest *actualRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                  requestMethod:SLRequestMethodGET
                                                            URL:queryURL
                                                     parameters:queryParams];
    [actualRequest setAccount:userAccount];
    
    [actualRequest performRequestWithHandler:^(NSData *responseData,
                                               NSHTTPURLResponse *urlResponse,
                                               NSError *error) {
        if (error){
            NSLog(@"Query Error: %@", error.localizedDescription);
            return;
        }
        
        if (responseData){
            NSArray *parsedData = [self parseAPICallResponse:APIRequest data:responseData];
            [self.delegate didCompleteRequest:parsedData];
        }
    }];
}

- (NSArray *) parseAPICallResponse:(NSString *)APIRequest data:(NSData *)responseData{
    NSDictionary *serializedData = [ NSJSONSerialization JSONObjectWithData:responseData
                                                                    options:NSJSONReadingMutableLeaves
                                                                      error:nil];
    if (APIRequest == kAPITweetSearch) {
        return [self parseTweetsFromResponse:serializedData];
    }
    else if (APIRequest == kAPIUserSearch){
        return [self parseUsersFromResponse:serializedData];
    }
    else{
        return @[];
    }
}


- (NSArray *) parseTweetsFromResponse:(NSDictionary *)responseData{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (id item in [responseData objectForKey:@"statuses"]) {
        [data addObject:@{
         @"date": item[@"created_at"],
         @"username": item[@"user"][@"screen_name"],
         @"content": item[@"text"]
         }];
    }
    return data;
}

- (NSArray *) parseUsersFromResponse:(NSDictionary *)responseData{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (id item in responseData) {
        [data addObject:@{
         @"name": item[@"name"],
         @"username": item[@"screen_name"],
         @"url": item[@"url"]
         }];
    }
    return data;
}

@end
