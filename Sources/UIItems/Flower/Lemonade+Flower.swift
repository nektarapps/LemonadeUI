//
//  Lemonade+Flower.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 24.09.2021.
//



public protocol LemonadeFlowerDelegate : AnyObject {
    /// Slice tapped
    func sliceTapped( _ flower : LemonadeFlower , index : Int)
}

public class LemonadeFlower : UIView {
    
    /// Flower delegate
    public weak var flowerdelegate : LemonadeFlowerDelegate?
    
    /// Flower Config
    private var config : LemonadeFlowerConfig?
    
    private var tapGesture : UITapGestureRecognizer?
    
    public convenience init(frame : CGRect , _ config : LemonadeFlowerConfig){
        self.init(frame:frame)
        self.configure(config)
    }
    
    deinit {
        config = nil
        flowerdelegate = nil
        if tapGesture != nil {
            self.removeGestureRecognizer(tapGesture!)
        }
    }
    /// Configure function
    public func configure( _ config : LemonadeFlowerConfig) {
        self.config = config
        self.isUserInteractionEnabled = true
        self.tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(sliceTapped(gesture:)))
        self.addGestureRecognizer(tapGesture!)
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
    /// SlicePerAngle
    private lazy var slicePerAngle : Float = {
        return 360.0 / Float(config!.numberOfItems)
    }()
    
    private var bezierPaths : [UIBezierPath] = []
    
    private var isDraw : Bool = false
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isDraw {
            for index in 0...(config!.numberOfItems - 1){
                createSlice(index)
            }
            self.isDraw = true
        }
    }
}

extension LemonadeFlower {
    private func createSlice( _ index : Int){
        guard
            let config = config
                , !config.flowerItems.isEmpty
        else { return }
        
        let item = config.flowerItems[index]
        let center = CGPoint(x: centerX, y: centerY)
        let startAngle = (((slicePerAngle / 180) * Float(index - 3)) * .pi)
        let endAngle = (((slicePerAngle / 180) * Float(index - 2)) * .pi)
        let breakAngle = endAngle - ((config.spacing / 180) * .pi)
        
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: center)
        bezierPath.addArc(withCenter: center,  radius: _R, startAngle: CGFloat(startAngle), endAngle: CGFloat(breakAngle), clockwise: true)
        bezierPath.close()
        item.slideColor.backgroundColor?.setFill()
        bezierPath.fill()
        bezierPaths.append(bezierPath)
        
        if item.sliceBorder != nil  {
            let layer = CAShapeLayer.init()
            layer.lineWidth = item.sliceBorder!.borderWidth
            layer.path = bezierPath.cgPath
            layer.strokeColor = item.sliceBorder!.borderColor
            layer.fillColor = item.slideColor.backgroundColor?.cgColor
            self.layer.addSublayer(layer)
        }
        
        
        //Spacing
        let spacing = UIBezierPath()
        spacing.move(to: center)
        spacing.addArc(withCenter: center ,  radius: _R, startAngle: CGFloat(breakAngle), endAngle: CGFloat(endAngle), clockwise: true)
        spacing.close()
        UIColor.clear.setFill()
        spacing.fill()
        
        createView(startAngle: startAngle, endAngle: breakAngle, index: index)
    }
    private func createView(startAngle : Float , endAngle : Float , index : Int) {
        guard let config = config else { return }
        if config.flowerItems.isEmpty { return }
        if index > config.flowerItems.count - 1 { return }
        guard let view = config.flowerItems[index].view else { return }
        let normalEnd = endAngle < startAngle ? endAngle + 2 * .pi : endAngle
        let centerAngle = startAngle + (normalEnd - startAngle) / 2
        let center = CGPoint(x: centerX, y: centerY)
        let arcCenterX = Float(center.x) + cos(centerAngle) * Float((_R / 5) * 3)
        let arcCenterY = Float(center.y) + sin(centerAngle) * Float((_R / 5) * 3)
        view.isUserInteractionEnabled = false
        let radius = _R * 1.7 / Double(config.numberOfItems)
        view.frame = CGRect(x: CGFloat(arcCenterX) - (radius / 2), y: CGFloat(arcCenterY) - (radius / 2), width: radius, height: radius)
        self.addSubview(view)
    }
}
extension LemonadeFlower {
    @objc private func sliceTapped(gesture : UITapGestureRecognizer) {
        let touch = gesture.location(in: self)
        var tappedIndex : Int? = nil
        for (index , item) in bezierPaths.enumerated() {
            if item.contains(touch) {
                tappedIndex = index
            }
        }
        if let index = tappedIndex {
            flowerdelegate?.sliceTapped(self, index: index)
        }
    }
}
