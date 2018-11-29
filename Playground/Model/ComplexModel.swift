//
//  ComplexModel.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


struct ComplexModel: CellViewModel {
    
    let lines: [CGFloat]
    
    static func randomModel() -> ComplexModel {
        var lines = [CGFloat]()
        for _ in 0..<Int.random(in: 2...4) {
            lines.append(CGFloat.random(in: 0.2...1.0))
        }
        
        return ComplexModel(lines: lines)
    }
    
}
