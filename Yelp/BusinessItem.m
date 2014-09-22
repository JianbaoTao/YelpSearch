//
//  BusinessItem.m
//  Yelp
//
//  Created by Jianbao Tao on 9/21/14.
//  Copyright (c) 2014 ___JimTao___. All rights reserved.
//

#import "BusinessItem.h"

@implementation BusinessItem

+ (BusinessItem *) createFromYelpResponse:(NSDictionary *)response {
    BusinessItem *item = [[BusinessItem alloc]init];
    return item;
}

@end
