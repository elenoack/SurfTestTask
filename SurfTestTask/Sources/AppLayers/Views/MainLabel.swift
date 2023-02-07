//
//  MainLabel.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

enum MainLabelType {
    case title
    case description
    case content
}

final class MainLabel: UILabel {
    private var mainLabelType: MainLabelType
    
    // MARK: - Initialization
    init(mainLabelType: MainLabelType) {
        self.mainLabelType = mainLabelType
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Strings.initError)
    }
    
    // MARK: - Configuration
    private func setupView() {
        switch mainLabelType {
        case .title:
            textAlignment = .left
            font = Constants.Fonts.mainTitle
            textColor = Constants.Colors.darkGrey
            text = Constants.Strings.mainTitle
        case .description:
            textAlignment = .left
            font = Constants.Fonts.title
            numberOfLines = 0
            textColor = Constants.Colors.gray
        case .content:
            textAlignment = .left
            font = Constants.Fonts.title
            textColor = Constants.Colors.darkGrey
        }
    }
    
}
