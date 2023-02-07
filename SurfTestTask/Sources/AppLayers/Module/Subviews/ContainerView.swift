//
//  ContainerView.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

final class ContainerView: UIView {
    
    // MARK: - Views
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout())
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
        collectionView.register(CollectionCell.self)
        collectionView.registerHeader(HeaderView.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private lazy var titleLabel = MainLabel(mainLabelType: .title)
    private lazy var stackView = ButtonsStackView()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.Strings.initError)
    }

    // MARK: - Configuration
    private func setupView() {
        layer.cornerRadius = 26
        clipsToBounds = true
        backgroundColor = Constants.Colors.background
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
                                            constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Constants.Size.inset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Constants.Size.inset),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constants.Size.inset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.Size.inset),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor,
                                                   constant: -32),

            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                              constant:  -Constants.Size.inset),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Constants.Size.inset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Constants.Size.inset),
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

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 6,
            leading: 0,
            bottom: 0,
            trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 6,
            leading: 0,
            bottom: 0,
            trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                       leading: 0,
                                                       bottom: 12,
                                                       trailing: 0)
        header.zIndex = Int.max
        section.boundarySupplementaryItems = [header]
        return section

    }

    private func doubleSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 12,
            leading: 0,
            bottom: 0,
            trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .absolute(55))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)

        // item spacing
        //        group.interItemSpacing = .fixed(12)

        // group spacing

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 12,
            leading: 0,
            bottom: 0,
            trailing: 0)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        header.zIndex = Int.max
        section.boundarySupplementaryItems = [header]
        return section
    }

}


