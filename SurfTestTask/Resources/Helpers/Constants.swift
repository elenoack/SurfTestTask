//
//  Constants.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

// MARK: - Strings
enum Strings {
    static let initError: String = "init(coder:) has not been implemented"
    static let requestButtonTitle: String = "Хочешь к нам?"
    static let responseButtonTitle: String = "Отправить заявку"
    static let mainTitle: String = "Стажировка в Surf"
    static let congratulations: String = "Поздравляем!"
    static let alertMessage: String = "Ваша заявка успешно отправлена!"
    static let close: String = "Закрыть"
}

// MARK: - Fonts
enum Fonts {
    static let title = UIFont(name: "SFProDisplay-Regular", size: 14)
    static let mainTitle = UIFont(name: "SFProDisplay-Bold", size: 24)
    static let cellName = UIFont(name: "SFProDisplay-Medium", size: 14)
    static let buttonTitle = UIFont(name: "SFProDisplay-Medium", size: 16)
}

// MARK: - Colors
enum Colors {
    static let gray = UIColor(hex: "#96959B")
    static let background = UIColor(hex: "#FFFFFF")
    static let darkGray = UIColor(hex: "#313131")
    static let lightGray = UIColor(hex: "#F3F3F5")
}
