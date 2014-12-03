//
//  UIImage+Transform.h
//  CRM-Demo
//
//  Created by HZwu on 14-9-5.
//  Copyright (c) 2014年 softgoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IMTransform)

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;

@end
