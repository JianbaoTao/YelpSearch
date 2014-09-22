//
//  BusinessItem.h
//  Yelp
//
//  Created by Jianbao Tao on 9/21/14.
//  Copyright (c) 2014 ___JimTao___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessItem : NSObject
@property NSArray *categories;
@property NSString *itemId;
@property NSString *imageUrl;
@property BOOL isClaimed;
@property BOOL isClosed;
@property NSString *address;
@property NSString *city;
@property NSString *countryCode;
@property NSArray *displayAddress;
@property NSArray *neighborhoods;
@property NSString *postal_code;
@property NSString *stateCode;
@property NSString *name;
@property NSString *phone;
@property double rating;
@property NSString *ratingImgUrl;
@property NSString *ratingImgUrlLarge;
@property NSString *ratingImgUrlSmall;
@property int reviewCount;
@property NSString *snippetImageUrl;
@property NSString *snippetText;
@property NSString *url;

+(BusinessItem *) createFromYelpResponse:(NSDictionary *) response;


@end
