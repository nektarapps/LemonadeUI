//
//  Default+Lemonade+Cell.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 3.09.2021.
//


public class DefaultLemonadeCell : LemonadeCell {

    private weak var titleLabel : LemonadeLabel? = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 15), alignment: .left, breakMode: .byWordWrapping))
    }()
    private weak var descriptionLabel : LemonadeLabel? = {
        return .init(frame: .zero, .init(text: "", color: UIColor.black.withAlphaComponent(0.7), font: .systemFont(ofSize: 12), alignment: .left, breakMode: .byWordWrapping))
    }()
   
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(titleLabel!)
        
        titleLabel?.left(self, equalTo: .left , constant: 24)
        titleLabel?.right(self, equalTo: .right , constant: -24)
        titleLabel?.centerX(self, equalTo: .centerX)
        titleLabel?.top(self, equalTo: .top)
        
        
        self.addSubview(descriptionLabel!)
        descriptionLabel?.top(titleLabel!, equalTo: .bottom)
        descriptionLabel?.left(self, equalTo: .left , constant: 24)
        descriptionLabel?.right(self, equalTo: .right , constant: -24)
        descriptionLabel?.bottom(self, equalTo: .bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
