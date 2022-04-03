//
//  Lemonade+Story+Cell.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 7.03.2022.
//

public class LemonadeStoryCell: UICollectionViewCell {
    private lazy var imageHolderView: UIView = {
        return .init(frame: .zero
                     , color: .init(backgroundColor: .black)
                     , radius: .init(radius: 35))
    }()
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.radius(.init(radius: 30))
        return imageView
    }()
    
    private lazy var usernameLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: ""
                                         , color: .black.withAlphaComponent(0.6)
                                         , font: .systemFont(ofSize: 14)
                                         , alignment: .center ))
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubview(imageHolderView)
        imageHolderView.addSubview(imageView)
        addSubview(usernameLabel)
        
        imageHolderView.center(to: self, width: 70, height: 70)
        imageView.center(to: imageHolderView, width: 60, height: 60)
        usernameLabel.leftAndRight(self)
        usernameLabel.top(imageHolderView, equalTo: .bottom)
        usernameLabel.bottom(self, equalTo: .bottom)
    }
    
    public func configureData(customBorderColor: LemonadeColor
                              , username: String
                              , source: ImageSourceType) {
        imageHolderView.color(customBorderColor)
        usernameLabel.text = username
        source.image { [weak self] currentImage in self?.imageView.image = currentImage }
    }
}
