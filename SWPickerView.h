//
//  SWPickerView.h
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


#import <UIKit/UIKit.h>

/**
 *  This interface is designed to create pickerview with toolbar with two buttons. Anyone can change left/right buttons using given methods. No need to write pickerview delegate , the button action will come in to the block.
    Developer can Select default values, toolbar buttons, toolbar colors using given methods
 */
@interface SWPickerView : NSObject

/**
 *  This is UIPickerView inside SWPicker view. If anyone want to change background color or etc use this property
 */
@property (nonatomic, retain) UIPickerView *pickerView;


/**
 *  This class method will be create SWPickerView with default setting. If you want to custom view you need to use other method to create that.
 *
 *  @param array       The pickerview values need to pass as an array
 *  @param parentView  This is Parent view that develope wanted to add picker view
 *  @param selectBlock When user tap on select (to right button) button it will come to this block
 *  @param cancelBlock When user tap on cancel (to left button) button it will come to this block
 */
+(void)loadWithArray:(NSArray *)array parentView:(UIView *)parentView selectedBlock:(void (^)(NSInteger rowIndex))selectBlock cancelBlock:(void (^)(void)) cancelBlock;


/**
 *  This method will be create SWPickerView with default setting. 
 *
 *  @param array       The pickerview values need to pass as an array
 *  @param parentView  This is Parent view that develope wanted to add picker view
 *  @param selectBlock When user tap on select (to right button) button it will come to this block
 *  @param cancelBlock When user tap on cancel (to left button) button it will come to this block
 */
-(void)loadWithArray:(NSArray *)array parentView:(UIView *)parentView selectedBlock:(void (^)(NSInteger rowIndex))selectBlock cancelBlock:(void (^)(void)) cancelBlock;


/**
 *  This method will be create SWPickerView with default setting. On this method developer need to pass dictionary with key/value, Key should be picker comportant index and value should be an array that include picker data
 *
 *  @param dictionary  The pickerview data values with multiple component
 *  @param parentView  This is Parent view that develope wanted to add picker view
 *  @param selectBlock When user tap on select (to right button) button it will come to this block
 *  @param cancelBlock When user tap on cancel (to left button) button it will come to this block
 */
-(void)loadWithDictionary:(NSDictionary *)dictionary parentView:(UIView *)parentView selectedBlock:(void (^)(NSDictionary *dictionary))selectBlock cancelBlock:(void (^)(void))cancelBlock;

/**
 *  Using this method developer can change top toolbar left botton
 *
 *  @param button need to pass UIBarButtonItem
 */
- (void)setLeftToolBarButton:(UIBarButtonItem *)button;

/**
 *  Using this method developer can change top toolbar right button
 *
 *  @param button need to pass UIBarButtonItem
 */
- (void)setRightToolBarButton:(UIBarButtonItem *)button;

/**
 *  Using this method develoepr can set default values to picker view
 *
 *  @param row       The row that wanted to select
 *  @param component The component that wanted to select
 */
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;

/**
 *  when calling this method the pickerview will be remove from super view
 */
- (void)removeFromSuperView;

/**
 *  This method help to change Toolbar tint color
 *
 *  @param color the color that wanted to change
 */
- (void)setBarTintColor:(UIColor *)color;

/**
 *  This mehtod help to change background color
 *
 *  @param color the color that wanted for background
 */
- (void)setBackgroundColor:(UIColor *)color;

/**
 *  This mehtod help to change ToolBar tint color
 *
 *  @param color the color that wanted to apply to toolBarTint
 */
- (void)setToolBarTintColor:(UIColor *)color;

@end




@interface UIPickerView(Block)


/**
 *  This is category method to use UIPickerView with block
 *
 *  @param array       The data set for the UIPickerView
 *  @param selectBlock The block when select value on UIPikerView
 */
-(void)loadWithArray:(NSArray *)array selectedBlock:(void (^)(NSInteger rowIndex))selectBlock;


/**
 *  This is category method to use UIPickerView with block but multiple components
 *
 *  @param array       The data set for the UIPickerView
 *  @param selectBlock The block when select value on UIPikerView
 */

-(void)loadWithDictionary:(NSDictionary *)dictionary selectedBlock:(void (^)(NSDictionary *dictionary))selectBlock;

@end
