// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGMonthlyKeyHighlight.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGMonthlyKeyHighlightAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *mitigationPlan;
} ETGMonthlyKeyHighlightAttributes;

extern const struct ETGMonthlyKeyHighlightRelationships {
	__unsafe_unretained NSString *keyHighlight;
} ETGMonthlyKeyHighlightRelationships;

extern const struct ETGMonthlyKeyHighlightFetchedProperties {
} ETGMonthlyKeyHighlightFetchedProperties;

@class ETGKeyHighlight;





@interface ETGMonthlyKeyHighlightID : NSManagedObjectID {}
@end

@interface _ETGMonthlyKeyHighlight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGMonthlyKeyHighlightID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* desc;


//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mitigationPlan;


//- (BOOL)validateMitigationPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGKeyHighlight* keyHighlight;

//- (BOOL)validateKeyHighlight:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGMonthlyKeyHighlight (CoreDataGeneratedAccessors)

@end

@interface _ETGMonthlyKeyHighlight (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSString*)primitiveMitigationPlan;
- (void)setPrimitiveMitigationPlan:(NSString*)value;





- (ETGKeyHighlight*)primitiveKeyHighlight;
- (void)setPrimitiveKeyHighlight:(ETGKeyHighlight*)value;


@end
