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
        
        let label = UILabel.init()
        label.text = emptyConfig.text
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        self.addSubview(label)
        label.centerY(self, equalTo: .centerY ,constant: emptyConfig.image == nil ? 0.0 : 160)
        label.centerX(self, equalTo: .centerX)
        label.width(self, equalTo: .width)
        
        
        if let description = emptyConfig.descriptionText {
            let descriptionlabel = UILabel.init()
            descriptionlabel.text = description
            descriptionlabel.textColor = UIColor.black.withAlphaComponent(0.7)
            descriptionlabel.font = .systemFont(ofSize: 12)
            descriptionlabel.textAlignment = .center
            self.addSubview(descriptionlabel)
            descriptionlabel.top(label, equalTo: .bottom , constant: 5)
            descriptionlabel.centerX(self, equalTo: .centerX)
            descriptionlabel.width(self, equalTo: .width)
        }
        
    }
}


