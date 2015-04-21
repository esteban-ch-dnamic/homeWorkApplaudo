//
//  VenueVO.h
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief VenueVO is a Value Object wich is used just to represent and retain information of a Venue.
 */
@interface VenueVO : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *zip;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSArray *schedule;

@end
