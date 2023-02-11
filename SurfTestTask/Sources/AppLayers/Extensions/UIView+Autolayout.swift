//
//  UIView+Autolayout.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

extension UIView {

    func addSubviewsForAutoLayout(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}

extension UIStackView {

    func addArrangedSubviewsForAutoLayout(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }

}
