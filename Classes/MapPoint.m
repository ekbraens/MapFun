//
//  MapPoint.m
//  Whereami
//
//  Created by user  on 3/15/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize title, coordinate;



- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
	self = [super init];
	if (self)
	{
		coordinate = c;
		[self setTitle:t];
	}
	return self;
}

- (void)dealloc
{
	[title release];
	[super dealloc];
}


@end
