//
//  ComplexCell.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


class ComplexCell: UITableViewCell, TableViewPositionedView {
    
    // MARK: Outlets

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var lineViews: [HatchedView]!

    
    // MARK: -
    // MARK: Properties

    private var currentWidthConstraints: [NSLayoutConstraint] = []
    
    
    // MARK: -
    // MARK: Helpers

    func configure(for lines: [CGFloat]) {
        currentWidthConstraints.forEach { stackView.removeConstraint($0) }
        
        var newConstraints = [NSLayoutConstraint]()
        for i in 0..<lines.count  {
            let lineView = lineViews[i]
            lineView.alpha = 1.0
            newConstraints.append(lineView.widthAnchor
                .constraint(equalTo: stackView.widthAnchor, multiplier: lines[i]))
        }
        NSLayoutConstraint.activate(newConstraints)
        currentWidthConstraints = newConstraints
        
        lineViews.dropFirst(lines.count).forEach { $0.alpha = 0 }
    }
    
}
