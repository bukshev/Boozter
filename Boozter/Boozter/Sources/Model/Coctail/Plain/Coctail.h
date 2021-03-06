//
//  Coctail.h
//  Boozter
//
//  Created by Ivan Bukshev on 02/09/2019.
//  Copyright © 2019 Team Absurdum. All rights reserved.
//

#import "IPlainObject.h"

@class Ingredient;

NS_ASSUME_NONNULL_BEGIN

@interface Coctail : NSObject <IPlainObject>

@property (nonatomic, assign, readonly) NSInteger identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable, readonly) NSURL *imageURL;
@property (nonatomic, strong, nullable, readonly) NSData *imageData;

@property (nonatomic, assign, readonly) BOOL hasDetails;

@property (nonatomic, copy, nullable, readonly) NSString *alcoholic;
@property (nonatomic, copy, nullable, readonly) NSString *category;
@property (nonatomic, copy, nullable, readonly) NSString *glassName;
@property (nonatomic, copy, nullable, readonly) NSString *instructions;
@property (nonatomic, copy, nullable, readonly) NSArray<Ingredient *> *ingredients;

- (instancetype)initWithIdentifier:(NSInteger)identifier
                              name:(NSString *)name
                          imageURL:(nullable NSURL *)imageURL NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (void)updateImageData:(nullable NSData *)imageData;
- (void)updateAlcoholic:(nullable NSString *)alcoholic;
- (void)updateCategory:(nullable NSString *)category;
- (void)updateGlassName:(nullable NSString *)glassName;
- (void)updateInstructions:(nullable NSString *)instructions;
- (void)updateIngredients:(nullable NSArray<Ingredient *> *)ingredients;

@end

NS_ASSUME_NONNULL_END
