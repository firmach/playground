//
//  Section.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


struct Section {
    
    let headerWidth: CGFloat
    let cells: [CellViewModel]
    
    static func randomSection() -> Section {
        var cells: [CellViewModel] = []
        
        for _ in 0..<Int.random(in: 2...10) {
            cells.append(Bool.random() ?
                ComplexModel.randomModel() :
                SimpleModel.randomModel()
            )
        }
        
        return Section(headerWidth: CGFloat.random(in: 0.3...1.0),
                       cells: cells)
    }
    
    static func randomSections() -> [Section] {
        var sections: [Section] = []
        
        for _ in 0..<Int.random(in: 4...10) {
            sections.append(randomSection())
        }
        
        return sections
    }
    
}
