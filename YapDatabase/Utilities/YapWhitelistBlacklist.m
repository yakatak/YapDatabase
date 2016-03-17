#import "YapWhitelistBlacklist.h"


@implementation YapWhitelistBlacklist
{
	NSSet *whitelist;
	NSSet *blacklist;
	
	YapWhitelistBlacklistFilterBlock filterBlock;
}

// See header file for documentation
- (instancetype)initWithWhitelist:(NSSet *)inWhitelist
{
	if ((self = [super init]))
	{
        if (inWhitelist) {
            NSMutableSet *setCopy = [NSMutableSet setWithCapacity:[inWhitelist count]];
            for (id obj in inWhitelist) {
                if ([obj isKindOfClass:[NSString class]]) {
                    [setCopy addObject:[[obj mutableCopy] copy]];
                }
                else {
                    [setCopy addObject:obj];
                }
            }
            whitelist = [setCopy copy];
        } else {
            whitelist = [NSSet set];
        }
	}
	return self;
}

// See header file for documentation
- (instancetype)initWithBlacklist:(NSSet *)inBlacklist
{
	if ((self = [super init]))
	{
        if (inBlacklist) {
            NSMutableSet *setCopy = [NSMutableSet setWithCapacity:[inBlacklist count]];
            for (id obj in inBlacklist) {
                if ([obj isKindOfClass:[NSString class]]) {
                    [setCopy addObject:[[obj mutableCopy] copy]];
                }
                else {
                    [setCopy addObject:obj];
                }
            }

            blacklist = [setCopy copy];
        } else {
            blacklist = [NSSet set];
        }
	}
	return self;
}

// See header file for documentation
- (instancetype)initWithFilterBlock:(YapWhitelistBlacklistFilterBlock)block
{
	if (block == NULL) return nil;
	
	if ((self = [super init]))
	{
		filterBlock = block;
	}
	return self;
}

// See header file for documentation
- (BOOL)isAllowed:(id)item
{
	if (whitelist)
	{
		return [whitelist containsObject:item];
	}
	else if (blacklist)
	{
		return ![blacklist containsObject:item];
	}
	else
	{
		return filterBlock(item);
	}
}

@end
