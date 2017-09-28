//
//  AddAttriCollCell.h
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAttriCollCell;
@protocol AddAttriCollCellDelegate <NSObject>

- (void)AddAttriCollCell:(AddAttriCollCell *)AttriCollCell withSection:(NSInteger )section;

@end

@interface AddAttriCollCell : UICollectionViewCell

@property (nonatomic, retain)UITextField *attriTextField;
@property (nonatomic, retain)UIButton *button;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)id<AddAttriCollCellDelegate> delegate;



@end
