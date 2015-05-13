# SWPickerView

This Class will add UIPickerView with toop bar (two buttons will be displyed on the left "cancel" and right "select") . If anyone want to add customize it the given methods will help to do that.

NOT ONLY THAT

After importing this class the UIPickerView (apple) can use with block. So no need to write any delegate methods to load UIPickerView

##Sample

If you want to use class method

```objective-c
[SWPickerView loadWithArray:@[@"option 1", @"option 2"] parentView:self.view selectedBlock:^(NSInteger rowIndex) {
        
    } cancelBlock:^{
        
    }];
```

with multiple components

```objective-c
SWPickerView *pickerView = [[SWPickerView alloc]init]l
[pickerView loadWithDictionary:@{@"0" :@[@"sc1 row 1", @"sec1 ro2"], @"1" :@[@"sc2 row 1", @"sec2 ro2"]}  selectedBlock:^(NSDictionary *dictionary) {
        NSLog(@"%@", dictionary);
    }];
```
Customize SWPickerView
```objective-c
    SWPickerView *pickeriew = [[SWPickerView alloc]init];

    [pickeriew setToolBarTintColor:[UIColor redColor]];
    [pickeriew setBarTintColor:[UIColor greenColor]];
    [pickeriew setBackgroundColor:[UIColor redColor]];
    [pickeriew selectRow:1 inComponent:1];
    [pickeriew loadWithDictionary:@{@"0" :@[@"sc1 row 1", @"sec1 ro2"], @"1" :@[@"sc2 row 1", @"sec2 ro2"]} parentView:self.view selectedBlock:^(NSDictionary *dictionary) {
        NSLog(@"%@", dictionary);
    } cancelBlock:^{
        
    }];
```


## UIPickerView block sample
```objective-c
UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:];
[pickerView loadWithArray:@[@"option 1", @"option 2"] selectedBlock:^(NSInteger rowIndex) {
        
    }];
```

```objective-c
UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:];
[pickerView loadWithDictionary:@{@"0" :@[@"sc1 row 1", @"sec1 ro2"], @"1" :@[@"sc2 row 1", @"sec2 ro2"]} selectedBlock:^(NSDictionary *dictionary) {
        
    }];
```
## Methods
To custmize buttons 
```objective-c
- (void)setLeftToolBarButton:(UIBarButtonItem *)button;
- (void)setRightToolBarButton:(UIBarButtonItem *)button;
```
 If anyone want to set default values for pickerview 
 
 ```objective-c
 - (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
 ```
 To change tint color on the toolbar
 ```objective-c
- (void)setBarTintColor:(UIColor *)color;
 ```
 To change background color
 ```objective-c
- (void)setBackgroundColor:(UIColor *)color;
 ```
 To set ToolBar tint color
 ```objective-c
- (void)setToolBarTintColor:(UIColor *)color;
 ```
 
 To remove view
  ```objective-c
- (void)removeFromSuperView;
 ```

