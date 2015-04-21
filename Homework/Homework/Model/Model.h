//
//  Model.h
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 *  @brief The Model class will hold the data of the application, data which is loaded by the VenuesAPI class from a server.
 */
@interface Model : NSObject

/*!
 *  @brief The array will hold all the venuesVO objects loaded by the VenuesAPI
 */
@property (nonatomic,strong) NSMutableArray *venuesArray;

/*!
 *  @brief Returns the shared instances of this singleton class.
 */
+(instancetype)sharedInstance;


@end
