//
//  TextCell.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class CollectionCell: UICollectionViewCell {

    // MARK: - Views
    lazy var dataLabel = MainLabel(mainLabelType: .content)

    var isEnabled: Bool = false {
        didSet {
            backgroundColor = Constants.Colors.darkGrey
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Constants.Colors.lightGray
        layer.cornerRadius = 12
        setupHierachy()
        setupLayout()
    }

    required init?(coder Decoder: NSCoder) {
        fatalError(Constants.Strings.initError)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dataLabel.text = nil
    }
    
}

// MARK: - Configuration
extension CollectionCell {
    
    func setupHierachy() {
        addSubviewsForAutoLayout([
            dataLabel
        ])
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            dataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            dataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            dataLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }

}
