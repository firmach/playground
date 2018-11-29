//
//  SimpleCell.swift
//
//  Created by Roman Churkin on 23/11/2018.
//

import UIKit


class SimpleCell: UITableViewCell, TableViewPositionedView {
    
    // MARK: Outlets
    
    @IBOutlet var hatchedView: HatchedView!
    @IBOutlet var leading: NSLayoutConstraint!
    @IBOutlet var width: NSLayoutConstraint!

    
    // MARK: -
    // MARK: Helpers
    
    func configure(for width: CGFloat, max: CGFloat) {
        self.width.constant = (max - 16 * 2) * width
    }
    
}
