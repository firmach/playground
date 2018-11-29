//
//  SimpleModel.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


struct SimpleModel: CellViewModel {
    
    let line: CGFloat
    
    static func randomModel() -> SimpleModel {
        return SimpleModel(line: CGFloat.random(in: 0.2...1.0))
    }
    
}
