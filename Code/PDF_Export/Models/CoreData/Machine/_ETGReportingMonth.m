// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGReportingMonth.m instead.

#import "_ETGReportingMonth.h"

const struct ETGReportingMonthAttributes ETGReportingMonthAttributes = {
	.key = @"key",
	.name = @"name",
};

const struct ETGReportingMonthRelationships ETGReportingMonthRelationships = {
	.abrs = @"abrs",
	.ahcs = @"ahcs",
	.cpbs = @"cpbs",
	.keyHighlights = @"keyHighlights",
	.maps = @"maps",
	.plrs = @"plrs",
	.pnechcrs = @"pnechcrs",
	.portfolios = @"portfolios",
	.projectSummarys = @"projectSummarys",
	.projectSummarysForMap = @"projectSummarysForMap",
	.projects = @"projects",
	.scorecards = @"scorecards",
	.timeStamps = @"timeStamps",
};

const struct ETGReportingMonthFetchedProperties ETGReportingMonthFetchedProperties = {
};

@implementation ETGReportingMonthID
@end

@implementation _ETGReportingMonth

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGReportingMonth" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGReportingMonth";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGReportingMonth" inManagedObjectContext:moc_];
}

- (ETGReportingMonthID*)objectID {
	return (ETGReportingMonthID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"keyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"key"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic key;



- (int32_t)keyValue {
	NSNumber *result = [self key];
	return [result intValue];
}

- (void)setKeyValue:(int32_t)value_ {
	[self setKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveKeyValue {
	NSNumber *result = [self primitiveKey];
	return [result intValue];
}

- (void)setPrimitiveKeyValue:(int32_t)value_ {
	[self setPrimitiveKey:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic abrs;

	
- (NSMutableSet*)abrsSet {
	[self willAccessValueForKey:@"abrs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"abrs"];
  
	[self didAccessValueForKey:@"abrs"];
	return result;
}
	

@dynamic ahcs;

	
- (NSMutableSet*)ahcsSet {
	[self willAccessValueForKey:@"ahcs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"ahcs"];
  
	[self didAccessValueForKey:@"ahcs"];
	return result;
}
	

@dynamic cpbs;

	
- (NSMutableSet*)cpbsSet {
	[self willAccessValueForKey:@"cpbs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cpbs"];
  
	[self didAccessValueForKey:@"cpbs"];
	return result;
}
	

@dynamic keyHighlights;

	
- (NSMutableSet*)keyHighlightsSet {
	[self willAccessValueForKey:@"keyHighlights"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"keyHighlights"];
  
	[self didAccessValueForKey:@"keyHighlights"];
	return result;
}
	

@dynamic maps;

	
- (NSMutableSet*)mapsSet {
	[self willAccessValueForKey:@"maps"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"maps"];
  
	[self didAccessValueForKey:@"maps"];
	return result;
}
	

@dynamic plrs;

	
- (NSMutableSet*)plrsSet {
	[self willAccessValueForKey:@"plrs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"plrs"];
  
	[self didAccessValueForKey:@"plrs"];
	return result;
}
	

@dynamic pnechcrs;

	
- (NSMutableSet*)pnechcrsSet {
	[self willAccessValueForKey:@"pnechcrs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"pnechcrs"];
  
	[self didAccessValueForKey:@"pnechcrs"];
	return result;
}
	

@dynamic portfolios;

	
- (NSMutableSet*)portfoliosSet {
	[self willAccessValueForKey:@"portfolios"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"portfolios"];
  
	[self didAccessValueForKey:@"portfolios"];
	return result;
}
	

@dynamic projectSummarys;

	
- (NSMutableSet*)projectSummarysSet {
	[self willAccessValueForKey:@"projectSummarys"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectSummarys"];
  
	[self didAccessValueForKey:@"projectSummarys"];
	return result;
}
	

@dynamic projectSummarysForMap;

	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	

@dynamic scorecards;

	
- (NSMutableSet*)scorecardsSet {
	[self willAccessValueForKey:@"scorecards"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"scorecards"];
  
	[self didAccessValueForKey:@"scorecards"];
	return result;
}
	

@dynamic timeStamps;

	
- (NSMutableSet*)timeStampsSet {
	[self willAccessValueForKey:@"timeStamps"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"timeStamps"];
  
	[self didAccessValueForKey:@"timeStamps"];
	return result;
}
	






@end
