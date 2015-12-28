//
//  BLPTextView.m
//  TestiOS
//
//  Created by 李旭波 on 15/12/28.
//  Copyright © 2015年 李旭波. All rights reserved.
//

#import "BLPTextView.h"

@implementation BLPTextView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self awakeFromNib];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addObserver];
}


#pragma mark --注册通知
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}


#pragma mark --begin edit
- (void)textDidBeginEditing:(NSNotification *)notification {
    if([super.text isEqualToString:_placeholder]) {
        super.text = @"";
        [super setTextColor:[UIColor blackColor]];
    }
}


#pragma mark --end edit
- (void)textDidEndEditing:(NSNotification *)notification {
    if(0 == super.text.length) {
        super.text = _placeholder;
        [super setTextColor:[UIColor lightGrayColor]];
    }
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self textDidEndEditing:nil];
}



- (NSString *)text {
    NSString *text = [super text];
    
    if([text isEqualToString:_placeholder]) {
        return @"";
    }
    
    return text;
}


#pragma mark --dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
