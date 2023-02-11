//
//  ContainerView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class ContainerView: UIView {

    // MARK: - Properties
    var countOfDoubleVM = 0
    
    // MARK: - Views
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: self.bounds,
            collectionViewLayout: createLayout())
        collectionView.allowsMultipleSelection = true
        collectionView.register(CollectionCell.self)
        collectionView.registerHeader(HeaderView.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var stackView = ButtonsStackView()
    private lazy var titleLabel = MainLabel(mainLabelType: .title)

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError(Strings.initError)
    }

    // MARK: - Configuration
    private func setupView() {
        layer.cornerRadius = Constants.viewCornerRadius
        clipsToBounds = true
        backgroundColor = Colors.background
    }

    private func setupHierarchy() {
        addSubviewsForAutoLayout([
            titleLabel,
            collectionView,
            stackView
        ])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                            constant: Constants.insetTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Constants.inset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Constants.inset),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Constants.insetInside),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.inset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.inset),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor,
                                                   constant: -Constants.insetBottom),

            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                              constant: -Constants.inset),
            stackView.heightAnchor.constraint(equalToConstant: Constants.buttomHeight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Constants.inset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Constants.inset),
        ])
    }

}

// MARK: - UICollectionViewLayout

extension ContainerView {

    private func createLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout { [self]
            (sectionIndex: Int,
             layoutEnvironment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in

            guard let sectionLayout = Sections(rawValue: sectionIndex)
            else { return nil }

            switch sectionLayout {
            case .single:
                return self.singleSection()
            case .double:
                return self.doubleSection()
            }
        }
        return layout
    }

}

// MARK: - NSCollectionLayoutSection - FirstSection

extension ContainerView {

    private func singleSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Constants.cellWidth),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Constants.cellWidth),
            heightDimension: .absolute(Constants.cellHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.insetInside,
            leading: .zero,
            bottom: .zero,
            trailing: .zero)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = Constants.insetInside
        section.contentInsets.bottom = Constants.insetTop
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.headerHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }

    private func doubleSection() -> NSCollectionLayoutSection {

        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Constants.cellWidth),
            heightDimension: .absolute(Constants.cellHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: .fixed(Constants.insetInside),
            trailing: .fixed(Constants.insetInside),
            bottom: nil
        )
        let subGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(Constants.cellHeight)
            ),
            subitems: [item]
        )
        let groupHeight = (Constants.cellHeight * 2) + (Constants.insetInside + 2)

        let cellsWidth = CGFloat(countOfDoubleVM)/2
        let groupWidth = cellsWidth * Constants.cellWidthMax + Constants.insetInside * cellsWidth + Constants.inset * 4

        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .estimated(groupHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupLayoutSize,
            repeatingSubitem: subGroup,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.headerHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

}

// MARK: - Constants
fileprivate enum Constants {
    static let viewCornerRadius: CGFloat = 26
    static let cellWidth: CGFloat = 68
    static let cellWidthMax: CGFloat = 80
    static let cellHeight: CGFloat = 44
    static let insetTop: CGFloat = 24
    static let insetBottom: CGFloat = 32
    static let inset: CGFloat = 20
    static let buttomHeight: CGFloat = 60
    static let insetInside: CGFloat = 12
    static let headerHeight: CGFloat = 80
}
