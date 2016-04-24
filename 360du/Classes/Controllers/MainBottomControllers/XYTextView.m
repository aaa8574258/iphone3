//
//  XYTextView.m
//  XYTextField
//
//  Created by xy on 16/2/2.
//  Copyright © 2016年 xy. All rights reserved.
//


#import "XYTextView.h"
#define kTextBorderColor     RGBCOLOR(227,224,216)
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define getLimitNum (self.limitNum > 0 ? self.limitNum : 300)

@implementation XYTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setPlaceholder:@"请输入少于300字的内容"];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        self.layer.cornerRadius = 4.0f;
        self.layer.borderColor = kTextBorderColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
 
    return self;
}

-(UILabel *)placeHolderLabel{
    if(_placeHolderLabel==nil){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, 20,20)];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.font = self.font;
        label.textColor = self.placeholderColor;
        label.hidden = NO;
        [label sizeToFit];
        _placeHolderLabel = label;
        [self addSubview:_placeHolderLabel];
    }
    [self sendSubviewToBack:_placeHolderLabel];
    _placeHolderLabel.text = self.placeholder;
    return _placeHolderLabel;
}


-(UILabel *) countNumLabel{
    if(_countNumLabel==nil){
        _countNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-100, CGRectGetMaxY(self.frame)+6, 80, 21)];
        _countNumLabel.textAlignment = NSTextAlignmentRight;
        _countNumLabel.text = [NSString stringWithFormat:@"%ld",getLimitNum] ;
        _countNumLabel.backgroundColor = [UIColor whiteColor];
        [self.superview addSubview:_countNumLabel];
    }
    return _countNumLabel;
}

- (void)textChanged:(NSNotification *)notification{
    
    NSInteger wordCount = self.text.length;
    if(![self wordLimit:wordCount]) return;
    self.countNumLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)wordCount,getLimitNum];
    
    if ([[self text] length] == 0) {
        self.placeHolderLabel.hidden = NO;
    }
    else{
       self.placeHolderLabel.hidden = YES;
    }
    
}


-(BOOL)wordLimit:(NSInteger) length{
    if (length <= getLimitNum) {
        self.editable = YES;
        return YES;
    }
    else{
        self.editable = NO;
        return NO;
        
    }
    return YES;
}


-(void)layoutSubviews{
    [self countNumLabel];
    self.placeHolderLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 40);
//    self.placeHolderLabel.numberOfLines = 0;
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
