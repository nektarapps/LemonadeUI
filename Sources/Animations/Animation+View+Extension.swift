//
//  Animation+View+Extension.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//

import UIKit



extension UIView {
    
    /**
     Animate start with type and config data
     
     - parameter animation: Animation type.
     - parameter config: LemonadeAnimationConfig  , repeat , duration , autoreverse
     */
    public func animate( _ animation : LemonadeAnimation , config : LemonadeAnimationConfig = .init(duration: 2.0)) {
        switch animation {
        case .opacity , .pulse , .gradientTransition:
            guard let animation = animation.configureKeyFrameAnimations(config, view: self) else { return }
            self.layer.add(animation, forKey: animation.keyPath)
        default:
            guard let animation = animation.configureAnimation(config, view: self) else { return }
            self.layer.add(animation, forKey: animation.keyPath)
        }
    }
    
    /**
     Animate start with type and config data
     
     - parameter animation: Animation type.
     - parameter config: LemonadeAnimationConfig  , repeat , duration , autoreverse
     */
    public func animate( _ animation : LemonadeBasicAnimation
                         , config : LemonadeAnimationConfig = .init(duration: 2.0) , complitionHanler : @escaping ()->Void ) {
        animation.configureAnimation(config, view: self, complitionHandler: complitionHanler)
    }
    
    
    
    /**
     Animations start with type and total config data
     
     - parameter animations: Animation type array.
     - parameter config: LemonadeAnimationConfig  , repeat , duration , autoreverse
     */
    public func animate( _ animations : [LemonadeAnimation] , config : LemonadeAnimationConfig = .init(duration: 2.0)) {
        if animations.isEmpty { return }
        var caAnimations : [CAAnimation] = []
        for animation in animations {
            switch animation {
            case .opacity , .pulse , .gradientTransition:
                guard let animation = animation.configureKeyFrameAnimations(config, view: self) else { return }
                caAnimations.append(animation)
            default:
                guard let animation = animation.configureAnimation(config, view: self) else { return }
                caAnimations.append(animation)
            }
        }
        guard let animationGroup = animations.first?.configureAnimationGroup(config, caAnimations) else { return }
        self.layer.add(animationGroup, forKey: UUID.init().uuidString)
    }
}
