//
//  SearchVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 27.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class SearchVC: UIViewController {
    
    private var viewModel: SearchViewModel!
    
    public init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchBar: LemonadeSearchBar = {
        let config: LemonadeSearchBarConfig
        if #available(iOS 13.0, *) {
            config = .init(leftImage: UIImage(systemName: "magnifyingglass.circle.fill"), rigthImage: nil)
        } else {
            config = .init(leftView: .init(frame: .init(x: 0, y: 0, width: 20, height: 20))
                                                        , leftImage: nil, rigthImage: nil)
        }
        let searchBar = LemonadeSearchBar(frame: .zero, text: .init(text: "", color: .white, font: .systemFont(ofSize: 20), alignment: .left)
                                          , placeholder: .init(text: "Search Film", color: .white.withAlphaComponent(0.6), font: .systemFont(ofSize: 20), alignment: .left)
                                          , config: config)
        searchBar.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        searchBar.radius(.init(radius: 6))
        searchBar.border(.init(borderColor: .systemBlue, width: 4.0))
        searchBar.lemonadeSearchBarDelegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(
            SearchCell.self
            , forCellReuseIdentifier: viewModel.cellIdentifier
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        searchBar.top(view, equalTo: .top , constant: 10, safeArea: true)
        searchBar.leftAndRight(view , constant: 24)
        searchBar.height(constant: 50)
        
        view.addSubview(tableView)
        tableView.leftAndRight(view)
        tableView.top(searchBar, equalTo: .bottom , constant: 10)
        tableView.bottom(view, equalTo: .bottom , safeArea: true)
        
    }
}
extension SearchVC: SearchViewModelProtocol {
    func needToReload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SearchVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForItem(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension SearchVC: LemonadeSearchBarDelegate {
    func searchBarDidChange(_ searchBar: LemonadeSearchBar, text: String) {
        viewModel.search(with: text)
    }
    
    func searchButtonTapped(_ searchBar: LemonadeSearchBar, text: String) {
        viewModel.search(with: text)
    }
    
    func searchingStateChanged(_ searchBar: LemonadeSearchBar, state: LemonadeSearchState) {
        //
    }
    
    func buttonsTapped(_ searchBar: LemonadeSearchBar, button: LemonadeButton) {
        //
    }
}
