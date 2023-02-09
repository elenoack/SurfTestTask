//
//  Alert+Extensions.swift
//  SurfTestTask
//
//  Created by Elena Noack on 08.02.23.
//

import UIKit

extension UIViewController {

    func showAlert(title: String?,
                   message: String? = nil,
                   actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: Strings.close, style: .cancel, handler: nil))
        }

        present(alert, animated: true, completion: nil)
    }

}

