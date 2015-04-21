//
//  VenuesAPI.h
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VenueAPICompletionHandler)(BOOL succes,NSError *error);;

@interface VenuesAPI : NSObject

/*!
 *  @brief Returns the shared instances of this singleton class.
 */
+(instancetype)sharedInstance;

/*!
 *  @brief Request the venues data from the corresponding server
 *  @param A VenueAPICompletionHandler typedef that will return if the request was succed or failed.
 */
- (void) requestVenuesWithCompletionHandler:(VenueAPICompletionHandler)completionHandler;

@end
