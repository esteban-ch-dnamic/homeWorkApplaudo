//
//  ScheduleModel.h
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/22/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "JSONModel.h"
@protocol ScheduleModel
@end

@interface ScheduleModel : JSONModel

@property (nonatomic,strong) NSString *start_date;
@property (nonatomic,strong) NSString *end_date;

@end
