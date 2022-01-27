//
//  PlaygroundVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 24.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class PlaygroundVC: UIViewController {
    private let viewModel: PlaygroundViewModel = .init()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(PlaygroundHeaderView.self, forHeaderFooterViewReuseIdentifier: viewModel.headerViewIdentifier)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: viewModel.buttonCellIdentifier)
        tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: viewModel.sliderCellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.fill2SuperView()
    }
}
extension PlaygroundVC: UITableViewDataSource,  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(section: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = viewModel.cellForItem(tableView: tableView, indexPath: indexPath) { return cell }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelect(indexPath: indexPath, self)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.headerForItem(tableView: tableView, section: section)
    }
}
