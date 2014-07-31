// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGIssuesKeyHighlight.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGIssuesKeyHighlightAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *mitigationPlan;
} ETGIssuesKeyHighlightAttributes;

extern const struct ETGIssuesKeyHighlightRelationships {
	__unsafe_unretained NSString *keyHighlights;
} ETGIssuesKeyHighlightRelationships;

extern const struct ETGIssuesKeyHighlightFetchedProperties {
} ETGIssuesKeyHighlightFetchedProperties;

@class ETGKeyHighlight;





@interface ETGIssuesKeyHighlightID : NSManagedObjectID {}
@end

@interface _ETGIssuesKeyHighlight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGIssuesKeyHighlightID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* desc;


//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mitigationPlan;


//- (BOOL)validateMitigationPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGKeyHighlight* keyHighlights;

//- (BOOL)validateKeyHighlights:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGIssuesKeyHighlight (CoreDataGeneratedAccessors)

@end

@interface _ETGIssuesKeyHighlight (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSString*)primitiveMitigationPlan;
- (void)setPrimitiveMitigationPlan:(NSString*)value;





- (ETGKeyHighlight*)primitiveKeyHighlights;
- (void)setPrimitiveKeyHighlights:(ETGKeyHighlight*)value;


@end
