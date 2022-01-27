//
//  SearchCell.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 28.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI

class SearchCell: UITableViewCell {
    private lazy var filmNameTitleLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 20), alignment: .left))
    }()
    private lazy var filmDirectorNameLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 16), alignment: .left))
    }()
    private lazy var filmYearLabel: LemonadeLabel = {
        return .init(frame: .zero, .init(text: "", color: .black, font: .systemFont(ofSize: 16), alignment: .left))
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
        filmNameTitleLabel.top(self, equalTo: .top , constant: 20)
        
        filmDirectorNameLabel.leftAndRight(self , constant: 24)
        filmDirectorNameLabel.top(filmNameTitleLabel, equalTo: .bottom, constant: 5)
        
        filmYearLabel.leftAndRight(self , constant: 24)
        filmYearLabel.top(filmDirectorNameLabel, equalTo: .bottom, constant: 5)
        filmYearLabel.bottom(self, equalTo: .bottom, constant: -20)
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
