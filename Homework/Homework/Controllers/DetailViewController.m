//
//  DetailViewController.m
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface DetailViewController ()

@property (nonatomic,weak) IBOutlet UIImageView *imageView;
@property (nonatomic,weak) IBOutlet UILabel *name;
@property (nonatomic,weak) IBOutlet UILabel *address;
@property (nonatomic,weak) IBOutlet UITextView *schedule;
@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,weak) IBOutlet UILabel *noImageLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setVenueVO:(VenueVO *)newVenueVO {
    if (_venueVO != newVenueVO) {
        _venueVO = newVenueVO;
        [self configureView];
    }
}

/*!
 *  @brief Configures the view with the specificied values in the instance variable VenueVO
 */
- (void)configureView {
    if (self.venueVO) {
        [self.activityIndicator startAnimating];
        [self.name setText:self.venueVO.name];
        
        NSString *address = [NSString stringWithFormat:@"%@\n%@, %@ %@",self.venueVO.address, self.venueVO.city, self.venueVO.state, self.venueVO.zip];
        [self.address setText:address];
        
        NSString *scheduleString = @"";
        for (NSDictionary *day in self.venueVO.schedule) {
            scheduleString = [NSString stringWithFormat:@"%@\n%@",scheduleString,[self scheduleFromStartDate:[day objectForKey:@"start_date"] endDate:[day objectForKey:@"end_date"]]];
        }
        
        [self.schedule setText:scheduleString];
        
        if (self.venueVO.imageUrl != nil && ![self.venueVO.imageUrl isEqualToString:@""]) {
            NSURLRequest *imageUrlRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.venueVO.imageUrl]];
            [self.imageView setImageWithURLRequest:imageUrlRequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [self.activityIndicator stopAnimating];
                self.imageView.image = image;
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"Error: %@",error.description);
                self.imageView.image = nil;
                [self.noImageLabel setHidden:NO];
                [self.activityIndicator stopAnimating];
            }];
        }else{
            self.imageView.image = nil;
            [self.activityIndicator stopAnimating];
            [self.noImageLabel setHidden:NO];
        }
    }
}

-(NSString*)scheduleFromStartDate:(NSString*)startDate endDate:(NSString*)endDate{
    NSString *schedule = [self convertDateToLocal:startDate withFormat:@"EEEE MM/dd HH:mm"];
    schedule = [NSString stringWithFormat:@"%@ to %@",schedule, [self convertDateToLocal:endDate withFormat:@"HH:mm"]];
    return schedule;
}

/*!
 *  @brief convertDateToLocal receive a date in string and convert it to local Time Zone and returns it in the specificied format
 *  @param dateString the date to convert
 *  @param dateFormat the format in which we want the returned date
 *  @return an NSString with the date in the current local and specificied date format
 */
-(NSString*)convertDateToLocal:(NSString*)dateString withFormat:(NSString*)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/mm/dd HH:mm:ss z"];
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDateFormatter *userFormatter = [[NSDateFormatter alloc] init];
    [userFormatter setDateFormat:dateFormat];
    [userFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateConverted = [userFormatter stringFromDate:date];

    return dateConverted;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.noImageLabel setHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
