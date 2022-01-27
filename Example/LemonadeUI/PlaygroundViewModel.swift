//
//  PlaygroundViewModel.swift
//  LemonadeUI_Example
//
//  Created by Özgür Elmaslı on 25.01.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import LemonadeUI


class PlaygroundViewModel {
    let headerViewIdentifier: String = UUID().uuidString
    let buttonCellIdentifier: String = UUID().uuidString
    let sliderCellIdentifier: String = UUID().uuidString
    
    private var data: [SectionModel] = []
    private var alertManager: LemonadeAlertManager = .init()
    
    init() {
        configureAlerts()
    }
    
    private func configureAlerts(){
        let alertSection: SectionModel = .init(section: .alert, rows:[
            .alert(alert: .defaultAlert),
            .alert(alert: .toast),
            .alert(alert: .custom)
        ])
        let chartSection: SectionModel = .init(section: .chart, rows: [.chart])
        let customShapesSection: SectionModel = .init(section: .custom, rows: [ .customShapes(shape: .flower) , .customShapes(shape: .lotus) , .customShapes(shape: .customSegmentControl)])
        let sliderSection: SectionModel = .init(section: .sliders, rows: [
            .slider(thumbCount: 1),
            .slider(thumbCount: 2)
        ])
        let inputSection: SectionModel = .init(section: .inputTypes, rows: [
            .inputs(type: .searchBar),
            .inputs(type: .inputs)
        ])
        data.append(alertSection)
        data.append(chartSection)
        data.append(customShapesSection)
        data.append(sliderSection)
        data.append(inputSection)
    }
    
    func numberOfSections() -> Int { return data.count }
    func numberOfItemInSection(section:Int) -> Int { return data[section].rows.count }
    func cellForItem(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let section: SectionType = data[indexPath.section].section
        switch section {
        case .sliders:
            return cellForSliderCell(tableView: tableView, indexPath: indexPath)
        case .alert,.chart , .custom,.inputTypes:
            return cellForButtonCell(tableView: tableView, indexPath: indexPath)
        }
    }
    func headerForItem(tableView: UITableView, section: Int) -> UITableViewHeaderFooterView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as? PlaygroundHeaderView else { return nil }
        headerView.configureUI(text: data[section].section.sectionTitle)
        return headerView
    }
    func didSelect(indexPath: IndexPath, _ presenter: UIViewController) {
        let section = data[indexPath.section].section
        switch section {
        case .alert,.chart,.custom,.inputTypes:
            didSelectButtonCell(indexPath: indexPath, presenter)
        default:
            break
        }
    }
}
extension PlaygroundViewModel {
    private func didSelectButtonCell(indexPath: IndexPath, _ presenter: UIViewController) {
        let selectedRow = data[indexPath.section].rows[indexPath.row]
        let titleText: LemonadeText = .init(text: "Default Title Alert"
                                            , color: .black
                                            , font: .systemFont(ofSize: 20)
                                            , alignment: .center)
        let message: LemonadeText = .init(text: "Default Meesage"
                                          , color: .black.withAlphaComponent(0.5)
                                          , font: .systemFont(ofSize: 16)
                                          , alignment: .center)
        switch selectedRow {
        case .customShapes(let shape):
            let vc = shape == .lotus ? LotusVC() : shape == .flower ? FlowerVC() : CustomSegmentControl(viewModel: .init())
            presenter.navigationController?.pushViewController(vc, animated: true)
        case .chart:
            presenter.navigationController?.pushViewController(ChartVC(), animated: true)
        case .alert(let alert):
            switch alert {
            case .custom:
                let button: LemonadeButton = .init(frame: .zero, color: .init(backgroundColor: .orange)
                                                   , radius: .init(radius: 12), border: .init(borderColor: .black, width: 2.0))
                button.onClick { [weak self] in
                    self?.alertManager.dismiss(presenter: presenter)
                }
                button.text(message)
                alertManager.showCustomPopup(components: [
                    .label(text: titleText),
                    .label(text: message),
                    .spacer(height: 20),
                    .singleButton(button: button)
                ], animation: .fade(position: .bottom), presenter: presenter)
            case .toast:
                alertManager.showToastMessage(message: titleText, position: .top, presenter: presenter, dismissDuration: 2)
            case .defaultAlert:
                alertManager.showDefaultAlert(title: titleText, message: message, presenter: presenter)
            }
        case .slider:
            break
        case .inputs(let type):
            // If check for types
            presenter.navigationController?.pushViewController(SearchVC(viewModel: .init()), animated: true)
            break
        }
    }
    private func cellForButtonCell(tableView:UITableView, indexPath:IndexPath) -> ButtonTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifier) as? ButtonTableViewCell else { return nil }
        let row = data[indexPath.section].rows[indexPath.row]
        switch row {
        case .alert(let alert):
            cell.configureUI(text: .init(text: alert.title , color: .white , font: .systemFont(ofSize: 16)), backgroundColor: alert.backgrouncColor)
        case .chart:
            cell.configureUI(text: .init(text: "Move to charts", color: .white, font: .systemFont(ofSize: 16), alignment: .center), backgroundColor: .systemPink)
        case .customShapes(let shape):
            cell.configureUI(text: .init(text: shape.title , color: .white , font: .systemFont(ofSize: 16)) , backgroundColor: shape.backgrouncColor)
        case .inputs(let type):
            cell.configureUI(text: .init(text: type.title , color: .white , font: .systemFont(ofSize: 16)), backgroundColor: type.backgrouncColor)
        default: break
        }
        return cell
    }
    private func cellForSliderCell(tableView:UITableView, indexPath:IndexPath) -> SliderTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sliderCellIdentifier) as? SliderTableViewCell else { return nil }
        let row = data[indexPath.section].rows[indexPath.row]
        switch row {
        case .slider(let thumbCount):
            cell.configureUI(thumbCount: thumbCount)
        default: break
        }
        return cell
    }
}
extension PlaygroundViewModel {
    enum AlertRow {
        case defaultAlert
        case toast
        case custom
        
        var title: String {
            switch self {
            case .defaultAlert:
                return "Default Alert Type"
            case .toast:
                return "Toast Alert Type"
            case .custom:
                return "Custom Alert Type"
            }
        }
        
        var backgrouncColor: UIColor {
            switch self {
            case .defaultAlert:
                return .systemGreen
            case .toast:
                return .systemBlue
            case .custom:
                return .systemRed
            }
        }
    }
    
    enum CustomShapeRow {
        case flower
        case lotus
        case customSegmentControl
        
        var title: String {
            switch self {
            case .flower:
                return "Flower"
            case .lotus:
                return "Lotus"
            case .customSegmentControl:
                return "Custom Segmet Control"
            }
        }
        
        var backgrouncColor: UIColor {
            switch self {
            case .flower:
                return .systemTeal
            case .lotus:
                return .systemGray
            case .customSegmentControl:
                return .purple
            }
        }
    }
    
    enum InputTypeRow {
        case searchBar
        case inputs
        
        var title: String {
            switch self {
            case .searchBar:
                return "Search Bar"
            case .inputs:
                return "Inputs"
            }
        }
        
        var backgrouncColor: UIColor {
            switch self {
            case .searchBar:
                return .red
            case .inputs:
                return .orange
            }
        }
    }
    
    enum SectionType {
        case alert
        case chart
        case custom
        case sliders
        case inputTypes
        
        var sectionTitle: String {
            switch self {
            case .alert:
                return "Alert Types"
            case .chart:
                return "Chart"
            case .custom:
                return "Custom Shapes"
            case .sliders:
                return "Slider Types"
            case .inputTypes:
                return "Input Types"
            }
        }
    }
    enum RowType {
        case alert(alert: AlertRow)
        case chart
        case customShapes(shape: CustomShapeRow)
        case slider(thumbCount:Int)
        case inputs(type : InputTypeRow)
    }
    struct SectionModel {
        var section: SectionType
        var rows: [RowType]
    }
}
