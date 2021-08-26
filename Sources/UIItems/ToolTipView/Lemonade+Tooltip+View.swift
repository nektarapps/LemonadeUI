//
//  Lemonade+Tooltip+View.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 26.08.2021.
//

import UIKit



public class LemonadeToolTip : UIView {
    private var configs : [LemonadeToolTipConfig] = []
    private var startIndex : Int = 0
    private var endIndex : Int = 0
}
extension LemonadeToolTip {
    public func configure( _ config : [LemonadeToolTipConfig]){
        if self.superview == nil { fatalError("SuperView can't be empty")}
        self.configs = config
        self.endIndex = configs.count - 1
        self.fill2SuperView()
       // self.isHidden = true
        
        self.drawToolTip()
    }
}
extension LemonadeToolTip {
    // Start
    // Reset
    // Clear
    // Next
    // Prev
}
extension LemonadeToolTip {
    private func drawToolTip(){
        if configs.isEmpty { return }
        let item = configs[startIndex]
        item.view.layoutIfNeeded()
        
        let overlayView = UIView(frame: self.bounds)
        let targetMaskLayer = CAShapeLayer()

        let squareSide = frame.width / 1.6
        let squareSize = CGSize(width: squareSide, height: squareSide)
        let squareOrigin = CGPoint(x: CGFloat(center.x) - (squareSide / 2),
                                   y: CGFloat(center.y) - (squareSide / 2))
        let square = UIBezierPath(roundedRect: CGRect(origin: squareOrigin, size: squareSize), cornerRadius: 16)

        let path = UIBezierPath(rect: self.bounds)
        path.append(square)

        targetMaskLayer.path = path.cgPath
        // Exclude intersected paths
        targetMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        overlayView.layer.mask = targetMaskLayer
        overlayView.clipsToBounds = true
        overlayView.alpha = 0.6
        overlayView.backgroundColor = UIColor.black

        addSubview(overlayView)
        
      //  self.isHidden = false
    }
}

extension UIView {
    public func addOverlayView() {
        let overlayView = UIView(frame: self.bounds)
        let targetMaskLayer = CAShapeLayer()

        let squareSide = frame.width / 1.6
        let squareSize = CGSize(width: squareSide, height: squareSide)
        let squareOrigin = CGPoint(x: CGFloat(center.x) - (squareSide / 2),
                                   y: CGFloat(center.y) - (squareSide / 2))
        let square = UIBezierPath(roundedRect: CGRect(origin: squareOrigin, size: squareSize), cornerRadius: 16)

        let path = UIBezierPath(rect: self.bounds)
        path.append(square)

        targetMaskLayer.path = path.cgPath
        // Exclude intersected paths
        targetMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        overlayView.layer.mask = targetMaskLayer
        overlayView.clipsToBounds = true
        overlayView.alpha = 0.6
        overlayView.backgroundColor = UIColor.black

        addSubview(overlayView)
    }
}
