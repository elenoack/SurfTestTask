//
//  ButtonsStackView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class ButtonsStackView: UIStackView {

    // MARK: - Views
    private lazy var requestButton = MainButton(mainButtonType: .request)
    private lazy var responseButton = MainButton(mainButtonType: .response)

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupHierachy()
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError(Constants.Strings.initError)
    }

    // MARK: - Configuration
    private func setupHierachy() {
        addArrangedSubviewsForAutoLayout([
            requestButton,
            responseButton
        ])
    }

    private func setupView() {
        alignment = .fill
        distribution = .fill
        spacing = Constants.Size.inset
        axis = .horizontal
    }

}
