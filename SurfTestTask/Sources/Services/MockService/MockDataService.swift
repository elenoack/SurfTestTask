//
//  MockDataService.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import Foundation

// MARK: - MockDataServiceProtocol
protocol MockDataServiceProtocol {
    func createModels() -> [ContentModel]
}

// MARK: - MockService
final class MockDataService: MockDataServiceProtocol {

    func createModels() -> [ContentModel] {
        return [
            ContentModel(description: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                         direction: [.ios, .android, .design, .qa, .flutter, .pm]),
            ContentModel(description: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                         direction: [.ios, .android, .qa, .design, .pm, .flutter, .frontend, .backend, .react, .ruby])
        ]
    }

}
