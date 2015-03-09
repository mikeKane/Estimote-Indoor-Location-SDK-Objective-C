//
//  ViewController.h
//  YouTubeIndoorSDK
//
//  Created by Michael Kane on 3/4/15.
//  Copyright (c) 2015 ArilogicApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTLocation.h>
#import <ESTIndoorLocationView.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet ESTIndoorLocationView *locationView;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;

@end

