![HeaderImage.jpg](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/95ffa0ed-b947-4d22-bd24-b47a66b8f6e5/HeaderImage.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220201%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220201T222820Z&X-Amz-Expires=86400&X-Amz-Signature=fffd73a893422cfda3e177e5f6a6ab8fd9806d545491ecaeb8cc6326834af002&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22HeaderImage.jpg%22&x-id=GetObject)

LemonadeUI custom UI library for iOS and OSX.

![https://img.shields.io/cocoapods/v/LemonadeUI.svg?style=flat](https://img.shields.io/cocoapods/v/LemonadeUI.svg?style=flat)

![https://img.shields.io/cocoapods/l/LemonadeUI.svg?style=flat](https://img.shields.io/cocoapods/l/LemonadeUI.svg?style=flat)

![https://img.shields.io/cocoapods/p/LemonadeUI.svg?style=flat](https://img.shields.io/cocoapods/p/LemonadeUI.svg?style=flat)

## **Requirements**

---

- iOS 12.0+ / Mac OS X 10+
- Xcode 10.0+
- Swift 5.0+

### **Communication**

---

- If you **found a bug**, open an issue
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
- If you'd like to **ask a general question , reach me!**
    - [https://github.com/ozgurelmasli](https://github.com/ozgurelmasli)
    - [https://twitter.com/ElmasliOzgur](https://twitter.com/ElmasliOzgur)

### **Installation**

---

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate LemonadeUI into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
	pod 'LemonadeUI'
end
```

Then, run the following command:

```
$ pod install
```

### Usage

---

- Contraints

```swift
someView.top(otherView, equalTo: .top, constant: 10, safeArea: true)
someView.left(otherView, equalTo: .left , constant: 10)
// ....
someView.leftAndRight(view , constant: 24)
// ....
someView.centerX(otherView, equalTo: .centerX)
someView.center(to: otherView, width: .screenWidth(24), height: .screenHeight())
someView.center(to: otherView)
// ....
someView.height(constant: 20)
someView.width(otherView, equalTo: .height, multiplier: 0.8, safeArea: true)
someView.width(constant: .screenWidth(48))
// .... 
someView.fill2SuperView()
someView.fill2SuperView(.init(right: 10, left: 10, top: 10, bottom: 10))
```

- Some basic configuration types and functions usages

```swift
public struct LemonadeBorder {
    var borderColor : CGColor
    var borderWidth : CGFloat 
...
}
someView.border(...//LemonadeBorder)
```

```swift
public struct LemonadeRadius {
    var radius : CGFloat
    var maskedCorners : CACornerMask?
...
}
someView.radius(...//LemonadeRadius)
```

```swift
public struct LemonadeGradient {
    var colors : [CGColor]
    var from : CGPoint
    var to   : CGPoint
    var locations : [NSNumber]?
...
}
someView.gradient(...//LemonadeRadius)
```

```swift
public struct LemonadeColor {
    var backgroundColor : UIColor?
    var gradient        : LemonadeGradient?
...
}
someView.color(...//LemonadeColor)
```

```swift
public struct LemonadeEmptyUI {
    var image : UIImage?
    var text  : String
    var descriptionText : String?
...
}
 someView.emptyUI(...//LemonadeEmptyUI)
```

- Some basic custom component usages

```swift
import LemonadeUI

private lazy var lotus : LemonadeLotus = {
        let config = LemonadeLotusConfig(petal: .systemBlue, numberOfItems: 8, pattern: [
            .init(duration: 3, position: .sleep),
            .init(duration: 4, position: .awake),
            .init(duration: 1, position: .sleep),
            .init(duration: 5, position: .awake),
        ])
        let lotus = LemonadeLotus(frame: .zero, config)
        lotus.lotusDelegate = self
        return lotus
    }()
....

extension ExampleVC: LemonadeLotusDelegate {
    func actionChanged(_ lotus: LemonadeLotus, action: LemonadeLotusAnimationPatternItem) {
        print("Action changed -> \(action.position)")
    }
    
    func animationStart(_ lotus: LemonadeLotus) {
        print("Animate Start")
    }
    
    func animationEnd(_ lotus: LemonadeLotus) {
        print("Animate Stop")
    }
}
```

```swift
import LemonadeUI

private lazy var exampleButton: LemonadeButton = {
        let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .systemBlue), radius:.init(radius: 8))
        button.text(.init(text: "Start Pattern", color: .white, font: .systemFont(ofSize: 20), alignment: .center))
        return button
    }()

....

private func handlers(){
        exampleButton.addAction { [weak self] in
            // actions
        }
}
```

```swift
import LemonadeUI

private lazy var flower: LemonadeFlower = {
        let config: LemonadeFlowerConfig = .init(items: [
            .init(sliceColor: .init(backgroundColor: .systemBlue.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 2.0)),
            .init(sliceColor: .init(backgroundColor: .systemPink.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .black, width: 1.0)),
            .init(sliceColor: .init(backgroundColor: .black.withAlphaComponent(0.7)), sliceBorder: .init(borderColor: .white, width: 2.0), customView: .init(frame: .zero, color: .init(backgroundColor: .orange), radius: .init(radius: 20), border: .init(borderColor: .white, width: 2.0)))
        ], spacing: 3)
        let flower: LemonadeFlower = .init(frame: .zero, config)
        flower.backgroundColor = .clear
        flower.flowerdelegate = self
        return flower
    }()

....

extension ExampleVC: LemonadeFlowerDelegate {
    func sliceTapped(_ flower: LemonadeFlower, index: Int) {
        print("Index Tapped -> \(index)")
    }
}
```

### Playground

---

You can try LemonadeUI on Example Project. Just download and run Example Project. 

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/a89f8dc4-2f0a-4524-9a45-cf94e9b220a9/Simulator_Screen_Shot_-_iPhone_13_Pro_Max_-_2022-02-02_at_01.16.33.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220201%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220201T222952Z&X-Amz-Expires=86400&X-Amz-Signature=7efcfff73a3c2927d8de295035a6108183ede8bbe73e4377d2e655ea785f846f&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Simulator%2520Screen%2520Shot%2520-%2520iPhone%252013%2520Pro%2520Max%2520-%25202022-02-02%2520at%252001.16.33.png%22&x-id=GetObject" width="250" height="500" />

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/c3c24b22-36ba-468e-b36f-f87a68a0b02a/Simulator_Screen_Shot_-_iPhone_13_Pro_Max_-_2022-02-02_at_01.17.16.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220201%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220201T222918Z&X-Amz-Expires=86400&X-Amz-Signature=4898a1f75dc8c5406ba8a74be90983fd572fa4744674ddd4bd0d9ba0c824e304&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Simulator%2520Screen%2520Shot%2520-%2520iPhone%252013%2520Pro%2520Max%2520-%25202022-02-02%2520at%252001.17.16.png%22&x-id=GetObject" width="250" height="500" />

<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3e46feb5-d677-480f-838a-544b2934e5fb/Simulator_Screen_Shot_-_iPhone_13_Pro_Max_-_2022-02-02_at_01.16.45.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220201%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220201T222935Z&X-Amz-Expires=86400&X-Amz-Signature=e652345bfdd92f0591aed83b2431f5552905eb1e2e35938de089de615774e798&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Simulator%2520Screen%2520Shot%2520-%2520iPhone%252013%2520Pro%2520Max%2520-%25202022-02-02%2520at%252001.16.45.png%22&x-id=GetObject" width="250" height="500" />

### **Resources**

---

- [Documentation](https://ozgurelmasli.github.io/lemonadeUI.github.io/)

### **Credits**

---

- Hasan Ozgur Elmasli ([@ElmasliOzgur](https://twitter.com/ElmasliOzgur))

### **License**

LemonadeUI is released under the MIT license. See LICENSE for details.
