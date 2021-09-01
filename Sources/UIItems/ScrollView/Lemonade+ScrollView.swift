//
//  Lemonade+ScrollView.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 27.08.2021.
//

import UIKit




public class LemonadeScrollView: UIScrollView {
    
    public var contentView : UIView?
    
    private var strechingConfig : LemonadeStreching?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    convenience public init(frame: CGRect , add view : UIView) {
        self.init(frame:frame)
        self.addScrollView(to: view)
        
        self.delegate = self
    }
}

extension LemonadeScrollView {
    public func addScrollView(to view : UIView) {
        self.contentInsetAdjustmentBehavior = .never
        self.contentView = .init()
        
        view.addSubview(self)
        self.addSubview(contentView!)
        
        
        self.centerX(view, equalTo: .centerX)
        self.width(view, equalTo: .width)
        self.top(view, equalTo: .top)
        self.bottom(view, equalTo: .bottom)
        
        contentView?.centerX(self, equalTo: .centerX)
        contentView?.width(self, equalTo: .width)
        contentView?.top(self, equalTo: .top)
        contentView?.bottom(self, equalTo: .bottom)
        //contentView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    public func addLastItem( _ view : UIView , padding : CGFloat = 0.0) {
        if contentView == nil { return }
        view.bottom(self.contentView!, equalTo: .bottom , constant: padding)
    }
    public func addStreching( _ streching : LemonadeStreching) {
        self.strechingConfig = streching
    }
}


extension LemonadeScrollView : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if strechingConfig != nil {
            if scrollView.contentOffset.y > 0 { return }
            if scrollView.contentOffset.y < 0 {
                strechingConfig!.topAnchor.constant = scrollView.contentOffset.y
                strechingConfig!.heightAnchor.constant = self.strechingConfig!.defaultHeight - scrollView.contentOffset.y
            }
        }
        
    }
    
}


public struct LemonadeStreching {
    var defaultHeight : CGFloat
    var topAnchor : NSLayoutConstraint
    var heightAnchor : NSLayoutConstraint
    
    public init( _ height : CGFloat
                 , topAnchor : NSLayoutConstraint
                 , heightAnchor : NSLayoutConstraint) {
        self.defaultHeight = height
        self.topAnchor = topAnchor
        self.heightAnchor = heightAnchor
    }
}
