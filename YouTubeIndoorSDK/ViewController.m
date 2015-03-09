//
//  ViewController.m
//  YouTubeIndoorSDK
//
//  Created by Michael Kane on 3/4/15.
//  Copyright (c) 2015 ArilogicApps. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import <ESTIndoorLocationManager.h>
#import <ESTLocationBuilder.h>
#import <ESTConfig.h>

#warning ADD YOUR JSON FILE TO THE BUNDLE
@interface ViewController ()<ESTIndoorLocationManagerDelegate>

@property (nonatomic, strong) ESTIndoorLocationManager *manager;
@property (nonatomic, strong) ESTLocation *location;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ESTConfig setupAppID:kAppID andAppToken:kAppToken];
    [ESTConfig isAuthorized];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    ESTLocation *location = [ESTLocationBuilder parseFromJSON:content];

    self.manager = [[ESTIndoorLocationManager alloc] init];
    self.manager.delegate = self;
    
    self.location = location;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.locationView.backgroundColor = [UIColor clearColor];
    
    self.locationView.showTrace               = YES;
    self.locationView.rotateOnPositionUpdate  = NO;
    
    self.locationView.showWallLengthLabels    = YES;
    
    self.locationView.locationBorderColor     = [UIColor blackColor];
    self.locationView.locationBorderThickness = 6;
    self.locationView.doorColor               = [UIColor brownColor];
    self.locationView.doorThickness           = 5;
    self.locationView.traceColor              = [UIColor yellowColor];
    self.locationView.traceThickness          = 2;
    self.locationView.wallLengthLabelsColor   = [UIColor blackColor];
    
    [self.locationView drawLocation:self.location];
    
    self.locationView.positionImage = [UIImage imageNamed:@"philly.png"];
    
    [self.manager startIndoorLocation:self.location];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.manager stopIndoorLocation];
    [super viewWillDisappear:animated];
}

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager
            didUpdatePosition:(ESTOrientedPoint *)position
                   inLocation:(ESTLocation *)location
{
    self.positionLabel.text = [NSString stringWithFormat:@"x: %.2f  y: %.2f   α: %.2f ",
                               position.x,
                               position.y,
                               position.orientation];
    
    [self.locationView updatePosition:position];
}

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager didFailToUpdatePositionWithError:(NSError *)error
{
    self.positionLabel.text = @"It seems you are outside the location.";
    NSLog(@"%@", error.localizedDescription);
}


@end
