//
//  TSServerClass.h
//  ProtoTypeApp
//
//  Created by TacktileSystemsMac4 on 12/01/16.
//  Copyright (c) 2016 Tacktile Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface TSServerClass : NSObject


+(id)tSharedInstance;
-(UIColor*)colorWithHexString:(NSString*)hex;


@end
