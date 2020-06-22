//
//  Tag+CoreDataProperties.h
//  
//
//  Created by Водолазкий В.В. on 22.06.2020.
//
//

#import "Tag+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *explanation;
@property (nullable, nonatomic, retain) NSSet<ShareTags *> *shareTags;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addShareTagsObject:(ShareTags *)value;
- (void)removeShareTagsObject:(ShareTags *)value;
- (void)addShareTags:(NSSet<ShareTags *> *)values;
- (void)removeShareTags:(NSSet<ShareTags *> *)values;

@end

NS_ASSUME_NONNULL_END
