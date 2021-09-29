//
//  Lemonade+Line+Chart.swift
//  LemonadeUI
//
//  Created by Hasan Özgür Elmaslı on 29.09.2021.
//

import UIKit



public class LemonadeLineChart : UIView {
    
    private var config : LemonadeLineChartConfig?
    
    private var isDraw : Bool = false
    
    private var marginX : CGFloat = 0.0
    private var marginY : CGFloat = 0.0
    
    public convenience init(frame : CGRect , _ config : LemonadeLineChartConfig) {
        self.init(frame: frame)
        self.config = config
    }
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isDraw {
            drawXandYAxis()
            drawChart()
            
            isDraw = true
        }
        
    }
    
    deinit {
        config = nil
    }
}



extension LemonadeLineChart {
    private func drawXandYAxis(){
        guard let config = config else { return }
        let xPath = UIBezierPath()
        xPath.move(to: .init(x: 5, y: bounds.height - 10))
        xPath.addLine(to: .init(x: bounds.width - 10, y: bounds.height - 10))
        
        let xAxisLayer = CAShapeLayer()
        xAxisLayer.path = xPath.cgPath
        xAxisLayer.strokeColor = config.color.cgColor
        xAxisLayer.lineWidth = 3.0
        
        self.layer.addSublayer(xAxisLayer)
        
        
        let yPath = UIBezierPath()
        yPath.move(to: .init(x: 5, y: bounds.height - 10))
        yPath.addLine(to: .init(x: 5, y: 5))
        
        let yAxisLayer = CAShapeLayer()
        yAxisLayer.path = yPath.cgPath
        yAxisLayer.strokeColor = config.color.cgColor
        yAxisLayer.lineWidth = 3.0
        
        self.layer.addSublayer(yAxisLayer)
        
        
        marginX = bounds.width / CGFloat(config.items.count - 1)
        marginY = bounds.height / CGFloat(config.items.count - 1)
    }
    
    private func drawChart(){
        guard let config = config else { return }
        let line = UIBezierPath()
        line.move(to: .init(x: calculateXPoint(1), y: calculateYPoint(1)))
        line.addLine(to: .init(x: calculateXPoint(2), y: calculateYPoint(2)))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = line.cgPath
        lineLayer.strokeColor = config.color.cgColor
        lineLayer.lineWidth = 3.0
        
        self.layer.addSublayer(lineLayer)
    }
}

extension LemonadeLineChart {
    private func calculateXPoint( _ index : Int) -> CGFloat {
        return (marginX * CGFloat(index)) + 5.0
    }
    private func calculateYPoint( _ index : Int) -> CGFloat {
        return (bounds.height - 10) - ( marginY * CGFloat(index))
    }
}
