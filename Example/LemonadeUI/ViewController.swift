//
//  ViewController.swift
//  LemonadeUI
//
//  Created by Hasan Ozgur Elmasli on 08/11/2021.
//  Copyright (c) 2021 Hasan Ozgur Elmasli. All rights reserved.
//
import LemonadeUI

class ViewController: UIViewController {
    
    private lazy var items : [LemonadeSegmentItem] = {
        let item : LemonadeSegmentItem = LemonadeSegmentItem.init(frame:.zero , config : .init(segmentText: .init(text: "Container", color: .black, font: .systemFont(ofSize: 12)), badgeView: .init(frame: .zero, color: .init(backgroundColor: .systemOrange) , radius: .init(radius: 8)), badgeText: .init(text: "1")))
        
        let item_2 : LemonadeSegmentItem = LemonadeSegmentItem.init(frame:.zero , config : .init(segmentText: .init(text: "Container_2", color: .black, font: .systemFont(ofSize: 12)), badgeView: .init(frame: .zero, color: .init(backgroundColor: .systemGreen) , radius: .init(radius: 8)), badgeText: .init(text: "2")))
        
        let item_3 : LemonadeSegmentItem = LemonadeSegmentItem.init(frame:.zero , config : .init(segmentText: .init(text: "Container", color: .black, font: .systemFont(ofSize: 12)), badgeView: .init(frame: .zero, color: .init(backgroundColor: .systemBlue) , radius: .init(radius: 8)), badgeText: .init(text: "3")))
       return [item , item_2 , item_3]
    }()
    
    private lazy var segmentControl : LemonadeSegmentControl = {
        let segment : LemonadeSegmentControl = .init(frame: .zero , selectorView: .init(frame: .zero, color: .init(backgroundColor: .systemOrange), radius: .init(radius: 12)) , items: items)
        segment.color(.init(backgroundColor: .systemPink))
        segment.radius(.init(radius: 12))
        segment.delegate = self
        return segment
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(segmentControl)
        segmentControl.center(to: self.view, width: .screenWidth(12), height: 80)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.segmentControl.change(index: 2)
        }
    }
}

extension ViewController : LemonadeSegmentControlDelegate {
    func segmentChange(_ segmentControl: LemonadeSegmentControl, _ item: LemonadeSegmentItem, index: Int) {
        print(segmentControl)
        print(item)
        print(index)
    }
}
