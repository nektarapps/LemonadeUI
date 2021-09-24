//
//  Custom+Animations.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 12.08.2021.
//

import UIKit



public enum LemonadeAnimation {
    /// Scaling animation X axis
    case scaleX(scaleSize : CGFloat)
    
    /// Scaling animation Y axis
    case scaleY(scaleSize : CGFloat)
    
    /// Scaling animation X and Y axis
    case scaleXY(from : CGFloat , to : CGFloat)
    
    /// Shadow opacity animation
    case shadowOpacity
    
    /// Gradient transition animation
    case gradientTransition(from : [CGColor] , to : [CGColor])
    
    /// Pulsing . X and Y axis scale
    case pulse(scaleSize : CGFloat)
    
    /// Opacity change
    case opacity(values : [CGFloat])
    
    /// Rotate animation
    case rotate(from : CGFloat , to : CGFloat)
    
    /// Move animation
    case move(from: CGPoint, to: CGPoint)
}



extension LemonadeAnimation {
    /**
     Configure animation for basic animation
     
     - parameter config: LemonadeAnimationConfig.
     - parameter view: Which view will animate.
     - returns: CABasicAnimation
     */
    internal func configureAnimation( _ config : LemonadeAnimationConfig , view : UIView) -> CABasicAnimation? {
        view.layoutIfNeeded()
        switch self {
        case .scaleX(let scaleSize):
            return scaleX(config, width: view.bounds.width, scaleSize)
        case .scaleY(let scaleSize):
            return scaleY(config, height: view.bounds.height, scaleSize)
        case .scaleXY(let from , let to):
            return scaleAnimation(config, from: from, to: to)
        case .shadowOpacity:
            return shadowOpacity(config, from: view.layer.shadowOpacity)
        case .gradientTransition(let from, let to):
            return gradientTransition(config, from: from, to: to)
        case .move(let from,let to):
            return move(config, from: from, to: to)
        case .rotate(let from , let to):
            return rotate(config, from: from, to: to)
        default:return nil
        }
    }
    
    
    /**
     Configure animation without view
     
     - parameter config: LemonadeAnimationConfig.
     - warning: Function only send animation , wont add any view
     */
    internal func configureAnimation( _ config : LemonadeAnimationConfig) -> CABasicAnimation? {
        switch self {
        case .rotate(let from, let to):
            return self.rotate(config, from: from, to: to)
        case .move(let from, let to):
            return self.move(config, from: from, to: to)
        case .scaleXY(let from , let to):
            return self.scaleAnimation(config, from: from, to: to)
        default:
            return nil
        }
    }
    
    /**
     Configure animation for keyframe animation
     
     - parameter config: LemonadeAnimationConfig.
     - parameter view: Which view will animate.
     - returns: CABasicAnimation
     */
    internal func configureKeyFrameAnimations( _ config : LemonadeAnimationConfig ,view : UIView) -> CAKeyframeAnimation? {
        view.layoutIfNeeded()
        switch self {
        case .pulse(let scaleSize):
            return pulse(config, scaleSize: scaleSize)
        case .opacity(let values):
            return opacity(config, values: values)
        default:
            return nil
        }
    }
    /**
     Configure animation group for basic animation
     
     - parameter config: LemonadeAnimationConfig.
     - parameter view: Which view will animate.
     - returns: CABasicAnimation
     */
    internal func configureAnimationGroup( _ config : LemonadeAnimationConfig ,  _ animations : [CAAnimation]) -> CAAnimationGroup {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = CFTimeInterval(config.duration)
        animationGroup.repeatCount = Float(config.repeatCount ?? .infinity)
        animationGroup.animations = animations
        animationGroup.autoreverses = config.autoReverse
        return animationGroup
    }
}

extension LemonadeAnimation {
    /// Pulsing animation with config data
    private func pulse( _ config : LemonadeAnimationConfig , scaleSize : CGFloat) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, scaleSize , 1.0]
        animation.keyTimes = [0 , 0.5 , 1]
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        return animation
    }
    /// Opacity animation with config data
    private func opacity( _ config : LemonadeAnimationConfig , values : [CGFloat]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = values
        animation.keyTimes = [0 , 0.5 , 1.0]
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.autoreverses = config.autoReverse
        return animation
    }
    /// ShadowOpacity animation with config data
    private func shadowOpacity( _ config : LemonadeAnimationConfig , from : Float) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = from
        animation.toValue = 1.0
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.autoreverses = config.autoReverse
        return animation
    }
    /// GradientTransition animation with config data
    private func gradientTransition( _ config : LemonadeAnimationConfig , from  : [CGColor] , to : [CGColor]) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = CFTimeInterval(config.duration)
        animation.fromValue = from
        animation.toValue = to
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.autoreverses = config.autoReverse
        animation.isRemovedOnCompletion = false
        return animation
    }
}
//MARK:-> Scaling animations
extension LemonadeAnimation {
    /// Scale X axis animation with config data
    private func scaleX( _ config : LemonadeAnimationConfig , width : CGFloat , _ scaleSize : CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.fromValue = 1
        animation.toValue = (width + scaleSize) / (width)
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.autoreverses = config.autoReverse
        return animation
    }
    /// Scale Y axis animation with config data
    private func scaleY( _ config : LemonadeAnimationConfig , height : CGFloat , _ scaleSize : CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.fromValue = 1
        animation.toValue = (height + scaleSize) / (height)
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.autoreverses = config.autoReverse
        return animation
    }
    /// Scale X and Y axis animation with config data
    private func scaleAnimation( _ config : LemonadeAnimationConfig , from: CGFloat , to : CGFloat)->CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = CFTimeInterval(config.duration)
        animation.repeatCount = Float(config.repeatCount ?? .infinity)
        animation.isRemovedOnCompletion = false
        animation.autoreverses = config.autoReverse
        animation.fillMode = CAMediaTimingFillMode.forwards
        return animation
    }
}
extension LemonadeAnimation {
    /// Rotate animation with config data
    private func rotate( _ config : LemonadeAnimationConfig , from : CGFloat , to : CGFloat)-> CABasicAnimation {
        let transformRotate = CABasicAnimation(keyPath: "transform.rotation")
        transformRotate.fromValue = from
        transformRotate.toValue = to
        transformRotate.duration = CFTimeInterval(config.duration)
        transformRotate.repeatCount = Float(config.repeatCount ?? .infinity)
        transformRotate.fillMode = CAMediaTimingFillMode.forwards
        transformRotate.isRemovedOnCompletion = false
        transformRotate.autoreverses = config.autoReverse
        return transformRotate
    }
    /// Move animation with config data
    private func move( _ config : LemonadeAnimationConfig , from: CGPoint, to: CGPoint) -> CABasicAnimation {
        let movePosition = CABasicAnimation(keyPath: "position")
        movePosition.fromValue = from
        movePosition.toValue = to
        movePosition.duration = CFTimeInterval(config.duration)
        movePosition.repeatCount = Float(config.repeatCount ?? .infinity)
        movePosition.fillMode = CAMediaTimingFillMode.forwards
        movePosition.isRemovedOnCompletion = false
        movePosition.autoreverses = config.autoReverse
        return movePosition
    }
    
}
