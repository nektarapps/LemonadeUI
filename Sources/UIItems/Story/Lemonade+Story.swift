//
//  Lemonade+Story.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 27.02.2022.
//

import Foundation


class LemonadeStoryShowcaseCell: UICollectionViewCell {
    private lazy var storyBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .red.withAlphaComponent(0.5)
        return view
    }()
    private lazy var userImage: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var usernameLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: ""
                                         , color: .black
                                         , font: .systemFont(ofSize: 12)
                                         , alignment: .center))
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    private func configureLayout(){
        addSubview(storyBackground)
        addSubview(usernameLabel)
        storyBackground.addSubview(userImage)
        
        storyBackground.center(to: self)
        storyBackground.widthAndHeight(self, equalTo: .width, multiplier: 0.8)
        
        userImage.center(to: storyBackground)
        userImage.widthAndHeight(storyBackground, equalTo: .width, multiplier: 0.8)
        
        usernameLabel.leftAndRight(self)
        usernameLabel.top(storyBackground, equalTo: .bottom)
        usernameLabel.bottom(self, equalTo: .bottom)
    }
    
    func configureUI(username: String , image: ImageSourceType) {
        usernameLabel.text = username
        userImage.downloaded(from: image.url ?? URL(fileURLWithPath: ""))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
