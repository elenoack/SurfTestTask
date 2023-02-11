//
//  MainView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

enum Sections: Int {
    case single
    case double
}

final class MainView: UIView {

    // MARK: - Views
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = Images.background
        return view
    }()

    lazy var containerView = ContainerView()

    // MARK: - Constants
    var currentContainerHeight: CGFloat = 337
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    let defaultHeight: CGFloat = 337
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.background
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError(Strings.initError)
    }

    // MARK: - Configuration
    private func setupHierarchy() {
        addSubviewsForAutoLayout([
            backgroundImage,
            containerView,
        ])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                    constant: -184),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),

            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

            containerViewHeightConstraint = containerView.heightAnchor.constraint(
                equalToConstant: defaultHeight)
            containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
    }

}
