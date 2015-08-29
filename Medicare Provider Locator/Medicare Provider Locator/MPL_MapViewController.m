//
//  MPL_MapViewController.m
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/3/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import "MPL_MapViewController.h"

@interface MPL_MapViewController ()

@end

@implementation MPL_MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up location manager
    self.myLocationManager = [[CLLocationManager alloc] init];
    self.myLocationManager.delegate = self;
    
    //requesting permission to use location onyl when app is on
    if ([self.myLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.myLocationManager requestWhenInUseAuthorization];
    }
    
    self.myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.myLocationManager.distanceFilter = kCLDistanceFilterNone;
    [self.myLocationManager startUpdatingLocation];
}

- (void) buildMap {
    
    self.myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 50.0)];
    [self.view addSubview:self.myMapView];
    
    UIView* vDemographics = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
    vDemographics.backgroundColor = MPL_BLUE;
    
    UILabel* lblCompanyName = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, vDemographics.frame.size.width-10.0, 20.0)];
    lblCompanyName.text = [[self.dictSelectedSupplier objectForKey:@"company_name"] capitalizedString];
    lblCompanyName.textColor = [UIColor whiteColor];
    lblCompanyName.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:13.0];
    [vDemographics addSubview:lblCompanyName];
    
    UILabel* lblCompanyAddress = [[UILabel alloc] initWithFrame:CGRectMake(10.0, lblCompanyName.frame.origin.y + lblCompanyName.frame.size.height, vDemographics.frame.size.width-10.0, 20.0)];
    lblCompanyAddress.text = [self formatAddress];
    lblCompanyAddress.textColor = [UIColor whiteColor];
    lblCompanyAddress.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:13.0];
    [vDemographics addSubview:lblCompanyAddress];
    
    [self.view addSubview:vDemographics];
    
    self.vMapHuD = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height -50.0, self.view.frame.size.width, 50.0)];
    self.vMapHuD.backgroundColor = MPL_BLUE;
    
    self.lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, self.vMapHuD.frame.size.width-10.0, 20.0)];
    self.lblDistance.textColor = [UIColor whiteColor];
    self.lblDistance.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:13.0];
    self.lblDistance.numberOfLines = 0;
    self.lblDistance.lineBreakMode = NSLineBreakByWordWrapping;
    [self.vMapHuD addSubview:self.lblDistance];
    [self.view addSubview:self.vMapHuD];
    
    UIImage* imgUserLocation = [UIImage imageNamed:@"img_UserLocation.png"];
    UIButton* btnUserLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUserLocation setFrame:CGRectMake(self.vMapHuD.frame.size.width - 100.0, 10.0, imgUserLocation.size.width, imgUserLocation.size.height)];
    [btnUserLocation setImage:imgUserLocation forState:UIControlStateNormal];
    [btnUserLocation setImage:[UIImage imageNamed:@"img_UserLocation_on.png"] forState:UIControlStateHighlighted];
    [btnUserLocation addTarget:self action:@selector(goToUserLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMapHuD addSubview:btnUserLocation];
    
    UIImage* imgCompanyLocation = [UIImage imageNamed:@"img_companyPin.png"];
    UIButton* btnCompanyPin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCompanyPin setFrame:CGRectMake(btnUserLocation.frame.origin.x + btnUserLocation.frame.size.width, 10.0, imgCompanyLocation.size.width, imgCompanyLocation.size.height)];
    [btnCompanyPin setImage:imgCompanyLocation forState:UIControlStateNormal];
    [btnCompanyPin setImage:[UIImage imageNamed:@"imgCompanyLocation_on.png"] forState:UIControlStateHighlighted];
    [btnCompanyPin addTarget:self action:@selector(goToCompanyLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMapHuD addSubview:btnCompanyPin];
    
    
    
    //get coordinates
    self.supplierLocation = [self getLocation];
}

#pragma mark - Map Methods

- (void) goToUserLocation : (UIButton*) myButton {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.longitude = self.currentLocation.coordinate.longitude;
    mapRegion.center.latitude = self.currentLocation.coordinate.latitude;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    [self.myMapView setRegion:mapRegion animated: YES];
    
    //drop pin with name of store
    MKPointAnnotation* myPin = [[MKPointAnnotation alloc]init];
    myPin.coordinate = self.currentLocation.coordinate;
    myPin.title = @"Current Location";

    // add annotation to mapview
    [self.myMapView addAnnotation:myPin];
}

- (void) goToCompanyLocation : (UIButton*) myButton {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.longitude = self.supplierLocation.coordinate.longitude;
    mapRegion.center.latitude = self.supplierLocation.coordinate.latitude;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    [self.myMapView setRegion:mapRegion animated: YES];
    
    //drop pin with name of store
    MKPointAnnotation* myPin = [[MKPointAnnotation alloc]init];
    myPin.coordinate = self.supplierLocation.coordinate;
    myPin.title = [self formatAddress];
    
    // add annotation to mapview
    [self.myMapView addAnnotation:myPin];
}

- (NSString*) formatAddress {
 
    NSString* strAddress = [self.dictSelectedSupplier objectForKey:@"address"];
    strAddress = [[strAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] capitalizedString];
    
    NSString* strCity = [self.dictSelectedSupplier objectForKey:@"city"];
    strCity = [[strCity stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] capitalizedString];
    
    NSString* strState = [self.dictSelectedSupplier objectForKey:@"state"];
    strState = [[strState stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSString* strZip = [self.dictSelectedSupplier objectForKey:@"zip"];
    strZip = [strZip stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString* strLocationAddress = [NSString stringWithFormat:@"%@ %@, %@", strAddress, strCity, strState];
    
    return strLocationAddress;
}



- (CLLocation*) getLocation {
    
    NSString* strLocationAddress = [self formatAddress];
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:strLocationAddress
                 completionHandler:^(NSArray* arrPlacemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"%@", error.description);
                     }
                     
                     CLPlacemark* supplierPlacemark = [arrPlacemarks objectAtIndex:0];
                     CLLocation* thisLocation = supplierPlacemark.location;
                     self.supplierLocation = thisLocation;
                     
                     MKCoordinateRegion mapRegion;
                     mapRegion.center.longitude = self.supplierLocation.coordinate.longitude;
                     mapRegion.center.latitude = self.supplierLocation.coordinate.latitude;
                     mapRegion.span.latitudeDelta = 0.03;
                     mapRegion.span.longitudeDelta = 0.03;
                     [self.myMapView setRegion:mapRegion animated: YES];
                     
                     //drop pin with name of store
                     MKPointAnnotation* myPin = [[MKPointAnnotation alloc]init];
                     myPin.coordinate = self.supplierLocation.coordinate;
                     myPin.title = [self formatAddress];
                     
                     // add annotation to mapview
                     [self.myMapView addAnnotation:myPin];
                     
                     //get route distance between this point and user
                     [self getTravelDistance: self.supplierLocation.coordinate];
                 }
     ];
    
    return self.supplierLocation;
    
}

- (void) getTravelDistance : (CLLocationCoordinate2D) coordsGoingTo {
    
    MKDirectionsRequest* directionsRequest = [[MKDirectionsRequest alloc] init];
    
    //convert coordinates to MKMapItems
    MKPlacemark* sourcePlaceMark = [[MKPlacemark alloc] initWithCoordinate:self.currentLocation.coordinate addressDictionary:nil];
    MKPlacemark* destinationPlaceMark = [[MKPlacemark alloc] initWithCoordinate:coordsGoingTo addressDictionary:nil];
    
    MKMapItem* source = [[MKMapItem alloc] initWithPlacemark:sourcePlaceMark];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark:destinationPlaceMark];
    
    //make directionRequest
    [directionsRequest setSource:source];
    [directionsRequest setDestination:destination];
    
    MKDirections* directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:
        ^(MKDirectionsResponse* reponse, NSError* error) {
            
            if (!error) {
                
                MKRoute* mainRoute = [[reponse routes] objectAtIndex:0];
                float distance =  mainRoute.distance/5280;
                self.lblDistance.text = [NSString stringWithFormat:@"Distance (Miles) from your location:%.02f", distance];
                
                for(MKRouteStep* thisStep in [mainRoute steps]) {
                    
                    NSLog(@"%@", thisStep.instructions);
                }
                
            } else {
                NSLog(@"%@", error.description);
            }
        }
     ];
    
    
    
}

#pragma mark - Location Services Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations lastObject];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
