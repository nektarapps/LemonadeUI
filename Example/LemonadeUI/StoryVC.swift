//
//  StoryVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 23.02.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

private let DUMMY_IMAGE_PATH : ImageSourceType = .fromUrl(path: "https://media.istockphoto.com/photos/professional-woman-working-from-home-picture-id1319189527")

private let currentUser   : LemonadeStoryUser = .init(userId: "username_1", username: "username", imagePath: DUMMY_IMAGE_PATH)
private let random_user_1 : LemonadeStoryUser = .init(userId: "username_2", username: "username_2", imagePath: DUMMY_IMAGE_PATH)
private let random_user_2 : LemonadeStoryUser = .init(userId: "username_3", username: "username_3", imagePath: DUMMY_IMAGE_PATH)
private let random_user_3 : LemonadeStoryUser = .init(userId: "username_4", username: "username_4", imagePath: DUMMY_IMAGE_PATH)


class StoryVC: UIViewController {
    
    private let stories: [LemonadeStoryData] = [
        .init(user: currentUser, source: DUMMY_IMAGE_PATH, isMessagesActive: true, postDate: Date())
    ]
    
    private lazy var storyList: LemonadeStory = {
        let list = LemonadeStory.init(frame: .zero, collectionViewLayout: .init()
                                      , config: .init(currentUser: currentUser, storyBorderColor: .init(backgroundColor: .red)), stories: stories)
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
