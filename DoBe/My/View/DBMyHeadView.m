//
//  DBMyHeadView.m
//  DoBe
//
//  Created by liuxuan on 15/6/9.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import "DBMyHeadView.h"

@interface DBMyHeadView(){
    
}
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *tagBgView; //标签
@property (weak, nonatomic) IBOutlet UILabel *focusLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UILabel *doCoinLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;

@end

@implementation DBMyHeadView

- (void)awakeFromNib {
    [_tagBgView.layer setBorderWidth:0.5f];
    [_tagBgView.layer setBorderColor:RGB(210, 210, 210).CGColor];
    _signLab.textColor = kLightTextGray;
    [self setUserInfo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _line.frame = CGRectMake(0.0f, 130.0f, self.width, 0.5);
}

-(void)createSeperateLine
{
    UIImageView *seperateLine = [[UIImageView alloc] init];
    seperateLine.frame = CGRectMake(0.f, 130.f, self.width, 0.5f);
    seperateLine.image = [UIImage imageNamed:@"seperateline"];
    [self addSubview:seperateLine];
    
    UIImageView *secondLine = [[UIImageView alloc] init];
    secondLine.frame = CGRectMake(0.0f, 175.0f, self.width, 0.5f);
    secondLine.image = [UIImage imageNamed:@"seperateline"];
    [self addSubview:secondLine];
}


- (IBAction)pushToAccountVCClick:(id)sender {
    if (_editUserInfoBlock) {
        _editUserInfoBlock();
    }
}

- (void)setUserInfo {
    [_nameLab setText:[DBUser sharedInstance].name];
    [_signLab setText:[DBUser sharedInstance].signature];
    [_focusLab setText: [NSString stringWithFormat:@"关注:%@",[DBUser sharedInstance].focusCount]];
    [_fansLab setText:[NSString stringWithFormat:@"粉丝:%@",[DBUser sharedInstance].fans]];
    [_doCoinLab setText:[NSString stringWithFormat:@"豆币:%@",[DBUser sharedInstance].doCion]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
