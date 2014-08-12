//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by user  on 3/14/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

@implementation WhereamiAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (void)findLocation
{
	[locationManager startUpdatingLocation];
	[activityIndicator startAnimating];
	[locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
	NSDate * dayTagged = [NSDate date];
	
	CLLocationCoordinate2D coord = [loc coordinate];
	
	//create an instance of mappont with the current data
	MapPoint *mp = [[MapPoint alloc] initWithCoordinate:coord 
												  title:[locationTitleField text]];
	//add it to the map view
	[worldView addAnnotation:mp];
	[mp release];
	
	//zoom in
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
	[worldView setRegion:region animated:YES];
	
	[locationTitleField setText:@""];
	[activityIndicator stopAnimating];
	[locationTitleField setHidden:NO];
	[locationManager stopUpdatingLocation];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	CLLocationCoordinate2D loc = [userLocation coordinate];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
	[worldView setRegion:region animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"%@", newLocation);
	
	// How many seconds ago was this new location created?
	NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
	if (t < -180)
	{
		return;
	}
	
	[self foundLocation:newLocation];
}

-(void)locationManager:(CLLocationManager *)manager
didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location: %@", error);
} 

-(BOOL)textFieldShouldReturn:(UITextField *) tf
{
	[self findLocation];
	[tf resignFirstResponder];
	
	return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDelegate:self];
	
	[locationManager setDistanceFilter:kCLDistanceFilterNone];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	
	//[locationManager startUpdatingLocation];
	[worldView setShowsUserLocation:YES];
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
