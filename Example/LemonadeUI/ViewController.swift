//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//
import LemonadeUI

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterButton = LemonadeButton.init(frame: .zero, .init(text: "Filter" , color: .white))
        filterButton.color(.init(backgroundColor: .systemYellow.withAlphaComponent(0.3)))
        filterButton.radius(.init(radius: 8))
        filterButton.border(.init(borderColor: .brown.withAlphaComponent(0.3), width: 1.0))
        
        let otherfilterButton = LemonadeButton.init(frame: .zero, .init(text: "Other Filter" , color: .white))
        otherfilterButton.color(.init(backgroundColor: .systemYellow.withAlphaComponent(0.3)))
        otherfilterButton.radius(.init(radius: 8))
        otherfilterButton.border(.init(borderColor: .brown.withAlphaComponent(0.3), width: 1.0))
        
        let config = LemonadeSearchBarConfig.init(leftImage: nil, rigthImage: nil , buttons: [
            filterButton , otherfilterButton
        ] , position: .right)
        let searchBar : LemonadeSearchBar = .init(frame: .zero
                                                  , text: .init(text: "" , color: .black , alignment: .left)
                                                  , placeholder: .init(text: "Aramaya başla" , color: .black)
                                                  , config: config)
        searchBar.spaceBetweenButtons = 20
        view.addSubview(searchBar)
        searchBar.center(to: view, width: .screenWidth(24), height: 75)
        searchBar.color(.init(backgroundColor: .systemBlue.withAlphaComponent(0.5)))
        searchBar.radius(.init(radius: 12))
        searchBar.border(.init(borderColor: .red.withAlphaComponent(0.3), width: 2.0))
        searchBar.searchBarTextfield.color(.init(backgroundColor: .red.withAlphaComponent(0.2)))
        searchBar.lemonadeSearchBarDelegate = self
        
    }
    
}
extension ViewController : LemonadeSearchBarDelegate {
    func searchBarDidChange(_ searchBar: LemonadeSearchBar, text: String) {
        print(text)
    }
    
    func searchButtonTapped(_ searchBar: LemonadeSearchBar, text: String) {
        print(text)
    }
    
    func searchingStateChanged(_ searchBar: LemonadeSearchBar, state: LemonadeSearchState) {
        print(state)
    }
    
    func buttonsTapped(_ searchBar: LemonadeSearchBar, button: LemonadeButton) {
        print(button)
    }
    
    
}
