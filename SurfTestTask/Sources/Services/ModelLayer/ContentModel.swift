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
      case iOS, Android, Design, QA, Flutter, PM
    }

}
