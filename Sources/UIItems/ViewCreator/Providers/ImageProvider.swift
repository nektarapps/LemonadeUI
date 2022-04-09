//
//  ImageProvider.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 9.04.2022.
//

import Foundation


public class ImageProvider: ViewProvider<UIImageView> {
    
    var sourceType: ImageSourceType?
    var contentMode: UIImageView.ContentMode
    
    public init(backgroundColor: LemonadeColor? = nil
                         , radius: LemonadeRadius? = nil
                         , border: LemonadeBorder? = nil
                         , shadow: LemonadeShadow? = nil
                         , sourceType: ImageSourceType? = nil
                         , contentMode: UIImageView.ContentMode = .scaleAspectFit) {
        
        self.sourceType = sourceType
        self.contentMode = contentMode
        
        super.init(backgroundColor: backgroundColor, radius: radius, border: border, shadow: shadow)
    }
    public override func applyModifiers() -> UIImageView {
        let imageview = super.applyModifiers()
        imageview.contentMode = contentMode
        
        if let sourceType = sourceType {
            sourceType.image { image in
                imageview.image = image
            }
        }
        
        return imageview
    }
    
}
