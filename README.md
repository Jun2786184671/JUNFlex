# JUNFlex (Beta)

[![Version](https://img.shields.io/cocoapods/v/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)
[![License](https://img.shields.io/cocoapods/l/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)
[![Platform](https://img.shields.io/cocoapods/p/JUNFlex.svg?style=flat)](https://cocoapods.org/pods/JUNFlex)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

JUNFlex is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JUNFlex'
```

## Guide
1. ```#import <JUNFlex/$Flex.h>``` into your project.
2. JUNFlex provides six widgets to help you build interfaces quickly.
	+ ```$Hstack``` is a horizontal layout, all of the UIViews wrapped by it are laid out in x-axis direction.
		```objc
		$Hstack
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```

	+ ```$Vstack``` is a vertical layout, similar to Hstack, all of its components are laid out in y-axis direction.
		```objc
		$Vstack
		.width(100) // Yes, you can set some properties here.
		.height(200)
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```
	+ ```$Zstack``` is a stack layout where all of its components are stacked in the z-axis direction.
		```objc
		$Zstack
		.size(80, 80)
		.align(-1, -1) // This makes all contents in stack lean to the left top corner.
      	.children(@[
			aLabel,
      		aButton,
      		aSwitch,
      		...
      	]);
		```
	+ ```$Padding``` is used to wrap a UIView, you can use it to specify the insets, as well as implicitly constraining its content by setting the wrapper's size.
		```objc
		$Padding
		.left(20).right(20) // This makes edge insets.
		.size(80, 80) // Constrain its content implicitly.
		.radius(30)
		.maskBounds(true)
        .color(UIColor.orangeColor) // Color and radius, you can even use it to wrap and decorate a view!
      	.child(
			aView
      	);
		```
	+ ```$Item``` is a nice tool in JUNFlex that allows you to quickly create many types of views, from UIImageView to UILabel and even UIButton.
		```objc
		$Vstack
      	.children(@[

			$Item // This makes a UIImageView
           	.size(80, 80)
           	.image(@"http:///path/to/image")
         	.radius(30),

         	$Hstack // Yes, you can nest stacks in stacks.
          	.children(@[

           		$Item // This makes item responds to ui events.
           		.text(@"Hello World!!!", 20, UIColor.blueColor)
           		.onTap(self, @selector(buttonOnTap)), 

           		UISwitch.new,

           		[self createAnyView],
           		...
          	]),
      		...
      	]);
		```
	+ ```$List``` is an encapsulation of [JUNCollectionView](https://github.com/Jun2786184671/JUNCollectionView) that you can use to create either a horizontal or vertical scrollable list or a flowlayout.
		```objc
		$List
		.horizontal(true)
		.size(535, 1000)
		.itemSize(80, 80)
        .alwaysBounce(true)
        .showIndicator(true)
        .count(100, ^id (NSUInteger i) { // There are four other builders, such as forEach loop builder...
        	return
        	$Vstack
        	.children(@[
        		$Item
        		.size(80, 80)
        		.image(@"aBundleImageName")
        		.radius(30),

        		$Hstack
        		.children(@[
        			$Item
        			.text(@"hello", 20, UIColor.blueColor)
        			.onTap(self, @selector(buttonOnTap)),

        			UISwitch.new,
        		]),

        		$Item
        		.width(120)
        		.text(@"world", 20, UIColor.blueColor)
        		.color(UIColor.greenColor),
            ]);
        });
		```
3. You can register and query the identifier of views.
	```objc
	[self.view addSubview:
		$Item
		.ID(@"anyIdentifier")
		.color(UIColor.orangeColor)
		.size(100, 100)
	];

	self.view.$query0(@"anyIdentifier"); // Query first matched view.

	```
4. ORM and UI binding.
	+ ```$Mapper``` is used for ORM. You can register your model class by it, then specify how json map to a model and bind ui to it.
	```objc
	$Mapper(User.class, ^(id $, User *_) {
        _.name = $[@"nom"];
        _.email = $[@"mail"];
        _.profileURL = $[@"avatar"];
        ...
    });
	```
	And then when you recieve a json response from server, you can quickly map it to model.
	```objc
	User *user = User.$map(@{
		@"nom" : @"Jun Ma",
		@"mail" : @"maxinchun5@gmail.com",
		@"avatar" : @"http://www.example.com/path/to/resource",
		...
	});
	```
	+ ```$Layout``` is used for UI binding, you can register a model class with a specific type of view.
	```objc
	$Layout(User.class, ^id (User *_) {
		return
		$Vstack
		.width(300)
		.height(600)
		.align(0 /* main axis (y) */, -1 /* cross axis (x)*/)
		.children(@[
			$Item
			.image(_.profileURL)

			$Item
			.text(_.name, 20, UIColor.blackColor),

			$Item
			.text(_.email, 18, UIColor.blueColor),
			.onTap(anyTarget, @selector(sendMailToJun))
		]);
	});
	```
	Then whenever you want to draw a user's info to interface, you only need to call ```.$render``` method.
	```objc
	UIView *userView = user.$render;
	```
5. JUNFlex also has the ability to separate ui from code via json.
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
	    "contentAlignment" : {
	        "horizontal" : "leading",
	        "vertical" : "bottom",
	    },
	    "text" : {
	        "string" : "hello world",
	        "color" : "#ff00ffff",
	        "fontSize" : 18,
	    },
	    "alignment" : {
	        "mainAxis" : "min",
	        "crossAxis" : "max",
	    },
	    "children" : [

	        {
	            "size" : {
	                "width" : 100,
	                "height" : 200,
	            },
	            "color" : "red",
	            "text" : "hello"
	            "image" : "test-image.jpg",
	        },

	        {
	            "width" : 100,
	            "height" : 200,
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
	    self.layout(@"demo.json");
	}
	```
6. Nice ```v(^_^)v```

## Author

Jun Ma, maxinchun5@gmail.com

## License

JUNFlex is available under the MIT license. See the LICENSE file for more info.
