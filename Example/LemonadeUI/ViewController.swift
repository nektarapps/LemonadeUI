//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//

import UIKit
import LemonadeUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView : LemonadeScrollView = .init(frame: .zero, add: view)
        let v : UIView = .init(frame: .zero, color: .init(backgroundColor: .red))
        scrollView.contentView?.addSubview(v)
        let height = UIScreen.main.bounds.width * (4 / 3)
        
        v.width(constant: .screenWidth())
        let heightAnchor = v.heightAnchor.constraint(equalToConstant: height)
        heightAnchor.isActive = true
        v.top(scrollView.contentView!, equalTo: .top)
        
        let topAnchor = v.topAnchor.constraint(equalTo: scrollView.contentView!.topAnchor)
        topAnchor.isActive = true

        let v2 : UIView = .init(frame: .zero, color: .init(backgroundColor: .orange))
        scrollView.contentView?.addSubview(v2)
        
        v2.width(constant: .screenWidth())
        v2.height(constant: height * 2)
        v2.top(v, equalTo: .bottom)
        scrollView.addLastItem(v2)
        
        let streching = LemonadeStreching.init(height, topAnchor: topAnchor, heightAnchor: heightAnchor)
        scrollView.addStreching(streching)
    }
    
}
