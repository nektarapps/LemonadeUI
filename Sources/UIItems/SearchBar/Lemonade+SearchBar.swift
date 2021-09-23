//
//  Lemonade+SearchBar.swift
//  LemonadeUI
//
//  Created by Mac on 21.09.2021.
//

public protocol LemonadeSearchBarDelegate : AnyObject {
    /// SearchBar text did change
    func searchBarDidChange( _ searchBar : LemonadeSearchBar , text : String )
    
    /// Keyboard search button tapped
    func searchButtonTapped( _ searchBar : LemonadeSearchBar , text : String )
    
    /// Triggered When Searching state change
    func searchingStateChanged( _ searchBar : LemonadeSearchBar , state : LemonadeSearchState)
    
    /// Triggered when buttnos tapped (if exists)
    func buttonsTapped( _ searchBar : LemonadeSearchBar , button : LemonadeButton)
}

public class LemonadeSearchBar : UIView {
    
    /// Searching change state
    public var searchingState : LemonadeSearchState = .NotFocuessed {
        didSet {
            DispatchQueue.main.async {
                self.lemonadeSearchBarDelegate?.searchingStateChanged(self, state: self.searchingState)
            }
        }
    }
    /// Padding betwe
    public var paddingBetweenItems : CGFloat = 5.0
    
    /// Addtional buttons
    private(set) var buttons : [LemonadeButton] = []
    
    /// SearchBar Delegate
    public weak var lemonadeSearchBarDelegate : LemonadeSearchBarDelegate?
    
    /// Config
    private var config : LemonadeSearchBarConfig?
    
    
    public lazy var searchBarTextfield : LemonadeTextfield = {
        return placeholder == nil ? .init(frame: .zero, text: text!) : .init(frame: .zero, text: text!, placeholder: placeholder!)
    }()
    private lazy var leftView : UIView = {
        let view : UIView = .init(frame:CGRect(x: 0, y: 0, width: 40, height: 37), color: .init(backgroundColor: .clear))
        let imageView = UIImageView.init(image: config!.leftImage!.withRenderingMode(.alwaysTemplate))
        imageView.frame = CGRect(x: 16, y: (37/2) - 10, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        view.addSubview(imageView)
        return view
    }()
    private lazy var rigthView : UIView = {
        let view : UIView = .init(frame:CGRect(x: 0, y: 0, width: 40, height: 37), color: .init(backgroundColor: .clear))
        let imageView = UIImageView.init(image: config!.rigthImage!.withRenderingMode(.alwaysTemplate))
        imageView.frame = CGRect(x: 16, y: (37/2) - 10, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        view.addSubview(imageView)
        return view
    }()
    
    
    private var text : LemonadeText?
    private var placeholder : LemonadeText?
    
    public convenience init(frame : CGRect
                            , text : LemonadeText
                            , placeholder : LemonadeText
                            , config : LemonadeSearchBarConfig) {
        self.init(frame:frame)
        self.configure(text: text, placeholder: placeholder, config)
    }
    
    deinit {
        searchBarTextfield.delegate = nil
        lemonadeSearchBarDelegate = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.configureLayout()
    }
    
}

extension LemonadeSearchBar {
    
    
    /**
     Configure function with params
     
     - parameter Text: Active text.
     - parameter Placeholder: Placeholder text.
     - parameter Config: SearchBar config.
     */
    public func configure( text : LemonadeText , placeholder :LemonadeText? = nil , _ config : LemonadeSearchBarConfig) {
        self.config = config
        self.text = text
        self.placeholder = placeholder
        self.configureTextField()
    }
    private func configureTextField(){
        searchBarTextfield.autocorrectionType = .no
        searchBarTextfield.returnKeyType = .search
        searchBarTextfield.delegate = self
        if config!.leftImage != nil || config!.leftView != nil {
            searchBarTextfield.leftView = config!.leftView == nil ? leftView : config!.leftView!
            searchBarTextfield.leftViewMode = .always
        }
        
        if config!.rigthImage != nil || config!.rigthView != nil {
            searchBarTextfield.rightView = config!.rigthView == nil ? rigthView : config!.rigthView!
            searchBarTextfield.rightViewMode = .always
        }
        
        searchBarTextfield.addTarget(self, action: #selector(textDidChange(textfield:)), for: .editingChanged)
        searchBarTextfield.addTarget(self, action: #selector(searchBarButtonTapped(textfield:)), for: .editingDidEndOnExit)
    }
    private func configureLayout(){
        guard let config = self.config else { return }
        self.addSubview(searchBarTextfield)
        searchBarTextfield.centerY(self, equalTo: .centerY)
        searchBarTextfield.height(self, equalTo: .height , multiplier: 0.5)
        if !config.buttons.isEmpty {
            let totalButtonWidth = bounds.width * 0.3
            let perButtonWidth = totalButtonWidth / CGFloat(config.buttons.count)
            for (index , button) in config.buttons.enumerated() {
                self.addSubview(button)
                button.centerY(searchBarTextfield, equalTo: .centerY)
                button.width(constant: perButtonWidth)
                button.height(searchBarTextfield, equalTo: .height)
                if index == 0 {
                    config.buttonPositions == .left
                        ? button.left(self, equalTo: .left , constant: paddingBetweenItems)
                        : button.right(self, equalTo: .right , constant: -paddingBetweenItems)
                }else {
                    config.buttonPositions == .left
                        ? button.left(self.buttons[index - 1], equalTo: .right , constant: paddingBetweenItems)
                        : button.right(self.buttons[index - 1], equalTo: .left , constant: -paddingBetweenItems)
                }
                
                self.buttons.append(button)
                
                button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            }
            if config.buttonPositions == .left {
                searchBarTextfield.left(config.buttons[config.buttons.count - 1], equalTo: .right , constant: paddingBetweenItems)
                searchBarTextfield.right(self, equalTo: .right , constant: -paddingBetweenItems)
            }else {
                searchBarTextfield.left(self, equalTo: .left , constant: paddingBetweenItems)
                searchBarTextfield.right(config.buttons[config.buttons.count - 1], equalTo: .left , constant: -paddingBetweenItems)
            }
        }else {
            searchBarTextfield.leftAndRight(self , constant: paddingBetweenItems)
        }
    }
}
extension LemonadeSearchBar : UITextFieldDelegate {
    @objc func textDidChange(textfield: UITextField){
        let isActive = textfield.text!.isEmpty
        self.searchingState = isActive ? .Focussed : .isSearching
        self.lemonadeSearchBarDelegate?.searchBarDidChange(self, text: textfield.text ?? "")
    }
    @objc func searchBarButtonTapped(textfield: UITextField){
        self.searchingState = .Focussed
        self.lemonadeSearchBarDelegate?.searchButtonTapped(self, text: textfield.text ?? "")
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchingState = .isSearching
    }
    @objc func buttonTapped(button : LemonadeButton) {
        self.lemonadeSearchBarDelegate?.buttonsTapped(self, button: button)
    }
}
