//
//  VenuesAPI.m
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "VenuesAPI.h"
#import "VenueVO.h"
#import "Model.h"

#import <AFNetworking/AFNetworking.h>

const NSString *BASE_URL = @"https://s3.amazonaws.com/jon-hancock-phunware/";

@implementation VenuesAPI

+(instancetype)sharedInstance{
    static VenuesAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) requestVenuesWithCompletionHandler:(VenueAPICompletionHandler)completionHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
     [manager GET:[NSString stringWithFormat:@"%@nflapi-static.json",BASE_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [Model sharedInstance].venuesArray = [[NSMutableArray alloc]init];
         NSArray *responseArray = responseObject;
         for (int i = 0; i < responseArray.count; i++) {
             VenueVO *venueVO = [[VenueVO alloc]init];
             [venueVO setName:[responseArray[i] objectForKey:@"name"]];
             [venueVO setZip:[responseArray[i] objectForKey:@"zip"]];
             [venueVO setState:[responseArray[i] objectForKey:@"state"]];
             [venueVO setAddress:[responseArray[i] objectForKey:@"address"]];
             [venueVO setCity:[responseArray[i] objectForKey:@"city"]];
             [venueVO setImageUrl:[responseArray[i] objectForKey:@"image_url"]];
             [venueVO setSchedule:[responseArray[i] objectForKey:@"schedule"]];
             
             [[Model sharedInstance].venuesArray addObject:venueVO];
         }
         completionHandler(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(NO,error);
    }];
}

@end
