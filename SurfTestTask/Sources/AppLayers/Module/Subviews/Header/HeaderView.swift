//
//  HeaderView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    static let id = "Header"

    // MARK: - Views
    lazy var titleLabel = MainLabel(mainLabelType: .description)

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
}

// MARK: - Configuration
extension HeaderView {

    func setupHierachy() {
        addSubviewsForAutoLayout([
            titleLabel
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
