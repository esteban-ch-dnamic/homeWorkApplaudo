//
//  VenueModel.h
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/22/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "JSONModel.h"
#import "ScheduleModel.h"

@interface VenueModel : JSONModel

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *zip;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSArray<ScheduleModel, Optional> *schedule;

@end
