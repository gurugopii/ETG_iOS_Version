// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPlannedKeyHighlight.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPlannedKeyHighlightAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *mitigationPlan;
} ETGPlannedKeyHighlightAttributes;

extern const struct ETGPlannedKeyHighlightRelationships {
	__unsafe_unretained NSString *keyHighlight;
} ETGPlannedKeyHighlightRelationships;

extern const struct ETGPlannedKeyHighlightFetchedProperties {
} ETGPlannedKeyHighlightFetchedProperties;

@class ETGKeyHighlight;





@interface ETGPlannedKeyHighlightID : NSManagedObjectID {}
@end

@interface _ETGPlannedKeyHighlight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPlannedKeyHighlightID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* desc;


//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mitigationPlan;


//- (BOOL)validateMitigationPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGKeyHighlight* keyHighlight;

//- (BOOL)validateKeyHighlight:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPlannedKeyHighlight (CoreDataGeneratedAccessors)

@end

@interface _ETGPlannedKeyHighlight (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSString*)primitiveMitigationPlan;
- (void)setPrimitiveMitigationPlan:(NSString*)value;





- (ETGKeyHighlight*)primitiveKeyHighlight;
- (void)setPrimitiveKeyHighlight:(ETGKeyHighlight*)value;


@end
