// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ETGPpaKeyHighlight.h instead.

#import <CoreData/CoreData.h>


extern const struct ETGPpaKeyHighlightAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *mitigationPlan;
} ETGPpaKeyHighlightAttributes;

extern const struct ETGPpaKeyHighlightRelationships {
	__unsafe_unretained NSString *keyHighlight;
} ETGPpaKeyHighlightRelationships;

extern const struct ETGPpaKeyHighlightFetchedProperties {
} ETGPpaKeyHighlightFetchedProperties;

@class ETGKeyHighlight;





@interface ETGPpaKeyHighlightID : NSManagedObjectID {}
@end

@interface _ETGPpaKeyHighlight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ETGPpaKeyHighlightID*)objectID;




@property (nonatomic, strong) NSString* activity;


//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* desc;


//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* mitigationPlan;


//- (BOOL)validateMitigationPlan:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) ETGKeyHighlight* keyHighlight;

//- (BOOL)validateKeyHighlight:(id*)value_ error:(NSError**)error_;





@end

@interface _ETGPpaKeyHighlight (CoreDataGeneratedAccessors)

@end

@interface _ETGPpaKeyHighlight (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;




- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSString*)primitiveMitigationPlan;
- (void)setPrimitiveMitigationPlan:(NSString*)value;





- (ETGKeyHighlight*)primitiveKeyHighlight;
- (void)setPrimitiveKeyHighlight:(ETGKeyHighlight*)value;


@end
