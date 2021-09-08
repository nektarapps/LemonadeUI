//
//  Lemonade+Segment+Control+Protocol.swift
//  LemonadeUI
//
//  Created by Mac on 8.09.2021.
//




public protocol LemonadeSegmentControlDelegate : AnyObject {
    func segmentChange( _ segmentControl : LemonadeSegmentControl , _ item : LemonadeSegmentItem , index : Int)
}
