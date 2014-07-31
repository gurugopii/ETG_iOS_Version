// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGKeyMilestoneProjectPhase.m instead.

#import "_ETGKeyMilestoneProjectPhase.h"

const struct ETGKeyMilestoneProjectPhaseAttributes ETGKeyMilestoneProjectPhaseAttributes = {
	.projectPhase = @"projectPhase",
	.projectPhaseKey = @"projectPhaseKey",
};

const struct ETGKeyMilestoneProjectPhaseRelationships ETGKeyMilestoneProjectPhaseRelationships = {
	.projectSummary = @"projectSummary",
	.projectSummaryForMap = @"projectSummaryForMap",
	.scorecard = @"scorecard",
};

const struct ETGKeyMilestoneProjectPhaseFetchedProperties ETGKeyMilestoneProjectPhaseFetchedProperties = {
};

@implementation ETGKeyMilestoneProjectPhaseID
@end

@implementation _ETGKeyMilestoneProjectPhase

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ETGKeyMilestoneProjectPhase" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ETGKeyMilestoneProjectPhase";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ETGKeyMilestoneProjectPhase" inManagedObjectContext:moc_];
}

- (ETGKeyMilestoneProjectPhaseID*)objectID {
	return (ETGKeyMilestoneProjectPhaseID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"projectPhaseKeyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"projectPhaseKey"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic projectPhase;






@dynamic projectPhaseKey;



- (int32_t)projectPhaseKeyValue {
	NSNumber *result = [self projectPhaseKey];
	return [result intValue];
}

- (void)setProjectPhaseKeyValue:(int32_t)value_ {
	[self setProjectPhaseKey:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveProjectPhaseKeyValue {
	NSNumber *result = [self primitiveProjectPhaseKey];
	return [result intValue];
}

- (void)setPrimitiveProjectPhaseKeyValue:(int32_t)value_ {
	[self setPrimitiveProjectPhaseKey:[NSNumber numberWithInt:value_]];
}





@dynamic projectSummary;

	
- (NSMutableSet*)projectSummarySet {
	[self willAccessValueForKey:@"projectSummary"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectSummary"];
  
	[self didAccessValueForKey:@"projectSummary"];
	return result;
}
	

@dynamic projectSummaryForMap;

	
- (NSMutableSet*)projectSummaryForMapSet {
	[self willAccessValueForKey:@"projectSummaryForMap"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projectSummaryForMap"];
  
	[self didAccessValueForKey:@"projectSummaryForMap"];
	return result;
}
	

@dynamic scorecard;

	
- (NSMutableSet*)scorecardSet {
	[self willAccessValueForKey:@"scorecard"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"scorecard"];
  
	[self didAccessValueForKey:@"scorecard"];
	return result;
}
	






@end
