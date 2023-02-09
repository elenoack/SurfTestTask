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
        didSet {
            switch mainButtonType {
            case .response:
                setTitleColor(Colors.darkGray, for: .highlighted)
                backgroundColor = isHighlighted ? Colors.lightGray : Colors.darkGray
            case .request:
                break
            }
        }
    }

    // MARK: - Initialization
    init(mainButtonType: MainButtonType) {
        self.mainButtonType = mainButtonType
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError(Strings.initError)
    }

    // MARK: - Configuration
    private func setupView() {
        switch mainButtonType {
        case .request:
            isEnabled = true
            layer.cornerRadius = 60/2
            setTitle(Strings.requestButtonTitle, for: .normal)
            setTitleColor(Colors.darkGray, for: .normal)
            titleLabel?.font = Fonts.title
            setContentHuggingPriority(.defaultHigh, for: .horizontal)
        case .response:
            isEnabled = true
            layer.cornerRadius = 60/2
            setTitle(Strings.responseButtonTitle, for: .normal)
            setTitleColor(Colors.background, for: .normal)
            titleLabel?.font = Fonts.buttonTitle
            backgroundColor = Colors.darkGray
        }
    }

}
