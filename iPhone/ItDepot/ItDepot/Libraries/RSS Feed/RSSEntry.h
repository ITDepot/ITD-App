//
//  RSSEntry.h
//  RSSFun
//
//  Created by Ray Wenderlich on 1/24/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject {
    NSString *_blogTitle;
    NSString *_articleTitle;
    NSString *_articleUrl;
    NSDate *_articleDate;
    NSString *_articleImage;
    NSString *_articalDesc;
    NSString *_articalListDesc;
    NSArray *_articalCategories;

}

@property (copy) NSString *blogTitle;
@property (copy) NSString *articleTitle;
@property (copy) NSString *articleUrl;
@property (copy) NSString *articleImage;
@property (copy) NSDate *articleDate;
@property (copy) NSString *articalDesc;
@property (copy) NSString *articalListDesc;
@property (copy) NSArray *articalCategories;

//- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate articleImage:(NSString *)articleImage articleDesc1:(NSString *)articleDesc withListDesc:(NSString *)ListDesc;

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate articleImage:(NSString *)articleImage articleDesc1:(NSString *)articleDesc withListDesc:(NSString *)ListDesc withCategories:(NSArray *)Categories;


@end

