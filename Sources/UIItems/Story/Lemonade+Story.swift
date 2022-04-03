//
//  Lemonade+Story.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 27.02.2022.
//

import Foundation

public class LemonadeStory: UICollectionView {

    private var storyDataSource: LemonadeStoryDataSource?
    
    public convenience init(frame: CGRect
                            , collectionViewLayout layout: UICollectionViewLayout
                            , config: LemonadeStoryConfig
                            ,stories: [LemonadeStoryData] = []) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .init(width: 100, height: 100)
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        self.init(frame: frame, collectionViewLayout: flowLayout)
       // configure(config: config, stories: stories)
        configureUI()
    }
    
    private func configureUI(){
        backgroundColor = .clear
        guard let storyDataSource = storyDataSource else {
            return
        }
        self.delegate = storyDataSource
        self.dataSource = storyDataSource
    }
    
    public func configure(config: LemonadeStoryConfig
                          , stories: [[LemonadeStoryData]] = []) {
        storyDataSource = LemonadeStoryDataSource(collectionView: self)
        storyDataSource?.configuration(config: config)
     //   storyDataSource?.reloadData(stories: stories)
    }
    
    /// CRUD
    public func addStories(stories: [LemonadeStoryData], at: Int? = nil) {
        storyDataSource?.addStories(stories: stories, at: at)
    }
    public func removeUserStories(userId: String) {
        storyDataSource?.removeStories(userId: userId)
    }
}

class LemonadeStoryDataSource: NSObject , UICollectionViewDelegate , UICollectionViewDataSource {
    
    public func addStories(stories: [LemonadeStoryData], at: Int? = nil) {
        if stories.isEmpty { return }
        if let index = at { self.stories.insert(stories, at: index)
        }else { self.stories.append(stories) }
        reloadData()
    }
    
    func removeStories(userId: String) {
        guard !stories.isEmpty else { return }
        var foundedIndex: Int = -1
        stories.enumerated().forEach { (index,currentStories) in
            let condition = currentStories.contains(where: {$0.user.userId == userId })
            if condition { foundedIndex = index }
        }
        if foundedIndex != -1 {
            stories.remove(at: foundedIndex)
        }
        reloadData()
    }
    
    var didSelect: (()->())?
    
    func configuration(config: LemonadeStoryConfig) { self.configuration = config }
    
    func reloadData(stories: [LemonadeStoryData]? = nil) {
        if let stories = stories { convertStories(stories) }
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    
    private let cellIdentifier: String = UUID().uuidString
    
    private var stories: [[LemonadeStoryData]] = []
    
    private var configuration: LemonadeStoryConfig?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    private var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.register(LemonadeStoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? LemonadeStoryCell else {
            fatalError()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    private func convertStories( _ stories: [LemonadeStoryData]) {
        // user'ın id'sine göre stories'ler ayrılacak
        // ilk olarak unique olan user'ları bul
        // çıkar user'id leri for ile dön
            // her bir userId 'yi stories 'ed ara buldukarlını bir array'ye doldur sonra
            // bu array'yi 2d array'ye doldur
        // 2d'yi self.stories = yap
    }
}
