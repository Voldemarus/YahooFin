//
//  ShareTags+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "ShareTags+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShareTags (CoreDataProperties)

+ (NSFetchRequest<ShareTags *> *)fetchRequest;

@property (nullable, nonatomic, retain) Share *share;
@property (nullable, nonatomic, retain) Tag *tag;

@end

NS_ASSUME_NONNULL_END
