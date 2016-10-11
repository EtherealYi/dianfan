//
//  DFUser.m
//  点范
//
//  Created by Masteryi on 16/9/8.
//  Copyright © 2016年 Masteryi. All rights reserved.
//

#import "DFUser.h"

@implementation DFUser

+ (DFUser *)sharedManager{
    
    static DFUser *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
    
    
}

- (void)initWithDict:(NSDictionary *)dict{
    //self = [super init];
    self.username = [dict objectForKey:@"username"];
    self.token = [dict objectForKey:@"token"];
    
}
@end
