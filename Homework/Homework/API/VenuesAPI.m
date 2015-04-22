//
//  VenuesAPI.m
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "VenuesAPI.h"
#import "Model.h"
#import "VenueModel.h"

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
         [Model sharedInstance].venuesArray = [VenueModel arrayOfModelsFromDictionaries:responseObject error:nil];
         completionHandler(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(NO,error);
    }];
}

@end
