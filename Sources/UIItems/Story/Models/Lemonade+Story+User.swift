//
//  LemonadeStoryUser.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 7.03.2022.
//

public struct LemonadeStoryUser {
    
    var userId: String
    
    var username: String
    
    var userImagePath: ImageSourceType
    
    public init(userId: String = UUID().uuidString
                , username: String
                , imagePath: ImageSourceType) {
        self.userId = userId
        self.username = username
        self.userImagePath = imagePath
    }
}
