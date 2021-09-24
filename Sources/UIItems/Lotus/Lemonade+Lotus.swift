//
//  Lemonade+Lotus.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 23.09.2021.
//

public protocol LemonadeLotusDelegate : AnyObject {
    /// Action changed ( awake , sleep)
    func actionChanged( _ lotus : LemonadeLotus , action : LemonadeLotusAnimationPatternItem)
    /// Animation start
    func animationStart( _ lotus : LemonadeLotus)
    /// Animation stop
    func animationEnd( _ lotus : LemonadeLotus)
}

public class LemonadeLotus : UIView {
    
    /// Lotus delegate
    public weak var lotusDelegate : LemonadeLotusDelegate?
    
    /// Config
    private var config : LemonadeLotusConfig?
    
    /// Current posiition
    public var position : LemonadeLotusAnimationPosition = .awake

    /// Animation start or not
    private var isAnimationStart : Bool = false
    
    /// Pattern current index
    private var patternCurrentIndex : Int = 0
    
    
    public convenience init(frame : CGRect , _ config : LemonadeLotusConfig){
        self.init(frame:frame)
        self.backgroundColor = .clear
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.config = config
    }
    
    deinit {
        self.config = nil
        self.lotusDelegate = nil
    }
    
    /// Create transform depends on numberOfItems
    private var nodeAngleTransform : CATransform3D {
        let angle = -CGFloat.pi * 2.0   / CGFloat(config?.numberOfItems ?? 0)
        return CATransform3DMakeRotation(angle, 0, 0 , 1)
    }
    
    /// CenterY
    private lazy var centerY : CGFloat = {
        return self.bounds.width / 2.0
    }()
    /// CenterX
    private lazy var centerX : CGFloat = {
        return self.bounds.height / 2.0
    }()
    /// Radius
    private lazy var radius: CGFloat = {
        return min(bounds.width, bounds.height)/2
    }()
    
    /// Create one Circle
    private lazy var Circle : CALayer = {
        let circle = CALayer()
        circle.compositingFilter = "screenBlendMode"
        circle.frame = CGRect(origin: CGPoint(x: 0, y: -(self.centerX / 2)), size: CGSize(width: self.centerX, height: self.centerX))
        circle.backgroundColor = config?.petalColor.cgColor
        circle.cornerRadius = centerX / 2.0
        return circle
    }()
    
    /// Replicate Circle with nodeAngleTransform
    private lazy var replicatorLayer : CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.addSublayer(Circle)
        replicatorLayer.instanceCount = config?.numberOfItems ?? 0
        replicatorLayer.instanceBlueOffset = (-0.33 / Float(config?.numberOfItems ?? 0))
        replicatorLayer.instanceTransform = nodeAngleTransform
        return replicatorLayer
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addSublayer(replicatorLayer)
        replicatorLayer.position = CGPoint(x: self.centerX, y: self.centerY)
    }
}
extension LemonadeLotus {
    /// Configure
    public func configure( _ config : LemonadeLotusConfig) {
        self.config = config
    }
}
extension LemonadeLotus {
    /// Start pattern animation. If exists
    public func startPattern(){
        guard
            let pattern = config?.pattern
            , !pattern.isEmpty
        else { return }
        self.isAnimationStart = true
        let duration = pattern.first!.duration
        pattern.first!.position == .sleep
        ? closeLotus(duration)
        : openLotus(duration)
        lotusDelegate?.actionChanged(self, action: pattern.first!)
        lotusDelegate?.animationStart(self)
    }
    /// Open lotus animation with duration
    public func openLotus( _ duration : CGFloat) {
        self.position = .awake
        let config = LemonadeAnimationConfig.init(duration: duration
                                                  , repeatCount: 0
                                                  , autoReverse: false)
        self.rotate(config)
        self.move(config)
        self.scale(config)
    }
    /// Close lotus animation with duration
    public func closeLotus( _ duration : CGFloat) {
        self.position = .sleep
        let config = LemonadeAnimationConfig.init(duration: duration
                                                  , repeatCount: 0
                                                  , autoReverse: false)
        self.rotate(config)
        self.move(config)
        self.scale(config)
    }
}
extension LemonadeLotus {
    func rotate( _ config : LemonadeAnimationConfig ) {
        let from = position == .awake ? -CGFloat.pi * 0.75 : 0.0
        let to   = position == .awake ? 0.0 : -CGFloat.pi * 0.75
        guard let animation = LemonadeAnimation.rotate(from: from, to: to).configureAnimation(config) else { return }
        replicatorLayer.add(animation, forKey: "rotate")
    }
    func move( _ config : LemonadeAnimationConfig){
        let center = CGPoint(x: layer.bounds.width/2 - radius, y: layer.bounds.height/2 - radius )
        let from = position == .awake ? center : Circle.position
        let to   = position == .awake ? Circle.position : center
        guard let animation = LemonadeAnimation.move(from: from, to: to).configureAnimation(config) else { return }
        if isAnimationStart { animation.delegate = self }
        
        Circle.add(animation, forKey: "move")
    }
    func scale( _ config : LemonadeAnimationConfig){
        let from = position == .awake ? 0.4 : 1.0
        let to   = position == .awake ? 1.0 : 0.4
        guard let animation = LemonadeAnimation.scaleXY(from: from, to: to).configureAnimation(config) else { return }
        Circle.add(animation, forKey: "scaleDown")
    }
}
extension LemonadeLotus : CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !flag { return }
        self.action()
    }
    
    /// Pattern control
    private func action() {
        if patternCurrentIndex + 1 > config!.pattern.count - 1  {
            patternCurrentIndex = 0
            isAnimationStart = false
            lotusDelegate?.animationEnd(self)
            return
        }
        let prev = config!.pattern[patternCurrentIndex]
        let next = config!.pattern[patternCurrentIndex + 1]
        if prev.position == next.position {
            DispatchQueue.main.asyncAfter(deadline: .now() + next.duration) {
                self.patternCurrentIndex += 1
                self.action()
            }
        }else {
            next.position == .sleep ? closeLotus(next.duration) : openLotus(next.duration)
            self.patternCurrentIndex += 1
        }
        
        lotusDelegate?.actionChanged(self, action: next)
    }
}

