//
//  HeaderView.swift
//
//  Created by Roman Churkin on 25/11/2018.
//

import UIKit


class HeaderView: UIView, TableViewPositionedView {
    
    // MARK: Outlets

    @IBOutlet var hatchedView: HatchedView!
    @IBOutlet var leading: NSLayoutConstraint!
    @IBOutlet var width: NSLayoutConstraint!
    
    
    // MARK: -
    // MARK: Helpers

    func configure(for width: CGFloat, max: CGFloat) {
        self.width.constant = (max - leading.constant * 2) * width
    }
    
}
