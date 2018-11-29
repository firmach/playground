//
//  CardInnerView.swift
//
//  Created by Roman Churkin on 23/11/2018.
//

import UIKit


class CardInnerView: UIView {
    
    // MARK: Properties
    
    private var shadow: CAGradientLayer!
    var shadowOpacity: Float {
        get { return shadow.opacity }
        set { shadow.opacity = newValue }
    }
    
    
    // MARK: -
    // MARK: UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadow.frame = bounds
    }
    
    
    // MARK: -
    // MARK: Helpers
    
    private func configure() {
        layer.cornerRadius = CardViewConstants.cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        shadow = CAGradientLayer()
        shadow.colors = [UIColor.clear.cgColor,
                         UIColor.black.withAlphaComponent(0.6).cgColor]
        layer.addSublayer(shadow)
    }
    
}


