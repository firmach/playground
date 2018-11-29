//
//  CardView.swift
//
//  Created by Roman Churkin on 23/11/2018.
//

import UIKit


class CardView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet private var innerView: CardInnerView!
    @IBOutlet private var coverView: CardCoverView! {
        willSet { configureLayerForRotation(newValue.layer) }
    }
    @IBOutlet private var coverBackView: CardInnerView! {
        willSet { configureLayerForRotation(newValue.layer) }
    }
    
    
    // MARK: Properties
    
    var progress: Float = 0 {
        didSet { updateRotate(progress: progress) }
    }
    
    
    // MARK: -
    // MARK: UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureShadow()
    }
    
    
    // MARK: -
    // MARK: Helpers
    
    private func configureLayerForRotation(_ layer: CALayer) {
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 18
        layer.shadowOpacity = 0.6
    }
    
    private func updateRotate(progress: Float) {
        let progress = max(0, progress)
        
        let shadowProgress = 1 - progress
        innerView.shadowOpacity = shadowProgress
        coverBackView.shadowOpacity = shadowProgress
        
        coverView.isHidden = progress >= 0.5
        coverBackView.isHidden = progress < 0.5
        
        let angle = .pi * progress
        let transform = calculateTransform(for: angle)
        coverView.layer.transform = transform
        coverBackView.layer.transform = transform
    }
    
    private func calculateTransform(for angle: Float) -> CATransform3D {
        var allTransofrom = CATransform3DIdentity
        let rotateTransform = CATransform3DMakeRotation(CGFloat(angle), -1, 0, 0)
        allTransofrom = CATransform3DConcat(allTransofrom, rotateTransform)
        allTransofrom = transformWithDepth(from: allTransofrom)
        
        return allTransofrom
    }
    
    private func transformWithDepth(from transform: CATransform3D) -> CATransform3D {
        var depth = CATransform3DIdentity
        depth.m34 = 2.5 / -2000
        return CATransform3DConcat(transform, depth)
    }
    
}


