//
//  SearchVC.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 27.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

struct Film {
    var filmId: String
    var filmName: String
    var filmDirectorName: String
    var filmYear:Int

    init(name: String , directorName: String , year: Int) {
        self.filmId = UUID().uuidString
        self.filmName = name
        self.filmDirectorName = directorName
        self.filmYear = year
    }
}

class SearchViewModel {
    let cellIdentifier: String = UUID().uuidString
    
    private let dummy_data : [Film] = [
        Film(name: "Léon", directorName: "Luc Besson", year: 1994),
        Film(name: "The Green Mile", directorName: "Frank Darabont", year: 1999),
        Film(name: "Gisaengchung", directorName: "Bong Joon Ho", year: 2019),
        Film(name: "The Pianist", directorName: "Roman Polanski", year: 2002),
        Film(name: "Back to the Future", directorName: "Robert Zemeckis", year: 1985),
        Film(name: "Psycho", directorName: "Alfred Hitchcock", year: 1960),
    ]
    init() { }
    
    
    func numberOfSections() -> Int { return dummy_data.count }
    func cellForItem(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchCell else {
             return nil
        }
        cell.configureUI(film: dummy_data[indexPath.row])
        return cell
    }
    
}





class SearchVC: UIViewController {
    private lazy var searchBar: LemonadeSearchBar = {
        let config: LemonadeSearchBarConfig = .init(leftView: .init(frame: .init(x: 0, y: 0, width: 20, height: 20))
                                                    , leftImage: nil, rigthImage: nil)
        let searchBar = LemonadeSearchBar(frame: .zero, text: .init(text: "", color: .white, font: .systemFont(ofSize: 20), alignment: .left)
                                          , placeholder: .init(text: "Search Film", color: .white.withAlphaComponent(0.6), font: .systemFont(ofSize: 20), alignment: .left)
                                          , config: config)
        searchBar.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        searchBar.radius(.init(radius: 12))
        searchBar.border(.init(borderColor: .black.withAlphaComponent(0.5), width: 2.0))
        searchBar.lemonadeSearchBarDelegate = self
        return searchBar
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
    }
}
extension SearchVC: LemonadeSearchBarDelegate {
    func searchBarDidChange(_ searchBar: LemonadeSearchBar, text: String) {
        
    }
    
    func searchButtonTapped(_ searchBar: LemonadeSearchBar, text: String) {
        
    }
    
    func searchingStateChanged(_ searchBar: LemonadeSearchBar, state: LemonadeSearchState) {
        
    }
    
    func buttonsTapped(_ searchBar: LemonadeSearchBar, button: LemonadeButton) {
        
    }
}


class SearchCell: UITableViewCell {
    private lazy var filmNameTitleLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 20), alignment: .left, kern: 2.0))
    }()
    private lazy var filmDirectorNameLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 16), alignment: .left, kern: 2.0))
    }()
    private lazy var filmYearLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 16), alignment: .left, kern: 2.0))
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    private func configureUI(){
        addSubview(filmNameTitleLabel)
        addSubview(filmDirectorNameLabel)
        addSubview(filmYearLabel)
        
        filmNameTitleLabel.leftAndRight(self , constant: 24)
        filmNameTitleLabel.top(self, equalTo: .top)
        
        filmDirectorNameLabel.leftAndRight(self , constant: 24)
        filmDirectorNameLabel.top(filmNameTitleLabel, equalTo: .bottom, constant: 5)
        
        filmYearLabel.leftAndRight(self , constant: 24)
        filmYearLabel.top(filmDirectorNameLabel, equalTo: .bottom, constant: 5)
    }
    
    func configureUI(film: Film) {
        filmNameTitleLabel.text = film.filmName
        filmDirectorNameLabel.text = film.filmDirectorName
        filmYearLabel.text = "\(film.filmYear)"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
