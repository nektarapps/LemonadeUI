//
//  StoryVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 23.02.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

class StoryVC: UIViewController {
    private var dummy_stories: [LemonadeStoryItem] = [
        .init(storySource: .fromUrl(url: "https://dummyimage.com/600x400/000/fff"), user: .init(username: "ozgurelmasli", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")), isMessageActive: true, postDate: Date()),
        .init(storySource: .fromUrl(url: "http://placeimg.com/640/360/any"), user: .init(username: "hasanOzgurElmasli", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")), isMessageActive: true, postDate: Date()),
        .init(storySource: .fromUrl(url: "http://placeimg.com/640/360/any"), user: .init(username: "ozgurelmasli123", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")), isMessageActive: true, postDate: Date()),
        .init(storySource: .fromUrl(url: "http://placeimg.com/640/360/any"), user: .init(username: "ozgurelmasli134", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")), isMessageActive: true, postDate: Date()),
        .init(storySource: .fromUrl(url: "http://placeimg.com/640/360/any"), user: .init(username: "ozgurelmasli12", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")), isMessageActive: true, postDate: Date())
    ]
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: 100, height: 120)
        flowLayout.estimatedItemSize = .init(width: 100, height: 120)
        return flowLayout
    }()
    
    
    private lazy var storyList : LemonadeStoryList = {
        let list = LemonadeStoryList(frame: .zero
                                     , collectionViewLayout: flowLayout
                                     , stories: dummy_stories
                                     , currentUser: .init(username: "ozgurelmasli", imagePath: .fromUrl(url: "http://placeimg.com/640/360/any")))
        return list
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(storyList)
        storyList.leftAndRight(view , constant: 24)
        storyList.top(view, equalTo: .top)
        storyList.height(constant: 200)
    }
}
