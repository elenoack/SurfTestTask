//
//  DataManger.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import UIKit

class DataManger {

    static let shared = DataManger()

    func createModels() -> [ContentModel] {
        return [
            ContentModel(description: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                          direction: [.iOS, .Android, .Design, .QA, .Flutter, .PM]),
            ContentModel(description: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                          direction: [.iOS, .Android, .Design, .QA, .Flutter, .PM, .iOS, .Android, .Design, .QA])
            ]
    }

}
