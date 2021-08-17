//
//  Custom+View+Extensions.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//


import UIKit



extension UIView {
    
    /// Create default empty UI include ImageView(Optional) , titlText , desscriptionText(Optional)
    public func emptyUI( _ emptyConfig : LemonadeEmptyUI) {
        if let image = emptyConfig.image {
            let imageView = UIImageView.init(image: image)
            self.addSubview(imageView)
            imageView.center(to: self, width: 150, height: 150)
        }
        
        let label = LemonadeLabel.init(frame: .zero, .init(text: emptyConfig.text, color: .blue, font: .systemFont(ofSize: 15), alignment: .center))
        self.addSubview(label)
        label.centerY(self, equalTo: .centerY ,constant: emptyConfig.image == nil ? 0.0 : 160)
        label.centerX(self, equalTo: .centerX)
        label.width(self, equalTo: .width)
        
        
        if let description = emptyConfig.descriptionText {
            let descriptionlabel = LemonadeLabel.init(frame: .zero, .init(text: description, color: UIColor.black.withAlphaComponent(0.7), font: .systemFont(ofSize: 12), alignment: .center))
            self.addSubview(descriptionlabel)
            descriptionlabel.top(label, equalTo: .bottom , constant: 5)
            descriptionlabel.centerX(self, equalTo: .centerX)
            descriptionlabel.width(self, equalTo: .width)
        }
        
    }
}


