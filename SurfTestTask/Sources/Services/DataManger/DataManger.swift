//
//  DataManger.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

// MARK: - DataManagerProtocol
protocol DataManagerProtocol {
    func createModels() -> [ContentModel]
}

// MARK: - DataManger
final class DataManger: DataManagerProtocol {
    
    func createModels() -> [ContentModel] {
        return [
            ContentModel(description: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                         direction: [.iOS, .Android, .Design, .QA, .Flutter, .PM]),
            ContentModel(description: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                         direction: [.iOS, .Android, .Design, .QA, .Flutter, .PM,])
        ]
    }
    
}
