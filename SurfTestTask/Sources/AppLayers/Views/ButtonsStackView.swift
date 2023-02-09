//
//  ButtonsStackView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class ButtonsStackView: UIStackView {

    // MARK: - Action
    static var responseCompletion: (() -> Void)?

    // MARK: - Views
    private lazy var requestButton: MainButton = MainButton(mainButtonType: .request)
    private lazy var responseButton: MainButton = {
        let button = MainButton(mainButtonType: .response)
        button.addTarget(self,
                         action: #selector(handleResponse),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupHierachy()
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError(Strings.initError)
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
        spacing = 20
        axis = .horizontal
    }

}

// MARK: - Private
extension ButtonsStackView {

    @objc
    private func handleResponse() {
        ButtonsStackView.responseCompletion?()
    }

}
