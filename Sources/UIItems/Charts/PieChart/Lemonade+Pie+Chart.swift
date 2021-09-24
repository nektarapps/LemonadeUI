//
//  Lemonade+Pie+Chart.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 24.09.2021.
//

import Foundation

public protocol LemonadePieChartDelegate : AnyObject {
    /// Slice tapped
    func pieChartsliceTapped( _ flower : LemonadePieChart , _ item : LemonadePieChartItem , index : Int)
}



public class LemonadePieChart : UIView {
    /// Pie Chart delegate
    public weak var pieCharDelegate : LemonadePieChartDelegate?
    /// Flower Config
    private var config : LemonadePieChartConfig?
    
    private var angles : [CGFloat] = []
    
    private var isDraw : Bool = false
    
    private var currentAngle : CGFloat = -90
    private var bezierPaths : [UIBezierPath] = []
    
    private var tapGesture : UITapGestureRecognizer?
    
    public convenience init(frame : CGRect , _ config : LemonadePieChartConfig){
        self.init(frame:frame)
        self.configure(config)
    }
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let config = config else { return }
        if !isDraw  {
            for (item , angle) in zip(config.items, angles) {
                createPieSlice(item, angle: angle)
            }
            if config.isAnimate {
                self.animate([
                    .rotate(from: 1.0, to: .pi * 2.0),
                    .scaleXY(from: 0.2, to: 1.0)
                ], config: .init(duration: 1.0, repeatCount: 1, autoReverse: false))
            }
            isDraw = true
        }
    }
    
    /// CenterY
    private lazy var centerY : CGFloat = {
        return self.bounds.width / 2.0
    }()
    /// CenterX
    private lazy var centerX : CGFloat = {
        return self.bounds.height / 2.0
    }()
    /// R
    private lazy var _R : CGFloat = {
        return (self.bounds.width / 2.0) - 24
    }()
    
    deinit {
        config = nil
        pieCharDelegate = nil
        if tapGesture != nil {
            self.removeGestureRecognizer(tapGesture!)
        }
    }
}

extension LemonadePieChart {
    
    /// Configure Function
    public func configure ( _ config : LemonadePieChartConfig) {
        self.config = config
        self.angles = config.angles()
        self.isUserInteractionEnabled = true
        self.tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pieCharSliceTapped(gesture:)))
        self.addGestureRecognizer(tapGesture!)
    }
}

extension LemonadePieChart {
    private func createPieSlice( _ item : LemonadePieChartItem , angle : CGFloat) {
        let center = CGPoint.init(x: centerX, y: centerY)
        let startAngle = (self.currentAngle / 180) * .pi
        let endAngle = ((angle + self.currentAngle) / 180) * .pi
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: center)
        bezierPath.addArc(withCenter: center
                          , radius: _R
                          , startAngle: startAngle
                          , endAngle: endAngle
                          , clockwise: true)
        item.color.setFill()
        bezierPath.fill()
        bezierPath.close()
        bezierPaths.append(bezierPath)
        currentAngle += angle
        
        if item.border != nil {
            let layer = CAShapeLayer.init()
            layer.lineWidth = item.border!.borderWidth
            layer.path = bezierPath.cgPath
            layer.strokeColor = item.border!.borderColor
            layer.fillColor = item.color.cgColor
            self.layer.addSublayer(layer)
        }
        
        createPieSliceText(startAngle: Float(startAngle)
                           , endAngle: Float(endAngle)
                           , text: item.text ?? .init(text: "\(item.value)", color: .white, font: .systemFont(ofSize: 12), alignment: .center))
    }
    private func createPieSliceText(startAngle : Float , endAngle : Float , text : LemonadeText){
        guard
            let config = config
                , !config.items.isEmpty
        else {return}
        
        let normalEnd = endAngle < startAngle ? endAngle + 2 * .pi : endAngle
        let centerAngle = startAngle + (normalEnd - startAngle) / 2
        let center = CGPoint(x: centerX, y: centerY)
        let arcCenterX = Float(center.x) + cos(centerAngle) * Float((_R / 5) * 3)
        let arcCenterY = Float(center.y) + sin(centerAngle) * Float((_R / 5) * 3)
        let label  : LemonadeLabel = .init(frame: .zero, text)
        let radius : CGFloat = 100.0
        label.frame = CGRect(x: CGFloat(arcCenterX) - (radius / 2), y: CGFloat(arcCenterY) - (radius / 2), width: radius, height: radius)
        self.addSubview(label)
    }
}
extension LemonadePieChart {
    @objc private func pieCharSliceTapped(gesture : UITapGestureRecognizer) {
        let touch = gesture.location(in: self)
        var tappedIndex : Int? = nil
        for (index , item) in bezierPaths.enumerated() {
            if item.contains(touch) {
                tappedIndex = index
            }
        }
        if let index = tappedIndex {
            pieCharDelegate?.pieChartsliceTapped(self, config!.items[index], index: index)
        }
    }
}
