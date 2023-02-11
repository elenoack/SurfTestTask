//
//  ContentModel.swift
//  SurfTestTask
//
//  Created by Elena Noack on 07.02.23.
//

import Foundation

struct ContentModel {
    let description: String
    let direction: [Types]

    enum Types: String {
        case ios = "iOS"
        case android = "Android"
        case design = "Design"
        case flutter = "Flutter"
        case qa = "QA"
        case pm = "PM"
        case frontend = "Frontend"
        case backend = "Backend"
        case react = "React"
        case ruby = "Ruby"
    }

}
