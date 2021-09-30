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
    
    public convenience init(frame : CGRect , _ config : LemonadeLineChartConfig) {
        self.init(frame: frame)
        self.config = config
    }
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isDraw {
            drawXandYAxis()
            drawChart()
            drawLabelXAxis()
            drawLabelYAxis()
            
            isDraw = true
        }
        
    }
    
    internal var max : CGFloat {
        return config?.items.map{$0.value}.max() ?? 0.0
    }
    internal var min : CGFloat {
        return config?.items.map{$0.value}.min() ?? 0.0
    }
    internal lazy var orderedItems : [LemonadeChartItem] = {
        return config!.items.sorted(by: { $0.value < $1.value })
    }()
    internal var marginX : CGFloat {
        if config == nil { return 0.0 }
        return bounds.width / CGFloat(config!.items.count)
    }
    internal var marginY : CGFloat {
        if config == nil { return 0.0 }
        return bounds.height / CGFloat(config!.items.count)
    }
    
    
    
    deinit {
        config = nil
    }
}



extension LemonadeLineChart {
    private func drawXandYAxis(){
        guard let config = config else { return }
        let xPath = UIBezierPath()
        xPath.move(to: .init(x: 30, y: bounds.height - 30))
        xPath.addLine(to: .init(x: bounds.width, y: bounds.height - 30))
        
        let xAxisLayer = CAShapeLayer()
        xAxisLayer.path = xPath.cgPath
        xAxisLayer.strokeColor = config.color.cgColor
        xAxisLayer.lineWidth = 3.0
        
        self.layer.addSublayer(xAxisLayer)
        
        
        let yPath = UIBezierPath()
        yPath.move(to: .init(x: 30, y: bounds.height - 30))
        yPath.addLine(to: .init(x: 30, y: 0))
        
        let yAxisLayer = CAShapeLayer()
        yAxisLayer.path = yPath.cgPath
        yAxisLayer.strokeColor = config.color.cgColor
        yAxisLayer.lineWidth = 3.0
        
        self.layer.addSublayer(yAxisLayer)
    }
    
    private func drawChart(){
        guard let config = config else { return }
        
        for (index , item) in config.items.enumerated() {
            let line = UIBezierPath()
            let prevValue = config.items[index].value
            
            let nextIndex = index + 1 > config.items.count - 1 ? index : index + 1
            let nextValue = config.items[nextIndex].value
            
            let movePoint = CGPoint.init(x: calculateXPoint(index), y: calculateYPoint(prevValue))
            let lineLastPoint = CGPoint.init(x: calculateXPoint( nextIndex), y: calculateYPoint(nextValue))
            line.move(to: movePoint)
            line.addLine(to: lineLastPoint)
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = line.cgPath
            lineLayer.strokeColor = item.color.cgColor
            lineLayer.lineWidth = item.lineWidth
            self.layer.addSublayer(lineLayer)
        }
    }
    private func drawLabelXAxis(){
        guard let config = config else { return }
        for (index , item ) in config.items.enumerated() {
            let label : LemonadeLabel = .init(frame: .zero, item.XAxisText ?? LemonadeText(text: "\(item.value)" , color: .black))
            addSubview(label)
            label.frame = .init(x: marginX * CGFloat(index) , y: bounds.height - 15, width: 40, height: 20)
        }
    }
    private func drawLabelYAxis(){
        guard let config = config else { return }
        for (index , item ) in config.items.enumerated() {
            let label : LemonadeLabel = .init(frame: .zero, item.YAxisText ?? LemonadeText(text: "\(item.value)" , color: .black))
            addSubview(label)
            label.frame = .init(x: 0 , y: calculateYPoint(config.items[index].value) - 20, width: 30, height: 40)
        }
    }
}

extension LemonadeLineChart {
    private func calculateXPoint( _ index : Int) -> CGFloat {
        return (marginX * CGFloat(index)) + 30
    }
    private func calculateYPoint( _ value : CGFloat) -> CGFloat {
        guard let currentIndex = orderedItems.firstIndex(where: {$0.value == value }) else {
            return 0.0
        }
        guard let maxIndex = orderedItems.firstIndex(where: {$0.value == max }) else {
            return 0.0
        }
        let diffIndex = maxIndex - currentIndex
        let diff = (bounds.height - 30) - ( marginY * CGFloat(abs(diffIndex)))
        return (bounds.height - 30) - diff
    }
}
