//
//  Alertable.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/17/24.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default
            )
        )
        
        self.present(alert, animated: true, completion: completion)
    }
}
