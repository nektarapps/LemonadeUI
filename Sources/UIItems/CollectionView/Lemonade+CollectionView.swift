//
//  Lemonade+CollectionView.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 3.09.2021.
//

import Foundation

public class LemonadeCollectionView : UICollectionView {
    
    weak var lemonadeDelegate : LemonadeCollectionViewDelegate?
    
    public var dynamicHeightMode : Bool = false
    
    public func dynamicReload<W : LemonadeWrapContent>( _ data : [W]){
        let condition = dynamicHeightMode == true && !data.isEmpty
        if condition {
            self.calculateMaxHeight(data)
        }
        self.reloadData()
    }
}
extension LemonadeCollectionView {
    private func calculateMaxHeight< W : LemonadeWrapContent>( _ data : [W]) {
        var maxHeight : CGFloat = 0.0
        for item in data {
            let height = item.calcualation()
            if maxHeight < height {
                maxHeight = height
            }
        }
        lemonadeDelegate?.maximumCellHeight(maxHeight)
    }
}


extension LemonadeCollectionView : UICollectionViewDelegate {
    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return lemonadeDelegate?.cell(self, at: indexPath.row) ?? LemonadeCell.init()
    }
}





public protocol LemonadeCollectionViewDelegate : AnyObject {
    func cell( _ collectionView : LemonadeCollectionView , at index : Int) -> LemonadeCell?
    func maximumCellHeight( _ height : CGFloat)
}
