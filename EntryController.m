//
//  EntryController.m
//  RandomizeName
//
//  Created by Brock Oberhansley on 12/28/15.
//  Copyright © 2015 Brock Oberhansley. All rights reserved.
//

#import "EntryController.h"
#import "Stack.h"

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
    });
    return sharedInstance;
}

#pragma mark - Create

- (Entry *)createName:(NSString *)name {
    
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    entry.name = name;
    
    [self saveToPersistentStorage];
    
    return entry;
}

#pragma mark - Read

- (NSArray *)entries {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    
    NSArray *fetchedObjects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects;
}

#pragma mark - Update

- (void)save{
    [self saveToPersistentStorage];
}

- (void)saveToPersistentStorage {
    
    NSError *error;
    
    [[Stack sharedInstance].managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"error: %@", error);
    }

}

#pragma mark - Delete

- (void)removeName:(Entry *)name{
    [[Stack sharedInstance].managedObjectContext deleteObject:name];
}

@end
