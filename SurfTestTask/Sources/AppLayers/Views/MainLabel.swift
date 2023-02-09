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
        fatalError(Strings.initError)
    }
    
    // MARK: - Configuration
    private func setupView() {
        switch mainLabelType {
        case .title:
            textAlignment = .left
            font = Fonts.mainTitle
            textColor = Colors.darkGray
            text = Strings.mainTitle
        case .description:
            textAlignment = .left
            font = Fonts.title
            numberOfLines = 0
            textColor = Colors.gray
        case .content:
            textAlignment = .left
            font = Fonts.cellName
            textColor = Colors.darkGray
        }
    }
    
}
