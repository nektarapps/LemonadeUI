//
//  Lemonade+Progress+Chart.swift
//  LemonadeUI
//
//  Created by Mac on 17.09.2021.
//


public class LemonadeProgressChart : UIView {
    
    private var config : LemonadeProgressChartConfig?
    
    private var progressBars : [LemonadeProgressBar] = []
    private var progressLabels : [LemonadeLabel] = []
    
    private lazy var line_1 : UIView = {
        return .init(frame: .zero, color: config!.borderColor)
    }()
    private lazy var line_2 : UIView = {
        return .init(frame: .zero, color: config!.borderColor)
    }()
    private lazy var titleLabel : LemonadeLabel = {
        return .init(frame: .zero, config!.titleText!)
    }()
    
    public convenience init(frame : CGRect , _ config :  LemonadeProgressChartConfig) {
        self.init(frame:frame)
        self.configure(config)
    }
    deinit {
        config = nil
        zip(progressBars, progressLabels).forEach {
            $0.0.removeFromSuperview()
            $0.1.removeFromSuperview()
        }
        progressLabels.removeAll()
        progressBars.removeAll()
    }
    
    /// Spacing between bars
    private var spacing : CGFloat = 10
    
    /// Size of bar
    private var sizeOfBar : CGFloat {
        let spacing = spacing * 2
        switch config!.alignment {
        case .horizontal:
            let avaiableSpace = bounds.height - (CGFloat((config!.elements.count - 1)) * spacing)
            return avaiableSpace / CGFloat(config!.elements.count)
        case .vertical:
            let avaiableSpace = bounds.width - (CGFloat((config!.elements.count - 1)) * spacing)
            return avaiableSpace / CGFloat(config!.elements.count)
        }
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if progressBars.isEmpty {
            self.configureProgressBars()
        }
    }
}

extension LemonadeProgressChart {
    
    /// Configure of bars
    public func configure( _ config  : LemonadeProgressChartConfig) {
        self.config = config
        if config.titleText != nil { configureTitle() }
        self.configureBorders()
    }
    /**
     Add Percentage to current percantege of bar
     
     - parameter index: bar index.
     - parameter percentage: bar percentage.
     */
    public func addPercentage(index : Int , _ percentage : CGFloat) {
        if progressBars.isEmpty || index < 0 || index > progressBars.count { return }
        DispatchQueue.main.async {
            self.progressBars[index].addPercentage(percentage)
            self.progressLabels[index].text = "% \(Int(self.progressBars[index].currentPercentage))"
        }
    }
    /**
     Change percetange with exec param
     
     - parameter index: bar index.
     - parameter percentage: bar percentage.
     */
    public func changePercentage(index : Int , _ percentage : CGFloat) {
        if progressBars.isEmpty || index < 0 || index > progressBars.count { return }
        DispatchQueue.main.async {
            self.progressBars[index].updatePercanteage(percentage)
            self.progressLabels[index].text = "% \(Int(self.progressBars[index].currentPercentage))"
        }
    }
}
extension LemonadeProgressChart {
    
    /// Title configure if titleText
    private func configureTitle(){
        self.addSubview(titleLabel)
        titleLabel.centerX(self, equalTo: .centerX)
        titleLabel.leftAndRight(self)
        config!.alignment == .horizontal ? titleLabel.top(self, equalTo: .top) : titleLabel.bottom(self, equalTo: .bottom)
    }
    /// Border configure
    private func configureBorders(){
        self.addSubview(line_1)
        self.addSubview(line_2)
        switch config!.alignment {
        case .horizontal:
            line_1.top(config!.titleText == nil ? self : titleLabel, equalTo: config!.titleText == nil ? .top : .bottom)
            line_1.left(self, equalTo: .left)
            line_1.right(self, equalTo: .right)
            line_1.height(constant: 5)
            
            line_2.top(config!.titleText == nil ? self : titleLabel, equalTo: config!.titleText == nil ? .top : .bottom)
            line_2.bottom(self, equalTo: .bottom)
            line_2.left(self, equalTo: .left)
            line_2.width(constant: 5)
        case .vertical:
            line_1.bottom(config!.titleText == nil ? self : titleLabel, equalTo: config!.titleText == nil ? .bottom : .top)
            line_1.left(self, equalTo: .left)
            line_1.right(self, equalTo: .right)
            line_1.height(constant: 5)
            
            line_2.bottom(config!.titleText == nil ? self : titleLabel, equalTo: config!.titleText == nil ? .bottom : .top)
            line_2.top(self, equalTo: .top)
            line_2.left(self, equalTo: .left)
            line_2.width(constant: 5)
        }
    }
    /// Bars configures
    private func configureProgressBars(){
        guard let config = self.config , !config.elements.isEmpty else { return }
        for (index , element) in config.elements.enumerated() {
            let barConfig = LemonadeProgressBarConfig.init(alignment: config.alignment, textType: .custom(text: element.text), starterPercentage: element.percentage, progressView: element.progressView)
            let progressBar = LemonadeProgressBar.init(frame: .zero, barConfig)
            progressBar.tag = index
            progressBar.color(element.barColor)
            progressBar.radius(.init(radius: 12))
            self.addSubview(progressBar)
            // TO DO : Vertical ve horizontala göre yerleşim yapılması
            switch barConfig.alignment {
            case .horizontal:
                progressBar.left(line_2, equalTo: .right , constant: spacing)
                progressBar.right(self, equalTo: .right , constant: -spacing)
                progressBar.top(index == 0 ? line_1 : progressBars[index - 1], equalTo: .bottom , constant: spacing)
                progressBar.height(constant: sizeOfBar)
            case .vertical:
                progressBar.bottom(line_1, equalTo: .bottom , constant: -spacing)
                progressBar.left(index == 0 ? line_2 : progressBars[index - 1], equalTo: .right , constant: spacing)
                progressBar.top(self, equalTo: .top)
                progressBar.width(constant: sizeOfBar)
            }
            if config.isLinePercentangeShow {addPercentageLabel(progressBar: progressBar, element.percentage)}
            progressBars.append(progressBar)
        }
    }
    
    /// If isLinePercentangeShow true , this function create percentage label
    private func addPercentageLabel(progressBar : LemonadeProgressBar ,  _ percentange : CGFloat) {
        let label = LemonadeLabel.init(frame: .zero, .init(text: "% \(Int(percentange))" , color: .white , font: .systemFont(ofSize: UIFont.systemFontSize)))
        progressBar.addSubview(label)
        switch config!.alignment {
        case .vertical:
            label.top(progressBar, equalTo: .top , constant: 5)
            label.centerX(progressBar, equalTo: .centerX)
           // label.width(progressBar, equalTo: .width)
        case .horizontal:
            label.right(progressBar, equalTo: .right , constant: -5)
            label.centerY(progressBar, equalTo: .centerY)
        //s    label.width(progressBar, equalTo: .width , multiplier: 0.4)
        }
        progressLabels.append(label)
        progressBar.bringSubviewToFront(label)
    }
}
