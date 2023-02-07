//
//  Constants.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

enum Constants {

    // MARK: - Strings
    enum Strings {
        static let initError: String = "init(coder:) has not been implemented"
        static let requestButtonTitle: String = "Хочешь к нам?"
        static let responseButtonTitle: String = "Отправить заявку"
        static let mainTitle: String = "Стажировка в Surf"
    }

    // MARK: - Fonts
    enum Fonts {
        static let title = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let mainTitle = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    // MARK: - Size
    enum Size {

        static let inset: CGFloat = 20
    }

    // MARK: - Colors
    enum Colors {
        static let gray = UIColor(hex: "#96959B")
        static let background = UIColor(hex: "#FFFFFF")
        static let darkGrey = UIColor(hex: "#313131")
        static let lightGray = UIColor(hex: "#F3F3F5")
    }

}



