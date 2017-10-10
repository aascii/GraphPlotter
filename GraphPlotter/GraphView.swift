//
//  GraphView.swift
//  GraphPlotter
//
//  Created by jason hayes on 10/10/17.
//  Copyright © 2017 jason hayes. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    @IBInspectable
    private var axisScale: CGFloat = 50
    
    private var origin: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var axes: AxesDrawer = AxesDrawer()
    
    override func draw(_ rect: CGRect) {
        // axis drawing probably moves to controller
        axes.drawAxes(in: rect, origin: origin, pointsPerUnit: axisScale)
        
        // now need to iterate M values over bounds.minX...bounds.maxX
        
    }

}
