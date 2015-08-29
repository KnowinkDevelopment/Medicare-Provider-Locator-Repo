//
//  MPL_MapViewController.h
//  Medicare Provider Locator
//
//  Created by Steve Suranie on 8/3/15.
//  Copyright (c) 2015 knowInk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KIP_AnnontationView.h"

@interface MPL_MapViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) NSDictionary* dictSelectedSupplier;
@property (nonatomic, strong) CLLocation* supplierLocation;
@property (nonatomic, strong) MKMapView* myMapView;
@property (nonatomic, strong) CLLocationManager* myLocationManager;
@property (nonatomic, strong) CLLocation* currentLocation;
@property (nonatomic, strong) UIView* vMapHuD;
@property (nonatomic, strong) UILabel* lblDistance;



- (void) buildMap;
@end
