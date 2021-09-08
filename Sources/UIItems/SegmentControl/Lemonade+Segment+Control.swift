//
//  Lemonade+Segment+Control.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 6.09.2021.
//

public final class LemonadeSegmentControl : UIView {
    
    public weak var delegate : LemonadeSegmentControlDelegate?
    
    private var index : Int = 0
    private var customSelectorView : UIView?
    private var items : [LemonadeSegmentItem] = []
    
    private var selectorViewLeft : NSLayoutConstraint?
    
    private lazy var defaultSelectorView : UIView = {
        let view = UIView.init(frame: .zero, color: .init(backgroundColor: UIColor.white.withAlphaComponent(0.5)))
        view.radius(.init(radius: 12))
        return view
    }()
    
    public convenience init(frame : CGRect , items : [LemonadeSegmentItem]){
        self.init(frame:frame)
        
        self.configureUI(items)
    }
    public convenience init(frame : CGRect  , selectorView : UIView, items : [LemonadeSegmentItem]) {
        self.init(frame: frame)
        
        self.customSelectorView = selectorView
        self.configureUI(items)
    }
    public convenience init(frame: CGRect , selectorView : UIView , firstIndex : Int , items : [LemonadeSegmentItem]) {
        self.init(frame: frame)
        
        self.customSelectorView = selectorView
        self.index = firstIndex
        self.configureUI(items)
    }
}

extension LemonadeSegmentControl {
    private func configureUI( _ items : [LemonadeSegmentItem]){
        if items.isEmpty { return }
        self.items = items
        self.configureSelectorUI()
        self.configureSegmentControlUI()
    }
    private func configureSelectorUI(){
        let view = customSelectorView == nil ? defaultSelectorView : customSelectorView!
        self.addSubview(view)
        let multiplier = 1.0 / CGFloat(items.count)
        view.top(self, equalTo: .top , constant: 5)
        view.bottom(self, equalTo: .bottom , constant: -5)
        view.width(self, equalTo: .width, constant: 0, multiplier: multiplier)
        selectorViewLeft = view.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 5)
        selectorViewLeft?.isActive = true
    }
    
    private func configureSegmentControlUI(){
        let multiplier = 1.0 / CGFloat(items.count)
        for ( index , item ) in self.items.enumerated() {
            self.addSubview(item)
            item.tag = index
            item.isUserInteractionEnabled = true
            
            item.bottom(self, equalTo: .bottom)
            item.top(self, equalTo: .top)
            item.width(self, equalTo: .width, multiplier: multiplier)
            item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(segmentItemTapped(gesture:))))
            if index == 0 {
                item.left(self, equalTo: .left)
            }else {
                item.left(self.items[index - 1], equalTo: .right)
            }
            item.subviews.forEach {
                $0.layer.opacity = index == self.index ? 1.0 : 0.5
            }
        }
    }
}
extension LemonadeSegmentControl {
    @objc private func segmentItemTapped(gesture : UITapGestureRecognizer){
        guard let index = gesture.view?.tag else { return }
        self.segmentChange(index)
    }
    
    
    private func segmentChange( _ index : Int) {
        if self.index == index  { return }
        self.index = index
        self.layoutIfNeeded()
        
        let itemWidth = (self.bounds.width - 30) / CGFloat(items.count)
        let padding = CGFloat.init(index) * itemWidth
        let spacing = CGFloat.init(index * 5) + 5
        
        for (index , item)  in self.items.enumerated() {
            item.subviews.forEach {
                $0.layer.opacity = index == self.index ? 1.0 : 0.5
            }
        }
        
        self.delegate?.segmentChange(self, items[self.index], index: self.index)
        self.selectorViewLeft?.constant = padding + spacing
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
}
extension LemonadeSegmentControl {
    public func change(index :Int) {
        if index < 0 || index > items.count { return }
        self.segmentChange(index)
    }
    public func badge(index : Int , text : String) {
        if index < 0 || index > items.count { return }
        self.items[index].badgeText(text)
    }
}
