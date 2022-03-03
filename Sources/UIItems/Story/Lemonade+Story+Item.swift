//
//  Lemonade+Story+Item.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 27.02.2022.
//

import Foundation

public enum ImageSourceType {
    case fromUrl(url: String)
    case fromName(name: String)
    
    var url: URL? {
        switch self {
        case .fromUrl(let url):
            return URL(string: url)
        default:
            return nil
        }
    }
}

public struct LemonadeStoryUser {
    var username: String
    var imagePath: ImageSourceType
    
    public init(username: String , imagePath: ImageSourceType) {
        self.username = username
        self.imagePath = imagePath
    }
}


public struct LemonadeStoryItem {
    var storySource: ImageSourceType
    var user: LemonadeStoryUser
    var postDate: Date
    var isMessageActive: Bool
    
    public init(storySource: ImageSourceType
                , user: LemonadeStoryUser
                , isMessageActive: Bool
                , postDate: Date) {
        self.storySource = storySource
        self.user = user
        self.isMessageActive = isMessageActive
        self.postDate = postDate
    }
}
