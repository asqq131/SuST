//
//  HomeBusinessTableCellTableViewCell.m
//  SuS
//
//  Created by HZwu on 14-11-30.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#define kBorder 10
#define kImageSize CGSizeMake(90, 60)
#define kContentWidth (CGRectGetWidth(self.contentView.frame) - kImageSize.width - kBorder - 15)
#define kNameFont [UIFont systemFontOfSize:15]
#define kDescriptionFont [UIFont systemFontOfSize:10]

#import "Constants.h"
#import "HomeBusinessTableCellTableViewCell.h"

@interface HomeBusinessTableCellTableViewCell ()
{
    __weak UIImageView *_imageView;
    __weak UILabel *_businessName;
    __weak UILabel *_description;
    __weak UILabel *_price;
    __weak UILabel *_privilege;
    __weak UILabel *_range;
}

@end

@implementation HomeBusinessTableCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView
{
    // 图标
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    _imageView = imageView;
    
    // 商户名
    UILabel *businessName = [[UILabel alloc] init];
    businessName.numberOfLines = 0;
    businessName.font = kNameFont;
    [self.contentView addSubview:businessName];
    _businessName = businessName;
    
    // 描述
    UILabel *description = [[UILabel alloc] init];
    description.textColor = [UIColor grayColor];
    description.numberOfLines = 2;
    description.font = kDescriptionFont;
    [self.contentView addSubview:description];
    _description = description;
    
    // 价格
    UILabel *price = [[UILabel alloc] init];
    [self.contentView addSubview:price];
    _price = price;
    
    // 优惠
    UILabel *privilege = [[UILabel alloc] init];
    [self.contentView addSubview:privilege];
    _privilege = privilege;
    
    // 距离
    UILabel *range = [[UILabel alloc] init];
    [self.contentView addSubview:range];
    _range = range;
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    // TODO
    // 图标
    CGFloat imageViewX = kBorder;
    CGFloat imageViewY = kBorder;
    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataDict[@"s_photo_url"]]]];
    _imageView.frame = CGRectMake(imageViewX, imageViewY, kImageSize.width, kImageSize.height);
    
    // 商户名
    CGFloat businessNameX = CGRectGetMaxX(_imageView.frame) + kBorder;
    CGFloat businessNameY = kBorder;
    _businessName.text = dataDict[@"name"];
    CGSize businessNameSize;
    
    if (kIsIOS7Later) {
        businessNameSize = [_businessName.text sizeWithAttributes:@{NSFontAttributeName:kNameFont}];
    }
    else {
        businessNameSize = [_businessName.text sizeWithFont:kNameFont]; // IOS7不推荐使用该方法
    }
    _businessName.frame = CGRectMake(businessNameX, businessNameY, kContentWidth, businessNameSize.height);
    
    // 描述
    CGFloat descriptionX = businessNameX;
    CGFloat descriptionY = CGRectGetMaxY(_businessName.frame) + kBorder/2;
    if ([dataDict[@"deals"] count] > 0) {
        _description.text = dataDict[@"deals"][0][@"description"];
    }
    
    CGSize descriptionSize;
    CGFloat maxHeight = 35; // 文字最大高度
    if (kIsIOS7Later) {
        NSDictionary *attrib = @{NSFontAttributeName: kDescriptionFont};
        descriptionSize = [_description.text boundingRectWithSize:CGSizeMake(kContentWidth, maxHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrib context:nil].size;
    } else {
        descriptionSize = [_description.text sizeWithFont:kDescriptionFont constrainedToSize:CGSizeMake(kContentWidth, maxHeight)];// IOS7不推荐使用该方法
    }
    
    _description.frame = CGRectMake(descriptionX, descriptionY, kContentWidth, descriptionSize.height);
}

@end
