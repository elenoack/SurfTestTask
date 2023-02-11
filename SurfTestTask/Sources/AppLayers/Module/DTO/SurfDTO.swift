//
//  SurfDTO.swift
//  SurfTestTask
//
//  Created by Elena Noack on 09.02.23.
//

import Foundation

enum SurfDTO {

    enum GetContent {

        struct Request {}
        
        struct Response {
            let result: [ContentModel]
        }

        struct ViewModel {}
    }

}
