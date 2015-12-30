//
//  EntryController.h
//  RandomizeName
//
//  Created by Brock Oberhansley on 12/28/15.
//  Copyright © 2015 Brock Oberhansley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface EntryController : NSObject

@property (strong, nonatomic, readonly) NSArray *entries;

+ (EntryController *)sharedInstance;

- (Entry *)createName:(NSString *)name;

- (void)removeName:(Entry *)name;

- (void)save;

@end
