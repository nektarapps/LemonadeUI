//
//  Lemonade+Story+Data.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 7.03.2022.
//

import Foundation

public struct LemonadeStoryData {
    
    var user: LemonadeStoryUser
    
    var source: ImageSourceType
    
    var isMessagesActive: Bool
    
    var postDate: Date
    
    public init(user: LemonadeStoryUser
                , source: ImageSourceType
                , isMessagesActive: Bool = true
                , postDate: Date) {
        self.user = user
        self.source = source
        self.isMessagesActive = isMessagesActive
        self.postDate = postDate
    }
    
}
