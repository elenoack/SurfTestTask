//
//  HeaderView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

// MARK: - CollectionViewHeaderConfigurableProtocol
protocol CollectionViewHeaderConfigurableProtocol where Self: UICollectionReusableView {
    func configure(with viewModel: ViewModel?)
}

// MARK: - CollectionViewHeaderModel
struct CollectionViewHeaderModel: ViewModel {
    let description: String?
}

final class HeaderView: UICollectionReusableView {

    // MARK: - Views
    lazy var titleLabel = MainLabel(mainLabelType: .description)

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierachy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError(Strings.initError)
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

// MARK: - CollectionViewHeaderConfigurableProtocol
extension HeaderView: CollectionViewHeaderConfigurableProtocol {

    func configure(with viewModel: ViewModel?) {
        guard let viewModel = viewModel as? CollectionViewHeaderModel else { return }
        self.titleLabel.text = viewModel.description
    }

}
