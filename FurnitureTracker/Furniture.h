//
//  Furniture.h
//  FurnitureTracker
//
//  Created by Thiago Heitling on 2016-02-05.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <Realm/Realm.h>
@class Room;

RLM_ARRAY_TYPE(furniture)

@interface Furniture : RLMObject

@property NSString *name;
@property Room *room;

@end
