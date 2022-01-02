//
//  PopupManager.swift
//  LemonadeUI
//
//  Created by Özgür Elmaslı on 2.01.2022.
//

public class LemonadeAlertManager {
    public init() { }
}
extension LemonadeAlertManager {
    
    public func showDefaultAlert(title: LemonadeText, message: LemonadeText, closeButtonText: LemonadeText = .init(text: "Close", color: .systemBlue, font: .systemFont(ofSize: 20), alignment: .center), presenter: UIViewController) {
        let closeButton = LemonadeButton.init(frame: .zero, closeButtonText) { [weak self] in
            self?.dismiss(presenter: presenter)
        }
        let components: [LemonadePopupComponents] = [
            .label(text: title),
            .label(text: message),
            .spacer(height: 20),
            .singleButton(button: closeButton)
        ]
        let popupVC = LemonadePopupController(configuration: .init(components: components, animation: .slideToCenter(from: .right) , margin: 24))
        show(presenter: presenter, popup: popupVC)
    }
    
    public func showToastMessage(message: LemonadeText, position: LemonadePosition, presenter: UIViewController, dismissDuration: CGFloat) {
        let popupVC = LemonadePopupController(configuration: .init(components: [.label(text: message)], animation: .fade(position: position)))
        show(presenter: presenter, popup: popupVC)
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) {
            self.dismiss(presenter: presenter)
        }
    }
    
    public func showCustomPopup(components: [LemonadePopupComponents]
                                , backgroundColor: LemonadeColor = .init(backgroundColor: .white)
                                , radius: LemonadeRadius = .init(radius: 12)
                                , animation: LemonadePopupAnimation
                                , animationDuration: CGFloat = 0.5
                                , margin: CGFloat = 0.0
                                , presenter: UIViewController) {
        let configuration = LemonadePopupConfiguration(components: components, backgroundColor: backgroundColor, radius: radius, animation: animation, animationDuration: animationDuration, margin: margin)
        let popupVC = LemonadePopupController(configuration: configuration)
        show(presenter: presenter, popup: popupVC)
    }
    
    
    public func dismiss(presenter: UIViewController){
        guard let child = presenter.children.first(where: {$0.isKind(of: LemonadePopupController.self)}) as? LemonadePopupController else { return }
        child.hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                child.view.layer.opacity = 0.0
            } completion: { _ in
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    
    public func show(presenter: UIViewController, popup: LemonadePopupController) {
        popup.view.layer.opacity = 0.0
        presenter.addChild(popup)
        presenter.view.addSubview(popup.view)
        UIView.animate(withDuration: 0.2) {
            popup.view.layer.opacity = 1.0
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                popup.show()
            }
        }
    }
    
    
}

