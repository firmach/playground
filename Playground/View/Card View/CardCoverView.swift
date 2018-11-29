//
//  CardCoverView.swift
//
//  Created by Roman Churkin on 23/11/2018.
//

import UIKit


class CardCoverView: UIView {
    
    // MARK: UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    // MARK: -
    // MARK: Helpers
    
    private func configure() {
        layer.cornerRadius = CardViewConstants.cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
