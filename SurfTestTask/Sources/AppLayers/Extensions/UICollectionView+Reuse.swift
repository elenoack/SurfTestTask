//
//  UICollectionView+Reuse.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

protocol ReusableView: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

extension UICollectionReusableView: ReusableView {}

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    func registerHeader(_ viewClass: UICollectionReusableView.Type) {
        register(viewClass,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: viewClass.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                   for: indexPath) as? T ?? T()
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(_ viewClass: T.Type,
                                                            for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewClass.reuseIdentifier,
            for: indexPath) as? T ?? T()
    }
    
}
