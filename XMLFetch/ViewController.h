//
//  ViewController.h
//  XMLFetch
//
//  Created by Arnel Perez on 8/7/13.
//  Copyright (c) 2013 247. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblCategory;
    IBOutlet UILabel *lblRating;
    IBOutlet UILabel *lblPhone;
    IBOutlet UILabel *lblAddress;
    IBOutlet UILabel *lblCity;
    IBOutlet UILabel *lblZip;
    IBOutlet UILabel *lblLad;
    IBOutlet UILabel *lblLong;
    IBOutlet UILabel *lblState;
    
    IBOutlet MKMapView* mapView;
}

@property(nonatomic,retain)	IBOutlet MKMapView* mapView;

@end
