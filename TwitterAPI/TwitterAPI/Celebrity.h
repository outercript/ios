//
//  Celebrity.h
//  TwitterAPI
//
//  Created by Administrador on 11/26/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Celebrity : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * realName;
@property (nonatomic, retain) NSString * userPhoto;

@end
