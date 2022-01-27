//
//  SearchViewModel.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 28.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit


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

protocol TableViewActionDelegate: AnyObject {
    func needToReload()
}

class SearchViewModel {
    weak var delegate: TableViewActionDelegate?
    
    deinit {
        delegate = nil
    }
    
    let cellIdentifier: String = UUID().uuidString
    
    private let dummyData : [Film] = [
        Film(name: "Leon", directorName: "Luc Besson", year: 1994),
        Film(name: "The Green Mile", directorName: "Frank Darabont", year: 1999),
        Film(name: "Gisaengchung", directorName: "Bong Joon Ho", year: 2019),
        Film(name: "The Pianist", directorName: "Roman Polanski", year: 2002),
        Film(name: "Back to the Future", directorName: "Robert Zemeckis", year: 1985),
        Film(name: "Psycho", directorName: "Alfred Hitchcock", year: 1960),
    ]
    
    private var dummySearchList: [Film] = []
    
    init() { }
    
    
    func numberOfSections() -> Int { return dummySearchList.isEmpty ? dummyData.count : dummySearchList.count }
    func cellForItem(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchCell else {
             return nil
        }
        let item = dummySearchList.isEmpty ? dummyData[indexPath.row] : dummySearchList[indexPath.row]
        cell.configureUI(film: item)
        return cell
    }
    func search(with text: String) {
        if text.count < 2 {
            if !dummySearchList.isEmpty {
                dummySearchList.removeAll(keepingCapacity: false)
                delegate?.needToReload()
            }
            return
        }
        
        dummySearchList = dummyData.filter { film in
            film.filmName.contains(text) || film.filmDirectorName.contains(text) || film.filmYear == Int(text) ?? 0
        }
        delegate?.needToReload()
    }
}



