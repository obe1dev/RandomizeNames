//
//  Entry+CoreDataProperties.h
//  randomizeNames
//
//  Created by Brock Oberhansley on 12/28/15.
//  Copyright © 2015 Brock Oberhansley. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entry.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entry (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
