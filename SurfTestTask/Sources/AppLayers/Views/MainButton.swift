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
    private var mainButtonType: MainButtonType

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
            layer.cornerRadius = 60/2
            setTitle(Constants.Strings.requestButtonTitle, for: .normal)
            setTitleColor(Constants.Colors.darkGrey, for: .normal)
            titleLabel?.font = Constants.Fonts.title
            setContentHuggingPriority(.defaultHigh, for: .horizontal)
        case .response:
            layer.cornerRadius = 60/2
            setTitle(Constants.Strings.responseButtonTitle, for: .normal)
            setTitleColor(Constants.Colors.background, for: .normal)
            titleLabel?.font = Constants.Fonts.title
            backgroundColor = Constants.Colors.darkGrey
        }
    }

}
