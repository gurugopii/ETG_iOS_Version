// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGProductionRtbd_Portfolio.m instead.

#import "_ETGProductionRtbd_Portfolio.h"

const struct ETGProductionRtbd_PortfolioAttributes ETGProductionRtbd_PortfolioAttributes = {
	.condyIndicator = @"condyIndicator",
	.condyOutlook = @"condyOutlook",
	.condyPlan = @"condyPlan",
	.gasIndicator = @"gasIndicator",
	.gasOutlook = @"gasOutlook",
	.gasPlan = @"gasPlan",
	.oilIndicator = @"oilIndicator",
	.oilOutlook = @"oilOutlook",
	.oilPlan = @"oilPlan",
	.rtbdIndicator = @"rtbdIndicator",
	.rtbdOutlook = @"rtbdOutlook",
	.rtbdPlan = @"rtbdPlan",
};

const struct ETGProductionRtbd_PortfolioRelationships ETGProductionRtbd_PortfolioRelationships = {
	.portfolio = @"portfolio",
};

const struct ETGProductionRtbd_PortfolioFetchedProperties ETGProductionRtbd_PortfolioFetchedProperties = {
};

@implementation ETGProductionRtbd_PortfolioID
@end

@implementation _ETGProductionRtbd_Portfolio

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGProductionRtbd_Portfolio" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGProductionRtbd_Portfolio";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGProductionRtbd_Portfolio" inManagedObjectContext:moc_];
}

- (ETGProductionRtbd_PortfolioID*)objectID {
	return (ETGProductionRtbd_PortfolioID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic condyIndicator;






@dynamic condyOutlook;






@dynamic condyPlan;






@dynamic gasIndicator;






@dynamic gasOutlook;






@dynamic gasPlan;






@dynamic oilIndicator;






@dynamic oilOutlook;






@dynamic oilPlan;






@dynamic rtbdIndicator;






@dynamic rtbdOutlook;






@dynamic rtbdPlan;






@dynamic portfolio;

	






@end
