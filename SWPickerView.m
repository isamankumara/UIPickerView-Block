//
//  SWPickerView.m
//  SWPickerView
//
//  Created by Saman Kumara on 5/6/15.
//  Copyright (c) 2015 Saman Kumara. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import <objc/runtime.h>
#import "SWPickerView.h"

@interface SWPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic , copy) void (^selectBlock)(NSInteger rowIndex);
@property (nonatomic , copy) void (^selectMultipleBlock)(NSDictionary *dictionary);
@property (nonatomic , copy) void (^calcelBlock)(void);
@property (nonatomic, retain) UIView *childView;
@property (nonatomic ,retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedRow, selectedComponent;
@property (nonatomic, retain) NSDictionary *arryWithComponents;
@property (nonatomic, retain) NSMutableDictionary *valueWithComponents;
@property (nonatomic, assign) NSInteger defaultRow, defaultComponent;

@end

#define KviewHeight 206
static const char KPickerHandler;

@implementation SWPickerView

-(id)init{
    
    if (self = [super init]) {
        self.selectedRow = 0;
        self.selectedComponent = 0;
        
        self.valueWithComponents = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0", @"0", @"0", @"1", nil];

        self.toolBar = [[UIToolbar alloc] init];
        self.childView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
     
        self.pickerView = [[UIPickerView alloc]init];
        
        UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(tapCancel)];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(tapSelect)];
        
        [self.toolBar setItems:[NSArray arrayWithObjects:item1, flexiableItem, item2, nil]];
    }
    return self;
}


+(void)loadWithArray:(NSArray *)array parentView:(UIView *)parentView selectedBlock:(void (^)(NSInteger rowIndex))selectBlock cancelBlock:(void (^)(void))cancelBlock{
    
    SWPickerView *picker = [[SWPickerView alloc]init];
    
    [picker loadWithArray:array parentView:parentView selectedBlock:selectBlock cancelBlock:cancelBlock];
}



-(void)loadWithArray:(NSArray *)array parentView:(UIView *)parentView selectedBlock:(void (^)(NSInteger rowIndex))selectBlock cancelBlock:(void (^)(void))cancelBlock{
    

    if (selectBlock) {
        self.selectBlock = selectBlock;
    }
    
    if (cancelBlock) {
        self.calcelBlock = cancelBlock;
    }
    
    self.dataArray = [[NSArray alloc]initWithArray:array];
    
    
    objc_setAssociatedObject(self, &KPickerHandler, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.pickerView setDataSource: self];
    [self.pickerView setDelegate: self];
    self.pickerView.showsSelectionIndicator = YES;
    
    if (parentView) {
       
        self.childView.frame = CGRectMake(0, parentView.frame.size.height-KviewHeight, parentView.frame.size.width, KviewHeight);
        self.pickerView.frame = CGRectMake(0, 44, parentView.frame.size.width, KviewHeight - 44);

        if (array) {
            [self.pickerView selectRow:self.defaultRow inComponent:self.defaultComponent animated:NO];
        }else{
            for (NSString *key in self.valueWithComponents) {
                [self.pickerView selectRow:[[self.valueWithComponents objectForKey:key]intValue] inComponent:[key intValue] animated:NO];
            }
        }
        
        self.toolBar.frame = CGRectMake(0, 0, self.pickerView.frame.size.width, 44);
        
        
        [self.childView addSubview:self.toolBar];
        [self.childView addSubview:self.pickerView];
        
        [parentView addSubview:self.childView];
    }
}


-(void)loadWithDictionary:(NSDictionary *)dictionary parentView:(UIView *)parentView selectedBlock:(void (^)(NSDictionary *dictionary))selectBlock cancelBlock:(void (^)(void))cancelBlock{
    
    self.arryWithComponents = dictionary;
    self.selectMultipleBlock = selectBlock;
    [self loadWithArray:nil parentView:parentView selectedBlock:nil cancelBlock:cancelBlock];

}



-(void)setLeftToolBarButton:(UIBarButtonItem *)button{
    
    NSMutableArray *items = [[NSMutableArray alloc]initWithArray:self.toolBar.items];
    [items replaceObjectAtIndex:0 withObject:button];
    
    self.toolBar.items = [[NSArray alloc] initWithArray:items];
    
}
-(void)setRightToolBarButton:(UIBarButtonItem *)button{
    
    NSMutableArray *items = [[NSMutableArray alloc]initWithArray:self.toolBar.items];
    [items replaceObjectAtIndex:items.count-1 withObject:button];
    
    self.toolBar.items = [[NSArray alloc] initWithArray:items];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self.valueWithComponents setObject:[NSString stringWithFormat:@"%ld",  (long)row] forKey:[NSString stringWithFormat:@"%ld",  (long)component]];
    
    self.defaultRow = row;
    self.defaultComponent = row;
    
}

- (void)removeFromSuperView{
    [self.childView removeFromSuperview];
}

- (void)setBackgroundColor:(UIColor *)color{
    self.childView.backgroundColor = color;
}

- (void)setToolBarTintColor:(UIColor *)color{
    self.toolBar.tintColor = color;
}

- (void)setBarTintColor:(UIColor *)color{
    self.toolBar.barTintColor = color;
}

#pragma mark uipickerview delegates

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    
    if (self.arryWithComponents) {
        [self.valueWithComponents setObject:[NSString stringWithFormat:@"%ld",  (long)row] forKey:[NSString stringWithFormat:@"%ld",  (long)component]];
        
        if (self.selectMultipleBlock) {
            self.selectMultipleBlock(self.valueWithComponents);
        }
    }else{
        self.selectedRow = row;
        self.selectedComponent = component;
    }

}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.arryWithComponents) {
        return [[self.arryWithComponents objectForKey:[NSString stringWithFormat:@"%ld", (long)component]] count];
    }
    return [self.dataArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.arryWithComponents) {
        return [[self.arryWithComponents allKeys]count];
    }
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.arryWithComponents) {
        return [[self.arryWithComponents objectForKey:[NSString stringWithFormat:@"%ld", (long)component]]objectAtIndex: row];
    }
    return [self.dataArray objectAtIndex: row];
    
}

#pragma mark bar button actions

-(void)tapCancel{

    
    self.calcelBlock ();
    
    [self.childView removeFromSuperview];
}

-(void)tapSelect{
    if (self.selectBlock) {
        self.selectBlock( self.selectedRow);
    }
    
    [self.childView removeFromSuperview];
}

@end


@implementation UIPickerView (Block)

-(void)loadWithArray:(NSArray *)array selectedBlock:(void (^)(NSInteger rowIndex))selectBlock{
    
    SWPickerView *pikcerView = [[SWPickerView alloc]init];
    pikcerView.pickerView = self;
    [pikcerView loadWithArray:array parentView:nil selectedBlock:selectBlock cancelBlock:nil];
}


-(void)loadWithDictionary:(NSDictionary *)dictionary selectedBlock:(void (^)(NSDictionary *dictionary))selectBlock{
    
    SWPickerView *pikcerView = [[SWPickerView alloc]init];
    pikcerView.pickerView = self;
    [pikcerView loadWithDictionary:dictionary parentView:nil selectedBlock:selectBlock cancelBlock:nil];
    
}

@end
