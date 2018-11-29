//
//  TableViewPositionedView.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


enum PositionInTableView {

    case top, middle, bottom

}


protocol TableViewPositionedView {
    
    func update(for position: PositionInTableView)
    
}


extension TableViewPositionedView where Self: UIView {
    
    func update(for position: PositionInTableView) {
        layer.cornerRadius = 16
        
        switch position {
        case .top: layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .middle:  layer.maskedCorners = []
        case .bottom:  layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
}
