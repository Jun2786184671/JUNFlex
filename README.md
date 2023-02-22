# JUNFlex

[![Version](https://img.shields.io/cocoapods/v/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)
[![License](https://img.shields.io/cocoapods/l/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)
[![Platform](https://img.shields.io/cocoapods/p/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)

## Intro
中文版简介: https://www.jianshu.com/p/f59a74a1dc95

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

JUNFlex is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JUNFlex'
```

## Guide
1. ```#import <JUNFlex/JUNFlex.h>``` into your project.
2. JUNFlex provides six widgets to help you build interfaces quickly.
	+ ```Hstack``` is an horizontal layout, all of the UIViews wrapped by it are laid out in x-axis direction.
		```objc
		JUNFlex.hstack
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```

	+ ```Vstack``` is a vertical layout, similar to Hstack, all of its components are laid out in y-axis direction.
		```objc
		JUNFlex.vstack
		.width(100) // Yes, you can set some properties here.
		.height(200)
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```
	+ ```Zstack``` is a stack layout where all of its components are stacked in the z-axis direction.
		```objc
		JUNFlex.zstack
		.size(80, 80)
		.align(-1, -1) // This makes all contents in stack lean to the left top corner.
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```
	+ ```Padding``` is used to wrap a UIView, you can use it to specify the insets, as well as implicitly constraining its content by setting the wrapper's size.
		```objc
		JUNFlex.padding
		.left(20).right(20) // This makes edge insets.
		.size(80, 80) // Constrain its content implicitly.
		.radius(30)
		.maskBounds(true)
        .color(UIColor.orangeColor) // Color and radius, you can even use it to wrap and decorate a view!
      	.child(
			aView
      	);
		```
	+ ```Item``` is a nice tool in JUNFlex that allows you to quickly create many types of views, from UIImageView to UILabel and even UIButton.
		```objc
		JUNFlex.vstack
      	.children(@[

			JUNFlex.item // This makes a UIImageView
           	.size(80, 80)
           	.image(@"http:///path/to/image")
         	.radius(30),

         	JUNFlex.hstack // Yes, you can nest stacks in stacks.
          	.children(@[

           		JUNFlex.item // This makes item responds to ui events.
           		.text(@"Hello World!!!", 
                   		[UIFont systemFontOfSize:20], 
                   		UIColor.blueColor)
           		.onTap(self, @selector(buttonOnTap)), 

           		UISwitch.new,

           		[self createAnyView],
           		...
          	]),
      		...
      	]);
		```
	+ ```List``` is an encapsulation of [JUNCollectionView](https://github.com/Jun2786184671/JUNCollectionView) that you can use to create either a horizontal or vertical scrollable list or a flowlayout.
		```objc
		JUNFlex.list
		.horizontal(true)
		.size(535, 1000)
		.itemSize(80, 80)
        .alwaysBounce(true)
        .showIndicator(true)
        .count(100, ^id (NSUInteger i) { // There are four other builders, such as forEach loop builder...
        	return
        	JUNFlex.vstack
        	.children(@[
        		JUNFlex.item
        		.size(80, 80)
        		.image(@"aBundleImageName")
        		.radius(30),

        		JUNFlex.hstack
        		.children(@[
        			JUNFlex.item
        			.text(@"hello", 
                        		[UIFont systemFontOfSize:20], 
                        		UIColor.blueColor)
        			.onTap(self, @selector(buttonOnTap)),

        			UISwitch.new,
        		]),

        		JUNFlex.item
        		.width(120)
        		.text(@"world", 
                    		[UIFont systemFontOfSize:20],
                     		UIColor.blueColor)
        		.color(UIColor.greenColor),
            ]);
        });
		```
3. You can register and query the identifier of views.
	```objc
	[self.view addSubview:
		JUNFlex.item
		.ID(@"anyIdentifier")
		.color(UIColor.orangeColor)
		.size(100, 100)
		.EOB // Must call 'End Of Build' when you use JUNItem without a stack or padding wrapper.
	];

	self.view.jun_query0(@"anyIdentifier"); // Query first matched view.

	```
4. JUNFlex also has the ability to separate ui from code via json.
	+ First, create a file named ```demo.json```, Here's an example.
	```json
	{
	    "type" : "hstack",
	    "id" : "hello",
	    "border" : {
	        "width" : 10,
	        "color" : "orange",
	    },
	    "radius" : "12.5",
	    "align" : {
	        "main" : "min",
	        "cross" : "max",
	    },
	    "children" : [

	        {
	            "size" : {
	                "width" : 100,
	                "height" : 200,
	            },
	            "align" : {
	                "main" : "min",
	                "cross" : "center",
	            },
	            "color" : "red",
	            "text" : {
                    "string" : "hello",
                    "font" : {
                        "name" : "PingFang SC",
                        "size" : 18,
                    },
                    "color" : "pink",
                },
	            "image" : "test-image.jpg",
	        },

	        {
	            "width" : 100,
	            "height" : 200,
                "text" : "world", 
	            "color" : "green",
	        },

	        {
	            "size" : {
	                "width" : 100,
	            },
	            "height" : 200,
	            "color" : "blue",
	        },
	    ],
	}
	```
	+ Then just need to specify the json file in your controller.
	```objc
	- (void)viewDidLoad {
	    [super viewDidLoad];
	    self.jun_layout(@"demo.json");
	}
	```
6. Nice ```v(^_^)v```

## Author

Jun Ma, maxinchun5@gmail.com

## License

JUNFlex is available under the MIT license. See the LICENSE file for more info.
