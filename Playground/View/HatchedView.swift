//
//  HatchedView.swift
//
//  Created by Roman Churkin on 26/11/2018.
//

import UIKit


@IBDesignable
class HatchedView: UIView {
    
    // MARK: Outlets
    
    @IBInspectable var lineWidth: CGFloat = 4
    @IBInspectable var lineGap: CGFloat = 6
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.blue
    
    
    // MARK: -
    // MARK: UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentMode = .redraw
    }
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.size.width
        let height = rect.size.height
        
        let cap = lineWidth / 2
        let step: CGFloat = lineGap + lineWidth*2
        let maxX = width - cap
        let maxY = height - cap
        
        
        let gradient = Gradient(startColor: self.startColor,
                                endColor: self.endColor)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(lineWidth)
        context.setLineCap(.round)
        
        func drawLine(from: CGPoint, to: CGPoint) {
            context.move(to: from)
            context.addLine(to: to)

            let midX = from.x + (to.x - from.x) / 2
            let progress = midX / width
            context.setStrokeColor(gradient.color(for: progress).cgColor)

            context.strokePath()
        }
        
        var currentStep = step
        while cap + currentStep < height {
            drawLine(from: CGPoint(x: cap, y: cap + currentStep),
                     to: CGPoint(x: maxY - currentStep, y: maxY))
            currentStep += step
        }
        
        currentStep = 0
        while maxY + currentStep < width {
            drawLine(from: CGPoint(x: cap + currentStep, y: cap),
                     to: CGPoint(x: maxY + currentStep, y: maxY))
            currentStep += step
        }
        
        let startPoint = currentStep
        currentStep = 0
        while cap + currentStep + startPoint < width {
            drawLine(from: CGPoint(x: cap + currentStep + startPoint, y: cap),
                     to: CGPoint(x: maxX, y: maxX  - startPoint - currentStep))
            currentStep += step
        }
    }
    
}



private struct Gradient {
    
   private struct ColorRGB {
        
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        
        init(_ color: UIColor) {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }
    }
    
    private let startColor: ColorRGB
    private let endColor: ColorRGB
    
    init(startColor: UIColor, endColor: UIColor) {
        self.startColor = ColorRGB(startColor)
        self.endColor = ColorRGB(endColor)
    }
    
    func color(for progress: CGFloat) -> UIColor {
        let red   = startColor.red   + progress * (endColor.red   - startColor.red  )
        let green = startColor.green + progress * (endColor.green - startColor.green)
        let blue  = startColor.blue  + progress * (endColor.blue  - startColor.blue )
        
        return UIColor(red:   red,
                       green: green,
                       blue:  blue,
                       alpha: min(startColor.alpha, endColor.alpha))
    }
    
}
