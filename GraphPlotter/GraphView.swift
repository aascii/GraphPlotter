//
//  GraphView.swift
//  GraphPlotter
//
//  Created by jason hayes on 10/10/17.
//  Copyright © 2017 jason hayes. All rights reserved.
//

import UIKit

// Generic class to graph plot a mathematical f(x);
// function is specified as a closure property which takes a CGFloat (x-axis) and returns a Double (y-axis);
// also displays a String ith the mathematical function
@IBDesignable
class GraphView: UIView {
    
    @IBInspectable
    private var axesPointsPerUnit: CGFloat = 50 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    private var plotColor: UIColor = UIColor.red {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    private var minimumPointsPerHashmark: CGFloat = 40
    
    @IBInspectable
    var userOrigin: CGPoint? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var boundsOrigin: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var axes: AxesDrawer = AxesDrawer()
    
    var function: ((CGFloat) -> Double)? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var text: String?
    
    override func draw(_ rect: CGRect) {
        axes.minimumPointsPerHashmark = minimumPointsPerHashmark
        axes.contentScaleFactor = self.contentScaleFactor
        let pixelsPerUnit = CGFloat(self.contentScaleFactor) * axesPointsPerUnit
        var origin: CGPoint?
        var centerOffset: CGPoint {
            if let originOffset = origin {
                return CGPoint(x: originOffset.x - boundsOrigin.x,
                               y: originOffset.y - boundsOrigin.y)
            } else {
                return CGPoint(x: 0, y: 0)
            }
        }
        
        func convertCoords(for axesCoords: CGPoint) -> CGPoint {
            return CGPoint(x: axesCoords.x + bounds.midX + centerOffset.x,
                           y: (bounds.midY - axesCoords.y * axesPointsPerUnit) + centerOffset.y)
        }

        // value supplied only for test purposes and should be deleted
        userOrigin = CGPoint(x: bounds.minX + 50, y: bounds.minY + 75)
        
        // when this MVC is moved into an application, the user should be able to set
        // their own origin point
        if let originChoice = userOrigin {
            origin = originChoice
        } else {
            origin = boundsOrigin
        }
        
        axes.drawAxes(in: rect, origin: origin!, pointsPerUnit: axesPointsPerUnit)
        
        plotColor.set()
        let plotPath = UIBezierPath()
        
        
        if function != nil {
            
            var lastValid = false
            // now need to iterate 'x' values over bounds.minX...bounds.maxX
            // passed in a closure that takes a CGFloat and returns a Double
            for pointX in Int(0 - rect.midX)..<Int(rect.maxX) {
                let yValue = CGFloat(function!(CGFloat(pointX) / axesPointsPerUnit))
                if (yValue.isNormal && abs(yValue * axesPointsPerUnit) <= rect.maxY) || yValue.isZero {
                    if lastValid {
                        plotPath.addLine(to: convertCoords(for: CGPoint(x: CGFloat(pointX),
                                                                        y: yValue)))
                        plotPath.stroke()
                    } else {
                        plotPath.move(to: convertCoords(for: CGPoint(x: CGFloat(pointX),
                                                                     y: yValue)))
                        lastValid = true
                    }
                } else {
                    plotPath.move(to: convertCoords(for: CGPoint(x: CGFloat(pointX),
                                                                 y: yValue)))
                    lastValid = false
                }
            }
        }
    }
    
}

