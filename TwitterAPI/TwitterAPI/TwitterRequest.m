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
    
    // Check for permissions for the current app
    [accountStore requestAccessToAccountsWithType:accType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accType];
            if (accounts.count > 0) {
                self.userAccount = [accounts objectAtIndex:0];
                NSLog(@"Logged as: %@", self.userAccount.username);
                return;
            }
        }
        
        // Authorization failed, tell the user to check for misconfigurations
        /*UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Upsss!"
                                  message:@"I could not connect to Twitter. Check internet connection and make sure you setup your Twitter account in your device"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];*/
    }];
}

- (void) tweetsForQuery:(NSString *)query{
    [self queryWithAPICall:kAPITweetSearch parameters:@{@"q": query, @"result_type": @"mixed"}];
}

- (void) usersForQuery:(NSString *)query{
    [self queryWithAPICall:kAPIUserSearch parameters:@{@"q": query, @"result_type": @"mixed"}];
}

- (void) queryWithAPICall:(NSString *)APIRequest parameters:(NSDictionary *)queryParams{
    if (self.userAccount == nil) {
        NSLog(@"Uninitialized account");
        return;
    }
    
    NSURL *queryURL = [NSURL URLWithString:APIRequest];
    SLRequest *actualRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                  requestMethod:SLRequestMethodGET
                                                            URL:queryURL
                                                     parameters:queryParams];
    [actualRequest setAccount:self.userAccount];
    
    [actualRequest performRequestWithHandler:^(NSData *responseData,
                                               NSHTTPURLResponse *urlResponse,
                                               NSError *error) {

        if (error){
            NSLog(@"Query Error: %@", error.localizedDescription);
            return;
        }

        if (responseData){
            // Prepare data to be sent to the delegate
            NSArray *parsedData = [self parseAPICallResponse:APIRequest data:responseData];
            
            // Call delegate method in the main thread, otherwise will shutter
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didCompleteRequest:parsedData];
            });
        }
        
    }];
}

- (NSArray *) parseAPICallResponse:(NSString *)APIRequest data:(NSData *)responseData{
    // Convert JSON data into a dictionary
    NSDictionary *serializedData = [ NSJSONSerialization JSONObjectWithData:responseData
                                                                    options:NSJSONReadingMutableLeaves
                                                                      error:nil];

    // Choose the appropiate parser for this request
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

#pragma mark - Response Parsers
- (NSArray *) parseTweetsFromResponse:(NSDictionary *)responseData{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (id item in [responseData objectForKey:@"statuses"]) {
        [data addObject:@{
         @"date": item[@"created_at"],
         @"username": item[@"user"][@"screen_name"],
         @"thumbnail": item[@"user"][@"profile_image_url"],
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
