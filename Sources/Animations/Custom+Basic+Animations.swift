//
//  Custom+Basic+Animations.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 13.08.2021.
//


public enum LemonadeBasicAnimation {
    
    /// Toggle Opacity
    case toggleOpacity
    
}

extension LemonadeBasicAnimation {
    /**
     Configure basic animation
     
     - parameter config: LemonadeAnimationConfig.
     - parameter view: Which view will animate.
     - returns: None
     */
    internal func configureAnimation(_ config : LemonadeAnimationConfig
                                     , view : UIView
                                     , complitionHandler : @escaping ()->Void) {
        switch self {
        case .toggleOpacity:
            toggleOpacity(view, duration: Double(config.duration), complitionHandler: complitionHandler)
        }
    }
}
extension LemonadeBasicAnimation {
    private func toggleOpacity( _ view : UIView , duration : Double , complitionHandler : @escaping ()->Void) {
        UIView.animate(withDuration: duration) {
            view.layer.opacity = 0.0
        } completion: { _ in
            complitionHandler()
            UIView.animate(withDuration: duration) {
                view.layer.opacity = 1.0
            }
        }

    }
}
