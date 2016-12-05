//
//  RSSEntry.m
//  RSSFun
//
//  Created by Ray Wenderlich on 1/24/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry
@synthesize blogTitle = _blogTitle;
@synthesize articleTitle = _articleTitle;
@synthesize articleUrl = _articleUrl;
@synthesize articleDate = _articleDate;
@synthesize articleImage = _articleImage;
@synthesize articalDesc = _articalDesc;
@synthesize articalListDesc = _articalListDesc;
@synthesize articalCategories = _articalCategories;


- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate articleImage:(NSString *)articleImage articleDesc1:(NSString *)articleDesc withListDesc:(NSString *)ListDesc
{
    if ((self = [super init])) {
        _blogTitle = [blogTitle copy];
        _articleTitle = [articleTitle copy];
        _articleUrl = [articleUrl copy];
        _articleDate = [articleDate copy];
        _articleImage = [articleImage copy];
        _articalDesc = [articleDesc copy];
        _articalListDesc = [ListDesc copy];
    }
    return self;
}

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate articleImage:(NSString *)articleImage articleDesc1:(NSString *)articleDesc withListDesc:(NSString *)ListDesc withCategories:(NSArray *)Categories
{
    if ((self = [super init])) {
        _blogTitle = [blogTitle copy];
        _articleTitle = [articleTitle copy];
        _articleUrl = [articleUrl copy];
        _articleDate = [articleDate copy];
        _articleImage = [articleImage copy];
        _articalDesc = [articleDesc copy];
        _articalListDesc = [ListDesc copy];
        _articalCategories = [Categories copy];
    }
    return self;
}

- (void)dealloc {
    [_blogTitle release];
    _blogTitle = nil;
    [_articleTitle release];
    _articleTitle = nil;
    [_articleUrl release];
    _articleUrl = nil;
    [_articleDate release];
    _articleDate = nil;
    [_articleImage release];
    _articleImage = nil;
    [_articalListDesc release];
    _articalListDesc = nil;
    [_articalCategories release];
    _articalCategories = nil;
    [super dealloc];
}

@end