//
//  Room.h
//  FurnitureTracker
//
//  Created by Thiago Heitling on 2016-02-05.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import <Realm/Realm.h>
#import "Furniture.h"

RLM_ARRAY_TYPE(Furniture)

@interface Room : RLMObject

@property NSString *name;
@property RLMArray <Furniture *><Furniture> *furnitures;

@end
