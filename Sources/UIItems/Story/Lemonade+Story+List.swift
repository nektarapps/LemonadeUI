//
//  Lemonade+Story+List.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 27.02.2022.
//

import Foundation


public class LemonadeStoryList: UICollectionView {
    private let cellIdentifier: String = UUID().uuidString
    
    private var currentUser: LemonadeStoryUser?
    private var stories: [LemonadeStoryItem] = []
    private var users: [LemonadeStoryUser] = []
    
    public convenience init(frame: CGRect
                            , collectionViewLayout layout: UICollectionViewLayout
                            , stories: [LemonadeStoryItem]
                            , currentUser: LemonadeStoryUser?) {
        self.init(frame: frame, collectionViewLayout: layout)
        configure(stories: stories, currentUser: currentUser)
        registerCollectionView()
    }
    
    deinit {
        delegate = nil
        dataSource = nil
    }
    private func registerCollectionView(){
        register(LemonadeStoryShowcaseCell.self, forCellWithReuseIdentifier: cellIdentifier)
        delegate = self
        dataSource = self
    }
    
    public func configure(stories: [LemonadeStoryItem], currentUser: LemonadeStoryUser?) {
        self.stories = stories
        self.currentUser = currentUser
        configureData()
    }
    private func configureData() {
        extractAllUsers()
        sortCurrentUser()
    }
    private func extractAllUsers(){
        guard !stories.isEmpty else { return }
        let users = stories
            .unique(map: { $0.user.username })
            .map { $0.user }
        self.users = users
    }
    private func sortCurrentUser(){
        guard let currentUser = currentUser else {
            return
        }
        if let currentUserIndex = users.firstIndex(where: { $0.username == currentUser.username }) {
            users.remove(at: currentUserIndex)
            users.insert(currentUser, at: 0)
        }else {
            users.insert(currentUser, at: 0)
        }
    }
}

extension LemonadeStoryList {
    public func setUser(user: LemonadeStoryUser) { self.currentUser = user }
    public func removeCurrentUser() { self.currentUser = nil }
}
extension LemonadeStoryList {
    public func addNewStory(story: LemonadeStoryItem) {
        
    }
    
    public func removeStory(story: LemonadeStoryItem) {
        
    }
    
    public func removeUser(username: String) {
        
    }
}
extension LemonadeStoryList: UICollectionViewDelegate , UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? LemonadeStoryShowcaseCell
        else { return UICollectionViewCell() }
        let user = users[indexPath.row]
        cell.configureUI(username: user.username, image: user.imagePath)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let userStories = stories.filter {
            $0.user.username == user.username
        }
        
        // Sent selected stories to provider
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
