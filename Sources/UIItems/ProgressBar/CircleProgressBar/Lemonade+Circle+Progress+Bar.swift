//
//  Lemonade+Circle+Progress+Bar.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 30.01.2022.
//

public class LemonadeCircleProgressBar: UIView {
    /// Config
    private var config : LemonadeCircleProgessBarConfig?
    
    private var isDraw: Bool = false
    
    private var currentIndex: Int = 0
    
    /// Start Angle
    private var defaultStartAngle: CGFloat = (0 / 180) * .pi
    
    /// End Angle
    private var defaultEndAngle: CGFloat = (360 / 180) * CGFloat.pi
    
    /// İnit function with config param
    public convenience init(frame: CGRect ,  _ config : LemonadeCircleProgessBarConfig) {
        self.init(frame : frame)
        self.configure(config)
    }

    /// Manuel configure wiith bar config type
    public func configure( _ config : LemonadeCircleProgessBarConfig) {
        self.config = config
        backgroundColor = .clear
        currentIndex = config.items.count - 1
    }
    
    public override func draw(_ rect: CGRect) {
        if isDraw { return }
        startDraw()
    }
    /// Start draw with this function
    private func startDraw() {
        guard let config = config , currentIndex != 0 else {
            return
        }
        for index in stride(from: currentIndex, through: 0, by: -1) {
            var _r = widthPosition() - (CGFloat(index) * config.spaceBetweenItems)
            _r -= .screenWidth() / 2
            let item = config.items[index]
            createCircle(with: _r , item: item)
            createPositionValue(with: _r, item: item)
        }
        createLabel()
    }
}
extension LemonadeCircleProgressBar {
    /// Label create
    private func createLabel() {
        guard let config = self.config else {
            return
        }
        let label = LemonadeLabel(frame: .zero, config.barTitleText)
        addSubview(label)
        label.leftAndRight(self)
        label.bottom(self, equalTo: .bottom)
    }
}
extension LemonadeCircleProgressBar {
    private func widthPosition() -> CGFloat {
        return bounds.width - 56
    }
    /// Center Point
    private func centerPoint() -> CGPoint {
        return CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
    }
    /// Cireate base circle with r and item value
    private func createCircle(with r: CGFloat, item: LemonadeCircleProgessBarItem) {
        let bezierPath = UIBezierPath(arcCenter: centerPoint()
                                      , radius: r
                                      , startAngle: defaultStartAngle
                                      , endAngle: defaultEndAngle
                                      , clockwise: true)
        bezierPath.lineWidth = item.lineWidth
        item.barTintColor.setStroke()
        bezierPath.stroke()
    }
    /// Create Position value with item and r
    private func createPositionValue(with r: CGFloat, item: LemonadeCircleProgessBarItem) {
        
        let bezierPath = UIBezierPath(arcCenter: centerPoint()
                                      , radius: r
                                      , startAngle: defaultStartAngle
                                      , endAngle: item.angleValue()
                                      , clockwise: true)
        let shapelayer = CAShapeLayer()
        shapelayer.fillColor = UIColor.clear.cgColor
        shapelayer.strokeColor = item.progressColor.cgColor
        shapelayer.lineWidth = item.lineWidth
        shapelayer.path = bezierPath.cgPath
        shapelayer.lineCap = .round
        
        self.layer.addSublayer(shapelayer)
        if item.isAnimate { addAnimation(to: shapelayer, duration: item.animateDuration) }
    }
    
    private func addAnimation(to shapeLayer: CAShapeLayer , duration: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        shapeLayer.add(animation, forKey: "stokeColorAnimation")
    }
}
