//
//  CustomSegmentControl.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 28.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LemonadeUI

struct Source {
    var sourceId: String
    var title: String
    var publisher: String
    var url: String
    
    init(title: String , publisher: String , url: String) {
        self.sourceId = UUID().uuidString
        self.title = title
        self.publisher = publisher
        self.url = url
    }
}

class CustomSegmentControlViewModel {
    let cellIdentifier: String = UUID().uuidString
    
    weak var delegate: TableViewActionDelegate?
    
    private var currentSegmentIndex: Int = 0
    
    private let dummy_msuic_data: [Source] = [
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
    ]
    
    private let dummy_videos_data: [Source] = [
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
        .init(title: "James", publisher: "Oscar and the Wolf", url: "https://music.youtube.com/search?q=oscar+and+the+wolf+james"),
    ]
    
    func numberOfSections() -> Int { return currentSegmentIndex == 0 ? dummy_msuic_data.count : dummy_videos_data.count }
    func cellForItem(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomSegmentCell else {
             return nil
        }
        let item = currentSegmentIndex == 0 ? dummy_msuic_data[indexPath.row] : dummy_videos_data[indexPath.row]
        cell.configureUI(source: item)
        return cell
    }
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = currentSegmentIndex == 0 ? dummy_msuic_data[indexPath.row] : dummy_videos_data[indexPath.row]
        if let url = URL(string: item.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func changeSegment(index: Int) {
        currentSegmentIndex = index
        delegate?.needToReload()
    }
}

class CustomSegmentControl: UIViewController {
    
    private var viewModel: CustomSegmentControlViewModel!
    
    public init(viewModel: CustomSegmentControlViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(
            CustomSegmentCell.self
            , forCellReuseIdentifier: viewModel.cellIdentifier
        )
        return tableView
    }()
    
    private lazy var segmentControl: LemonadeSegmentControl = {
        let segment_1: LemonadeSegmentItem = .init(frame: .zero, config: .init(segmentText: .init(text: "Musics", font: .systemFont(ofSize: 20)), badgeView: .init(frame: .zero, color: .init(backgroundColor: .blue), radius: .init(radius: 6)), badgeText: .init(text: "1")))
        let segment_2: LemonadeSegmentItem = .init(frame: .zero, config: .init(segmentText: .init(text: "Videos", font: .systemFont(ofSize: 20)), badgeView: .init(frame: .zero, color: .init(backgroundColor: .blue), radius: .init(radius: 6)), badgeText: .init(text: "6")))
        
        let segmentControl: LemonadeSegmentControl = .init(frame: .zero, selectorView: .init(frame: .zero, color: .init(backgroundColor: .systemBlue), radius: .init(radius: 6)), firstIndex: 0, items: [ segment_1 , segment_2 ])
        segmentControl.delegate = self
        segmentControl.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        segmentControl.radius(.init(radius: 8))
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(segmentControl)
        segmentControl.top(view, equalTo: .top, safeArea: true)
        segmentControl.leftAndRight(view , constant: 24)
        segmentControl.height(constant: 60)
        
        view.addSubview(tableView)
        tableView.leftAndRight(view)
        tableView.top(segmentControl, equalTo: .bottom , constant: 10)
        tableView.bottom(view, equalTo: .bottom , safeArea: true)
    }
}
extension CustomSegmentControl: TableViewActionDelegate {
    func needToReload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            UIView.animate(withDuration: 0.5) {
                self?.tableView.isHidden = false
            }
        }
    }
}

extension CustomSegmentControl: LemonadeSegmentControlDelegate {
    func segmentChange(_ segmentControl: LemonadeSegmentControl, _ item: LemonadeSegmentItem, index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.tableView.isHidden = true
        } completion: { [weak self] _ in
            self?.viewModel.changeSegment(index: index)
        }
    }
}
extension CustomSegmentControl: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForItem(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(tableView: tableView, indexPath: indexPath)
    }
}

class CustomSegmentCell: UITableViewCell {
    private lazy var sourceTitleLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 20), alignment: .left))
    }()
    private lazy var sourcePublisherLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 16), alignment: .left))
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    private func configureUI(){
        addSubview(sourceTitleLabel)
        addSubview(sourcePublisherLabel)
        
        sourceTitleLabel.leftAndRight(self , constant: 24)
        sourceTitleLabel.top(self, equalTo: .top , constant: 20)
        
        sourcePublisherLabel.leftAndRight(self , constant: 24)
        sourcePublisherLabel.top(sourceTitleLabel, equalTo: .bottom, constant: 5)
        sourcePublisherLabel.bottom(self, equalTo: .bottom , constant: -20)
    }
    
    func configureUI(source: Source) {
        sourceTitleLabel.text = source.title
        sourcePublisherLabel.text = source.publisher
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
