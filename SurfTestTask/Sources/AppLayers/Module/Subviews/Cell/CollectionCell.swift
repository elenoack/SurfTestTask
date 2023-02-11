//
//  TextCell.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

// MARK: - ViewModel
protocol ViewModel {}

// MARK: - CollectionViewCellConfigurableProtocol
protocol CollectionViewCellConfigurableProtocol where Self: UICollectionViewCell {
    func configure(with viewModel: ViewModel?)
}

// MARK: - CollectionViewCellModel
struct CollectionViewCellModel: ViewModel {
    let content: String?
}

// MARK: - CollectionCell
final class CollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var isCellColor: Bool { return self.backgroundColor == Colors.darkGray }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isCellColor ? Colors.lightGray : Colors.darkGray
            dataLabel.textColor = isCellColor ? Colors.lightGray : Colors.darkGray
        }
    }

    // MARK: - Views
    lazy var dataLabel = MainLabel(mainLabelType: .content)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.lightGray
        layer.cornerRadius = 12
        setupHierachy()
        setupLayout()
    }
    
    required init?(coder Decoder: NSCoder) {
        fatalError(Strings.initError)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = Colors.lightGray
        dataLabel.textColor = Colors.darkGray
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
        ])
    }
    
}

// MARK: - CollectionViewCellConfigurableProtocol
extension CollectionCell: CollectionViewCellConfigurableProtocol {
    
    func configure(with viewModel: ViewModel?) {
        guard let viewModel = viewModel as? CollectionViewCellModel else { return }
        self.dataLabel.text = viewModel.content
    }
    
}
