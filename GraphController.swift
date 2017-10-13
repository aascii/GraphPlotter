//
//  GraphController.swift
//  GraphPlotter
//
//  Created by jason hayes on 10/11/17.
//  Copyright © 2017 jason hayes. All rights reserved.
//

import UIKit

// Controls the graph view
class GraphController: UIViewController {
    
// these values supplied only for test purposes and should be deleted
    let mathFunction: ((CGFloat) -> Double) = { tan(Double($0)) }
    let functionString: String? = "tan(M)"
    
    @IBOutlet weak var graphPlot: GraphView!
    @IBOutlet weak var functionLabel: UILabel!
    
    private var graphFunction: ((CGFloat) -> Double)? {
        get {
            return graphPlot.function
        }
        set {
            graphPlot.function = newValue
        }
    }
    
    @IBAction func plot(_ sender: UIButton) {
        graphFunction = mathFunction
        functionLabel.text = functionString
    }
}
