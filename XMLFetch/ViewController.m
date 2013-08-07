//
//  ViewController.m
//  XMLFetch
//
//  Created by Arnel Perez on 8/7/13.
//  Copyright (c) 2013 247. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "MyAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL* url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/101222705/business.xml"];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    [req addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    NSData* data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];

    GDataXMLDocument *xmlFileData = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *tagName = [xmlFileData.rootElement elementsForName:@"name"];
    GDataXMLElement *strName = (GDataXMLElement *) [tagName objectAtIndex:0];
    
    NSArray *tagCategory = [xmlFileData.rootElement elementsForName:@"category"];
    GDataXMLElement *strCategory = (GDataXMLElement *) [tagCategory objectAtIndex:0];
   
    NSArray *tagRating = [xmlFileData.rootElement elementsForName:@"rating"];
    GDataXMLElement *strRating = (GDataXMLElement *) [tagRating objectAtIndex:0];
    
    NSArray *tagPhone = [xmlFileData.rootElement elementsForName:@"phone"];
    GDataXMLElement *strPhone = (GDataXMLElement *) [tagPhone objectAtIndex:0];
    
    NSArray *tagAddress = [xmlFileData nodesForXPath:@"//location/address" error:nil];
    GDataXMLElement *strAddress = (GDataXMLElement *) [tagAddress objectAtIndex:0];
    
    NSArray *tagCity = [xmlFileData nodesForXPath:@"//location/city" error:nil];
    GDataXMLElement *strCity = (GDataXMLElement *) [tagCity objectAtIndex:0];
    
    NSArray *tagState = [xmlFileData nodesForXPath:@"//location/state" error:nil];
    GDataXMLElement *strState = (GDataXMLElement *) [tagState objectAtIndex:0];
    
    NSArray *tagZip = [xmlFileData nodesForXPath:@"//location/zip" error:nil];
    GDataXMLElement *strZip = (GDataXMLElement *) [tagZip objectAtIndex:0];
    
    NSArray *tagLad = [xmlFileData nodesForXPath:@"//location/latitude" error:nil];
    GDataXMLElement *strLad = (GDataXMLElement *) [tagLad objectAtIndex:0];
    
    NSArray *tagLong = [xmlFileData nodesForXPath:@"//location/longitude" error:nil];
    GDataXMLElement *strLong = (GDataXMLElement *) [tagLong objectAtIndex:0];
    
    lblName.text = strName.stringValue;
    lblCategory.text = strCategory.stringValue;
    lblRating.text = strRating.stringValue;
    lblPhone.text = strPhone.stringValue;
    lblAddress.text = strAddress.stringValue;
    lblCity.text = strCity.stringValue;
    lblState.text = strState.stringValue;
    lblZip.text = strZip.stringValue;
    lblLad.text = strLad.stringValue;
    lblLong.text = strLong.stringValue;
    
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 37.289692;
    theCoordinate.longitude = -121.932707;
    
    MyAnnotation* myAnnotation=[[MyAnnotation alloc] init];
	myAnnotation.coordinate=theCoordinate;
	myAnnotation.title=strName.stringValue;
	myAnnotation.subtitle=strCategory.stringValue;

    [mapView addAnnotation:myAnnotation];
    [annotations addObject:myAnnotation];
    
    MKMapRect flyTo = MKMapRectNull;
	for (id <MKAnnotation> annotation in annotations) {
		NSLog(@"fly to on");
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        }
        else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    mapView.visibleMapRect = flyTo;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [lblName release];
    [lblCategory release];
    [lblRating release];
    [lblPhone release];
    [lblAddress release];
    [lblState release];
    [super dealloc];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

#pragma mark MKMapViewDelegate
/*
 - (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
 {
 return [kml viewForOverlay:overlay];
 }
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	// try to dequeue an existing pin view first
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = [[[MKPinAnnotationView alloc]
									 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
	pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	//pinView.pinColor=MKPinAnnotationColorPurple;
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
	
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile.png"]];
	pinView.leftCalloutAccessoryView = profileIconView;
	[profileIconView release];
	
	return pinView;
}



@end
