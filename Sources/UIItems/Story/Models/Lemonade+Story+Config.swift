//
//  Lemonade+Story+Config.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 7.03.2022.
//

public struct LemonadeStoryConfig {
    
    var currentUser: LemonadeStoryUser
    
    var isCurrentUserHide: Bool
    
    var isLoadAllStories: Bool
    
    var storyBorderColor: LemonadeColor
    
    public init(currentUser: LemonadeStoryUser
                , isCurrentUserHide: Bool = false
                , isLoadAllStories: Bool = true
                , storyBorderColor: LemonadeColor) {
        self.currentUser = currentUser
        self.isCurrentUserHide = isCurrentUserHide
        self.isLoadAllStories = isLoadAllStories
        self.storyBorderColor = storyBorderColor
    }
}
