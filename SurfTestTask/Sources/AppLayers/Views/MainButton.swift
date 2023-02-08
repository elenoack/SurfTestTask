//
//  MainButton.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

enum MainButtonType {
    case request
    case response
}

final class MainButton: UIButton {

    // MARK: - Properties
    private var mainButtonType: MainButtonType

    override var isHighlighted: Bool {
        willSet {
            switch mainButtonType {
            case .request:
                titleLabel?.textColor = Constants.Colors.darkGrey
            case .response:
                setTitleColor(Constants.Colors.darkGrey, for: .highlighted)

            }
        }
    }

//    override var isSelected: Bool {
//        willSet {
//            switch mainButtonType {
//            case .request:
//                print("isSelected")
//                titleLabel?.textColor = Constants.Colors.darkGrey
//            case .response:
//                print("cxc")
//                titleLabel?.textColor = Constants.Colors.darkGrey
//                backgroundColor = Constants.Colors.darkGrey
//            }
//        }
//    }


    // MARK: - Initialization
    init(mainButtonType: MainButtonType) {
        self.mainButtonType = mainButtonType
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.Strings.initError)
    }

    // MARK: - Configuration
    private func setupView() {
        switch mainButtonType {
        case .request:
            isEnabled = true
            layer.cornerRadius = 60/2
            setTitle(Constants.Strings.requestButtonTitle, for: .normal)
            setTitleColor(Constants.Colors.darkGrey, for: .normal)
            titleLabel?.font = Constants.Fonts.title
            setContentHuggingPriority(.defaultHigh, for: .horizontal)
        case .response:
            isEnabled = true
            layer.cornerRadius = 60/2
            setTitle(Constants.Strings.responseButtonTitle, for: .normal)
            setTitleColor(Constants.Colors.background, for: .normal)
            titleLabel?.font = Constants.Fonts.title
            backgroundColor = Constants.Colors.darkGrey
        }
    }

}
